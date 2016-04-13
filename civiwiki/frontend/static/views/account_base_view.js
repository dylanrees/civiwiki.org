var AccountBaseView = Backbone.View.extend({

    el: '#account-base',
    baseTemplate: _.template($('#base-template').html()),

    initialize: function (options) {
        var _this = this;
        options = options || {};
        _this.userModel = options.userModel;
        _this.render();

        //Child Views
        _this.groupsTab = new GroupsListView({
            groups: _this.userModel.toJSON().groups
        });
        _this.groupsTab.render();
    },

    render: function () {
        var _this = this;
        _this.$el.empty().append(_this.baseTemplate({
            user: _this.userModel.toJSON()
        }));
    },

    events: {
    },
});
