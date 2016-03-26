var FriendsList = Backbone.Collection.extend({
    url: 'api/user', 

    parse: function(data){
        return data.friends; 
    }
});