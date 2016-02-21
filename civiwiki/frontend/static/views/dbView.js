var TopicsCollection = Backbone.Collection.extend({

    url: 'api/topics',

    parse: function (data) {
        return data.result;
    }

})

var DatabaseView = Backbone.View.extend({

    el: '#dbview',

    categoriesTemplate: _.template($('#categories-template').html()),
    topicsTemplate: _.template($('#topics-template').html()),

    initialize: function (options) {
        options = options || {};

        this.categories = options.categories;
        this.topics = new TopicsCollection();

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

        $this.siblings().removeClass('selected-category');

        this.topics.fetch({
            type: 'POST',
            data: {
                id: parseInt(catId)
            },
            success: function () {
                $this.addClass('selected-category');

                _this.$el.find('.topics-holder').empty().append(_this.topicsTemplate({
                    topics: _this.topics.toJSON()
                }));

                _this.customCSS();
            }
        });

    }

});
