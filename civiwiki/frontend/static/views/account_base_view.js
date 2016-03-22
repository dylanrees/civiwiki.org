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


    },

    events: {
    },

    //grabs friends by passing in user_id and making a new avatar for each friend
    getFriends: function(){
        var _this = this; 

        var user_id = _this.userModel.get('user_id');

        //ajax call takes in user_id and returns 
        // $.ajax({
        //     type: 'POST', 
        //     url: 'api/getFriends', 
        //     data: {
        //         user_id: user_id
        //     }, 
        //     success: function(data){
        //         _.each(data, function(friend){
        //             _.each(friend, function(name, n){
        //                 $('.friends').append('<li class="collection-item avatar"><span class="title">'+name+'</span><a href="#!" class="secondary-content"><i class="material-icons">grade</i></a>');
        //             });
        //         });
        //     }
        // });

        var data = [{name: 'Mitchell'}, {name: 'Dan'}, {name: 'Darius'}];

        _.each(data, function(friend){
            _.each(friend, function(name, n){
                $('.friends').append('<li class="collection-item avatar"><span class="title">'+name+'</span><a href="#!" class="secondary-content"><i class="material-icons">grade</i></a>');
            });
        });
    }
    // getFriendRequests: function(){
    //     var _this = this; 
        
    // }
});
