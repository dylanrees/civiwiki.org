var FriendsListView = Backbone.View.extend({
    el: '#friends', 

    friendsTemplate: _.template($('#friends-template').html()),

    initialize: function(options){
      var _this = this; 
      options = options || {}; 

      _this.friends = options.friends; 
      _this.render();
    }, 

    render: function(){
      var _this = this; 

       _this.$el.empty().append(_this.friendsTemplate({
            //temporary data 
            friend_data : [{name: 'Mitchell', s: 'a'}, {name: 'Dan', s: 'b'}, {name: 'Darius', s: 'c'}, {name: 'Joohee', s: 'd'}]
        }));      
    }, 

    events: {
      "click #addFriend"
    }, 

    addFriend: function(){
      var _this = this; 

      var friend_request = this.$el.find('#friend_request').val(); 

      if(friend_request){
        $.ajax({
          type: 'POST', 
          url: '', //url for friends
          data: {
            username: friend_request
          }
          success: function(data){
            //add to friend database?? bleh
          }
        })
      }
    }
});