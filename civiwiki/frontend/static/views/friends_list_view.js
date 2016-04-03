var FriendsListView = Backbone.View.extend({
    el: '#friends', 

    friendsTemplate: _.template($('#friends-template').html()),

    initialize: function(options){
      var _this = this; 

      options = options || {}; 

      _this.friends = options.friend_requests; 
      _this.user_id = options.user_id;
      _this.render();

    }, 

    render: function(){
      var _this = this; 

       _this.$el.empty().append(_this.friendsTemplate({
            //temporary data 
            friends : [{name: 'Mitchell', s: 'a'}, {name: 'Dan', s: 'b'}, {name: 'Darius', s: 'c'}, {name: 'Joohee', s: 'd'}]
            //friends : _this.friends; 
        }));      
    }, 

    events: {
      "click #add_friend": "addFriend",
    }, 

    addFriend: function(){
      var _this = this; 
      var friend_request = this.$el.find('#friend_request').val(); 

      if(friend_request){
        $.ajax({
          type: 'POST', 
          url: 'api/user', //url for getting friends
          data: {
            user_id: _this.user_id
          },
          success: function(data){
            //get ID of user receiving friend request 
            //get ID of user sending friend request 
            console.log(data.results);
          }
        })
      }
    }
});