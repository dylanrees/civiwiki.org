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

        _this.getFriends();
        // _this.getUserInfo();
        
    },

    getFriends: function(){
        var _this = this; 

        //temp data
        _this.$el.find('#friends').empty().append(_this.friendsTemplate({
            friend_data : JSON.parse(JSON.stringify([{name: 'Mitchell', s: 'a'}, {name: 'Dan', s: 'b'}, {name: 'Darius', s: 'c'}, {name: 'Joohee', s: 'd'}]))
        }))
        
        // this.friendsTab.fetch({
        //    success:function(collection, response){
        //         this.friendsTab = collection; 
        //         _this.$el.find('#friends').empty().append(_this.friendsTemplate({
        //             friend_data : this.friendsTab.toJSON()
        //             //temporary data 
        //             //friend_data : JSON.parse(JSON.stringify([{name: 'Mitchell', s: 'a'}, {name: 'Dan', s: 'b'}, {name: 'Darius', s: 'c'}, {name: 'Joohee', s: 'd'}]))
        //         }));
        //    } 
        // });
    }, 

    getUserInfo: function(){
        $.ajax({
            type: 'POST', 
            url: 'api/getUser', 
            data: {
                'username': 'a'
            },
            success: function(data){
                console.log(data.result);
            }
        });
    },
    events: {
    }
});
