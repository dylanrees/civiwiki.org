var collectionTemplate = _.template($('#collection-template').html());

// var Civi = Backbone.Model.extend({
//
// 	loadChildren: function() {
// 		this.children = new CiviChainCol({civiParent:this.id}); //implement later
// 	}
//
// });

// var CiviChainCol = Backbone.Collection.extend({
//
// 	parse: function(response) {
// 		this.currentOffset += _.count(response.result);
// 		this.loadMore = response.has_more;
// 		return _.map(response.result, function(civi, i, arr){ return new Civi(civi); });
// 	},
//
// 	currentOffset: 0,
//
// 	loadMore: true //this will eventually prevent the collection from requesting civis beyond the currentOffset
// });

var ArticlesCol = Backbone.Collection.extend({

	url: '/api/articles',
	pID: 0,

	parse: function(response) {
		return _.map(response.result, function (art) {
			return new Backbone.Model($.extend(art, {
				pID: this.pID,
				active: false
			}));
		});
	}

});

var CategoriesCol = Backbone.Collection.extend({

	url: '/api/categories',

	parse: function(response) {
		return _.map(response.result, function(cat) {
			return new Backbone.Model($.extend(cat, {
				active: false
			}));
		});
	}

});

var nest = function(info) {
	_.each(info.child.models, function(elem) {
		elem.set({
			pID: info.child.pID
		});
	});

	this.set({
		child: info.child,
		nestData: {
			collectionName: info.name,
			levelTitle: info.title,
			collectionType: info.type,
			items: info.child.models
		}
	});

};

var DBView = Backbone.View.extend({

    el: '.db-container',
	pos: 0,

    initialize: function () {
		this.categories = new CategoriesCol(); //or should this be bootstrapped?
		this.categories.bind('change', _.bind(this.render, this));
		this.categories.bind('reset', _.bind(this.render, this)); //trigger render to run later after fetch is complete
		this.categories.fetch({
			reset: true
		});
    },

    render: function() {
		var processed = collectionTemplate({
			collectionName: 'name',
			levelTitle: 'Categories:',
			collectionType: 'category',
			items: this.categories.models
		});

		this.$el.empty().append(processed);

		$('.collapsible').collapsible({
			accordion: false
		});

		$('html, body').animate({
			scrollTop: this.pos
		}, 'fast');
    },

    events: {
        'click .legislation-filters': 'updateFilters',
		'click .category-item': 'fetchArticles',
		'click .article-item': 'fetchIssues'
    },

	fetchIssues: function (evt) {
		target = evt.target;
		this.pos = $('body').scrollTop() + target.getBoundingClientRect().top;

		while (target.tagName !== 'LI') {
			target = target.parentNode;
		}

		var targetModel = this.categories.findWhere({
			id: parseInt(target.getAttribute('data-collection-pid'))
		}).get('child').findWhere({
			id: parseInt(target.getAttribute('data-collection-id'))
		});

		if (!targetModel.get('active')) {
			//now fetch civis
		}
		targetModel.set({active: !targetModel.get('active')}, {
			silent: true
		});
		evt.stopPropagation();
	},

	fetchArticles: function (evt) {
		var target = evt.target;
		this.pos = $('body').scrollTop() + target.getBoundingClientRect().top;

		while (target.tagName !== 'LI') {
			target = target.parentNode;
		}

		var targetModel = _.find(this.categories.models, function (elem) {
			return elem.get('id').toString() === target.getAttribute('data-collection-id');
		});

		var tempArticle = new ArticlesCol();
		tempArticle.pID = targetModel.get('id');

		if(!targetModel.get('active')){
			tempArticle.once('reset', _.bind(nest, targetModel, {
				name: 'topic',
				child: tempArticle,
				title: 'Articles:',
				type: 'article'
			}));
			tempArticle.fetch({
				reset: true,
				type: 'POST',
				data: {
					id: targetModel.get('id')
				}
			});
		}

		targetModel.set({
			active: !targetModel.get('active')
		}, {
			silent: true
		});
	},

	updateFilters: function() {
		//later
	}


});

var databaseView = new DBView();
