var FriendsList = Backbone.Collection.extend({
    url: 'api/getUser', 

    parse: function(data){
        //this refuses to work bleh
        console.log(data.result);
        return data.result; 
    }
});