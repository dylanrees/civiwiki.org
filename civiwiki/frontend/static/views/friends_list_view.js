var FriendsListView = Backbone.View.extend({
    el: '#friends', 

    friendsTemplate: _.template($('#friends-template').html()),

    initialize: function(options){
      var _this = this; 

      options = options || {}; 

      _this.user_id = options.user_id;
      _this.userModel = options.userModel; 
      _this.friend_requests = new Backbone.Collection(_this.userModel.toJSON().friend_requests);

      console.log(_this.userModel);

      console.log(_this.friend_requests);
      _this.listenTo(_this.friend_requests, "change", _this.render); //supposed to listen for a change in the friend_requests attribute of the model and rerender the view accordingly

    }, 

    render: function(){
      var _this = this; 

       _this.$el.empty().append(_this.friendsTemplate({
            //temporary friend data 
            friends : [{first_name: 'Mitchell', last_name: 'West'}, {first_name: 'Dan', last_name:'Borstelmann'}, {first_name: 'Darius', last_name: 'Calliet'}, {first_name: 'Joohee', last_name:'Lee'}], 
            friend_requests: _this.friend_requests 
        }));      
    }, 
     events: {
      "click #add_friend": "addFriend",
      "click .accept" : "acceptFriend", 
      "click .reject" : "rejectFriend"
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
              url: 'api/requestfriend', 
              data: {
                friend: data.result
              },
              success: function(data){
                Materialize.toast("Your friend request has been sent!", 3000);
              }, 
              error: function(data){
                console.log(data.result);
                Materialize.toast("Could not successfully send friend request", 3000);
              }
            });

          },
          error: function(data){
            Materialize.toast("Sorry, this username doesn't exist!", 3000);
          }
        });
      }
    }, 
    acceptFriend: function(event){
      var _this = this; 

      var accept_id = $(event.target).parent().attr('class').substr(-1);
      // $.ajax({
      //   type: 'POST', 
      //   url: 'api/acceptFriend', 

      // });

    }, 
    rejectFriend: function(event){
      var _this = this; 

      var rejected_id = $(event.target).parent().attr('class').substr(-1); //gets the ID of rejected friend

      $.ajax({
        type:'POST', 
        url:'api/rejectfriend',
        data:{
          id:rejected_id, 
        }, 
        success: function(data){
          Materialize.toast('Friend successfully rejected', 3000); //removes friends from friend_requests list
        }, 
        error: function(data){
          Materialize.toast('Friend not rejected', 3000);
        }
      });
      console.log(_this.userModel);
    }

});


