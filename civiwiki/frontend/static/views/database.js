var depthURL = ["categories", "article", "civi"];
//1:30 -> 2:30
var Civi = Backbone.Model.extend({
	loadChildren: function()
	{
		this.children = new CiviChainCol({civiParent:this.id}); //impliment later
	}
});
var CiviChainCol = Backbone.Collection.extend({
	initialize: function()
	{
		//something something request data
	},
	
	parse: function(response)
	{
		this.currentOffset+=_.count(response.result);
		this.loadMore = response.has_more;
		return _.map(response.result, function(civi, i, arr){ return new Civi(civi); });
	},
	
	currentOffset : 0,
	
	loadMore : true //this will eventually prevent the collection from requesting civis beyond the currentOffset
});
var CategoriesCol = Backbone.Collection.extend({
	parse: function(response)
	{
		return _.map(response.result, function(cat, i, arr){ return new Backbone.Model(cat); });
	}
});
var DBView = Backbone.View.extend({

    el: '#content-main',
	

    initialize: function() {
		this.categories = new CategoriesCol(); //or should this be bootstrapped?
		this.categories.url = "/api/categories";
		this.categories.fetch();
        this.template = _.template($('#database-template').text());
        this.render();
    },

    render: function() {
        this.$el.html(this.template({categories:this.categories}));
    },

    events: {
        "click .legislation-filters" : "render"
    },


});



var database_view = new DBView();
