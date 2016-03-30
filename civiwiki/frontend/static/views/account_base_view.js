var AccountBaseView = Backbone.View.extend({

    el: '#account-base',

    baseTemplate: _.template($('#base-template').html()),

    friendsTemplate: _.template($('#friends-template').html()),


    initialize: function (options) {
        var _this = this;

        options = options || {};
        _this.userModel = options.userModel;
        _this.render();

        this.friendsTab = new FriendsListView({
            friends: _this.userModel.toJSON().friends
        });
        
        this.friendsTab.render();
    },

    render: function () {
        var _this = this;

        _this.$el.empty().append(_this.baseTemplate({
            user: _this.userModel.toJSON(), 
        }));

    },
    events: {
    }
});
