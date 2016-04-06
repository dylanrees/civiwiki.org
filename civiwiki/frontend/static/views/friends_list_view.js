var FriendRequestView = Backbone.View.extend({
    el: '#friend_requests', 

    friendRequestTemplate: _.template($('#friend-request-template').html()),

    initialize: function(options){
      var _this = this; 

      options = options || {}; 

    }, 

    render: function(){
      var _this = this; 
       _this.$el.empty().append(_this.friendRequestTemplate({
          friend_requests: [1,2,3]
       }));      

    },
    events: {
      "click #add_friend": "addFriend",
      "click " : "acceptFriend", 
      "click " : "rejectFriend"
    },

    addFriend: function(){
      var _this = this; 
      var friend_request = this.$el.find('#friend_request').val(); 

      if(friend_request){
        $.ajax({
          type: 'POST', 
          url: 'api/useridbyusername',
          data: {
            username: friend_request
          },
          success: function(data){

            $.ajax({
              type: 'POST', 
              url: 'api/requestFriend', 
              data: {
                id: data.result
              },
              success: function(data){
                Materialize.toast("Your friend request has been sent!", 3000);
              }, 
              error: function(data){
                Materialize.toast("Could not successfully send friend request", 3000);
              }
            });
            // //add userid to friend_requests

            // //if friend_requests list is empty, set it to the id of the friend_requested 
            // var current_friend_requests = _this.userModel.get('friend_requests');
            // console.log(current_friend_requests);
            // current_friend_requests = [data.result]; 
            // //if it isn't, just append it to the array 
            // console.log(current_friend_requests);
            // current_friend_requests.push(data.result);
            // console.log(current_friend_requests);

          },
          error: function(data){
            Materialize.toast("Sorry, this username doesn't exist!", 3000);
          }
        });
      }
    }, 
    acceptFriend: function(){
      var _this = this; 


    }, 
    rejectFriend: function(){
      var _this = this; 
    }
});




var FriendsListView = Backbone.View.extend({
    el: '#friends', 

    friendsTemplate: _.template($('#friends-template').html()),

    initialize: function(options){
      var _this = this; 

      options = options || {}; 

      _this.friends = options.friends;
      _this.user_id = options.user_id;
      _this.userModel = options.userModel; 
      console.log(_this.userModel);
      _this.render();


    }, 

    render: function(){
      var _this = this; 

       _this.$el.empty().append(_this.friendsTemplate({
            //temporary data 
            friends : [{first_name: 'Mitchell', last_name: 'West'}, {first_name: 'Dan', last_name:'Borstelmann'}, {first_name: 'Darius', last_name: 'Calliet'}, {first_name: 'Joohee', last_name:'Lee'}]
            //friends : _this.friends; 
        }));      

    }, 

});



