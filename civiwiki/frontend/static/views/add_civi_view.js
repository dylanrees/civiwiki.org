var AddCiviView = Backbone.View.extend({

    el: '#add-civi',

    initialize: function(options) {

        options = options || {};

        this.categories = options.categories;
        this.topics = options.topics;

        this.template = _.template($('#add-civi-template').html());
        this.render();
    },

    render: function() {
        this.$el.html(this.template({
            categories: this.categories.toJSON(),
            topics: this.topics.toJSON()
        }));
    },

    events: {
        'click .submit-civi': 'newCivi'
    },

    newCivi: function () {
        var title = $('.title').val(),
            category = $('.category').find(":selected").text(),
            topic = $('.topic').find(":selected").text(),
            ics = $('.ics').find(":selected").text(),
            body = $('.body').val();

        $.post({
            url: '/createCivi',
            data: {
                title: title,
                category: category,
                topic: topic,
                type: ics,
                body: body,
                creator: '5'
            },
            success: function (data) {

            }
        });
    }

});
