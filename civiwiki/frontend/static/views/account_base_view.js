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

    },

    events: {
        "click #friends_tab": "getFriends"
    },

    getFriends: function(){
        var _this = this; 

        var user_id = _this.userModel.get('user_id');
        console.log(user_id);

        $.ajax({
            type: 'POST', 
            url: 'api/getFriends', 
            data: {
                user_id: user_id
            }, 
            success: function(data){
                //list friends 
            }
        });
    }
    getFriendRequests: function(){
        
    }
});
