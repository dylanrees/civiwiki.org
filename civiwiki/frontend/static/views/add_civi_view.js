var AddCiviView = Backbone.View.extend({

    el: '#add-civi',

    initialize: function() {
        this.template = _.template($('#add-civi-template').html());
        this.render();
    },

    render: function() {
        this.$el.html(this.template());
    }

});

var addCiviView = new AddCiviView();
