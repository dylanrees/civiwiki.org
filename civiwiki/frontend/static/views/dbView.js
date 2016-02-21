var DatabaseView = Backbone.View.extend({

    el: '#dbview',

    categoriesTemplate: _.template($('#categories-template').html()),

    initialize: function (options) {
        options = options || {};

        this.categories = options.categories;
        this.topics = new Backbone.Collection();

        this.render();
    },

    render: function () {
        this.$el.find('.categories-holder').empty().append(this.categoriesTemplate({
            categories: this.categories.toJSON()
        }));
    },

    events: {

    }

});
