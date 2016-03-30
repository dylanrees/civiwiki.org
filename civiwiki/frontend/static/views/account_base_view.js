var AccountBaseView = Backbone.View.extend({

    el: '#account-base',

    baseTemplate: _.template($('#base-template').html()),

    friendsTemplate: _.template($('#friends-template').html()),


    initialize: function (options) {
        var _this = this;

        options = options || {};
        _this.userModel = options.userModel;

        this.friendsTab = new FriendsList();

        _this.render();
    },

    render: function () {
        var _this = this;

        _this.$el.empty().append(_this.baseTemplate({
            user: _this.userModel.toJSON(), 
        }));

        _this.$el.find('#friends').empty().append(_this.friendsTemplate({

            //temporary data 
            friend_data : JSON.parse(JSON.stringify([{name: 'Mitchell', s: 'a'}, {name: 'Dan', s: 'b'}, {name: 'Darius', s: 'c'}, {name: 'Joohee', s: 'd'}]))
        }));      
        
    },
    events: {
    }
});
