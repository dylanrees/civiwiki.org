var AccountBaseView = Backbone.View.extend({

    el: '#account-base',

    baseTemplate: _.template($('#base-template').html()),

    initialize: function (options) {
        var _this = this;

        options = options || {};
        _this.userModel = options.userModel;

        _this.render();
    },

    render: function () {
        var _this = this;

        _this.$el.empty().append(_this.baseTemplate({
            user: _this.userModel.toJSON(), 
        }));

        _this.getFriends(); 
        _this.magicSuggestFriends();

    },

    events: {
    },

    //grabs friends by passing in user_id and making a new avatar for each friend
    getFriends: function(){
        var _this = this; 

        var user_id = _this.userModel.get('user_id');

        // $.ajax({
        //     type: 'POST', 
        //     url: 'api/getFriends', 
        //     data: {
        //         user_id: user_id
        //     }, 
        //     success: function(data){
                // var friend_data = JSON.parse(data);
        
                // _.each(friend_data, function(friend){
                //     //is there a better way of appending? 
                //     $('.friends').append('<li class="collection-item avatar"><img class="circle" src="/static/img/team_profile/team_default.png"><span class="title">'+friend['name']+'</span><a href="#!" class="secondary-content"><i class="material-icons">grade</i></a>');
                // });
        //     }
        // });
    

        //temporary data for now 
        var data = JSON.stringify([{name: 'Mitchell', s: 'a'}, {name: 'Dan', s: 'b'}, {name: 'Darius', s: 'c'}, {name: 'Grace', s: 'd'}]);
        var friend_data = JSON.parse(data);
        
        _.each(friend_data, function(friend){
            $('.friends').append('<li class="collection-item avatar"><img class="circle" src="/static/img/team_profile/team_default.png"><span class="title">'+friend.name+'</span><a href="#!" class="secondary-content"><i class="material-icons">grade</i></a>');
        });


    },
    magicSuggestFriends: function(){
        var _this = this; 

        var friend_data = [{name: 'Mitchell'}, {name: 'Dan'}, {name: 'Darius'}, {name: 'Grace'}];
        $('#friend-requests').magicSuggest({
            placeholder: 'Search...',
            data: friend_data
            // data: function(request, response){

            //     $.ajax({
            //         type: 'POST', 
            //         url: 'api/queryFriends', 
            //         data: {
            //             user_id: user_id
            //         }, 
            //         success:function(data){
            //             response(data);
            //         }
            //     });

            // }
        });
        
    }
});
