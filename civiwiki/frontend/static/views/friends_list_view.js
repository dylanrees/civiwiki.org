var FriendsList = Backbone.Collection.extend({
    url: 'api/getUser', 

    parse: function(data){
        console.log(data.result);
        return data.result; 
    }
});