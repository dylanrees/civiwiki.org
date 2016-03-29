var interest_views = Backbone.Collection.extend({

    url: '/api/categories',

    parse: function (data) {
        return data.result;
    }

});



var AccountBaseView = Backbone.View.extend({

    el: '#account-base',


    baseTemplate: _.template($('#base-template').html()),
    interestTemplate: _.template($('#interest-tab-template').html()),

    initialize: function (options) {
        var _this = this;
        this.interests = new interest_views();
        options = options || {};
        _this.userModel = options.userModel;
        _this.render();
    },

    render: function () {
        var _this = this;
        _this.$el.empty().append(_this.baseTemplate({
            user: _this.userModel.toJSON()
        }));
        this.getInterests();

    },

    getInterests: function(){
                var _this = this;

            this.interests.fetch({
            success: function (collection, response) {
                _this.$el.find('#interests').empty().append(_this.interestTemplate({
                    interest: response.result,
                    user: _this.userModel.toJSON()
                }));
            }
        });
    },
        events: {
        'click .followInterest': 'editFollowInterest',
    },

    editFollowInterest: function(event){
       var _this = this;
       var tempInterest = _this.userModel.get("interests");
       var follow = true;
       var unfollow = tempInterest.indexOf(event.target.id);
              console.log("Before: " + tempInterest);

       if (unfollow == -1){
            tempInterest.push(event.target.id);
       }else{
            tempInterest.splice(unfollow, 1);
       }
       console.log("After: " +tempInterest);
       $.ajax({
            type: 'POST',
            url: '/api/edituser',
            data: {
                data : JSON.stringify({interests: tempInterest})
            },
            success: function (data) {
                console.log("here");
            },
            error: function(data){

            }
        });

    }


});
