var AccountBaseView = Backbone.View.extend({

    el: '#account-base',
    baseTemplate: _.template($('#base-template').html()),


    initialize: function (options) {
        options = options || {};
        this.userModel = options.userModel;
        this.render();

        //Child Views
        this.groupsTab = new GroupsListView();
        this.subRender();
    },

    render: function () {
        this.$el.empty().append(this.baseTemplate({
            user: this.userModel.toJSON()
        }));
    },

    // Render Child Views
    subRender: function () {
        this.$('.groups').append(this.groupsTab.render());
    },

    events: {
    },






});
