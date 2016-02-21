var DatabaseView = Backbone.View.extend({

    el: '#dbview',

    categoriesTemplate: _.template($('#categories-template').html()),
    topicsTemplate: _.template($('#topics-template').html()),

    initialize: function (options) {
        options = options || {};

        this.categories = options.categories;
        this.topics = new Backbone.Collection();

        this.windowHeight = $(window).height();

        this.render();
    },

    render: function () {
        this.$el.find('.categories-holder').empty().append(this.categoriesTemplate({
            categories: this.categories.toJSON()
        }));

        this.customCSS();
    },

    customCSS: function () {
        this.$el.find('.db-list').css({
            height: this.windowHeight
        });

    },

    events: {
        'click .categories-item': 'clickCategory'
    },

    clickCategory: function (e) {
        var _this = this,
            $this = $(e.target).closest('.categories-item'),
            catId = $this.attr('data-id');

        console.log(catId);

        this.topics.fetch({
            url: 'api/topics',
            type: 'POST',
            data: {
                id: parseInt(catId)
            },
            success: function () {
                _this.$el.find('.topics-holder').empty().append(_this.topicsTemplate({
                    topics: _this.topics.toJSON()
                }));
            }
        });

    }

});
