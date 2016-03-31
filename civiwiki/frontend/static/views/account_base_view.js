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
        'click .yolo': 'editYolo',

    },

    editFollowInterest: function(event){
       var _this = this;
       var tempInterest = _this.userModel.get("interests");
       if (event.target.id >= 15){
         var temp1 = (event.target.id -15);
         temp = (event.target.id);
       }else{
         var temp1 = (event.target.id);
         var temp = parseInt(event.target.id)+parseInt(15);
       }

       var unfollow = tempInterest.indexOf(temp1 + "");
       console.log(temp1);
       console.log(temp)
       console.log("Before: " +tempInterest);
       if (unfollow == -1){
            tempInterest.push(temp1+"");
            document.getElementById(temp1).innerHTML = "Click Here to Unfollow";
            document.getElementById(temp).innerHTML = "Click Here to Unfollow";
       }else{
            if(tempInterest.length > 1){
                tempInterest.splice(unfollow, 1);
                document.getElementById(temp1).innerHTML = "Click Here to Follow";
                document.getElementById(temp).innerHTML = "Click Here to Follow";
            }else{
                tempInterest.push("-2");
                document.getElementById(temp1).innerHTML = "Click Here to Follow";
                document.getElementById(temp).innerHTML = "Click Here to Follow";

                console.log("im in this loop");

            }
       }
       console.log("After: " +tempInterest);
       $.ajax({
            type: 'POST',
            url: '/api/edituser',
            data: {
              //  data : JSON.stringify({interests: tempInterest})
              data : JSON.stringify({interests: tempInterest})            
          },
            success: function (data) {
                console.log("yes");
            },
            error: function(data){
                console.log("no");
            }
        });

    },
    editYolo: function(event){
        var _this = this;
        console.log(_this.userModel.get("interests"));
        var tempInterest = [];
            $.ajax({
            type: 'POST',
            url: '/api/edituser',
            data: {
                interests: JSON.stringify(tempInterest)
            },
            success: function (data) {
                console.log("yes");
            },
            error: function(data){
                console.log("no");
            }
        });

    }


});
