var FriendsList = Backbone.Collection.extend({
    url: 'api/getUser', 

    parse: function(data){
        //this refuses to work bleh
        console.log(data.result);
        return data.result; 
    }
});

var FriendRequestView = Backbone.View.extend({

    events: {
        "click #addFriend": "addFriend"
    },

    addFriend: function(){
      var _this = this; 

      var friend_request = this.$el.find('#friend_request').val();

      if(friend_request){
        $.ajax({
            type: 'POST', 
            url: '', 
            data: {
              username: friend_request
            }, 
            success: function(data){
              //add friend to list 
            }
        })
      }

    }
});