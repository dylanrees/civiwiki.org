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

        options = options || {};
        _this.userModel = options.userModel;

        _this.render();
    },

    render: function () {
        var _this = this;
        this.interests = new interest_views();

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

    var yolo = 0;

       this.interests.fetch({
            success: function (collection, response) {
                yolo = response.result.length;
            }
        });

        console.log("hi " + yolo);
        console.log(yolo);
       var tempInterest = _this.userModel.get("interests");
       var interestSize = 15;
       if (event.target.id >= interestSize){
         var temp1 = (event.target.id - interestSize);
         var temp = (event.target.id);
         var temp2 = parseInt(temp1) + parseInt(interestSize*2);
         var temp3 = parseInt(temp1) + parseInt(interestSize*3);
       }else{
         var temp1 = (event.target.id);
         var temp = parseInt(event.target.id)+parseInt(interestSize);
         var temp2 = parseInt(temp1) + parseInt(interestSize*2);
         var temp3 = parseInt(temp1) + parseInt(interestSize*3);
       }

       var unfollow = tempInterest.indexOf(temp1 + "");
       console.log(temp1);
       console.log(temp)
       console.log("Before: " +tempInterest);
       var NAME2 = document.getElementById(temp2);
       var NAME3 = document.getElementById(temp3)
       console.log(NAME2);
              console.log(NAME3);
              console.log(temp3);
       if (unfollow == -1){
            tempInterest.push(temp1+"");
            document.getElementById(temp1).innerHTML = "Click Here to Unfollow";
            document.getElementById(temp).innerHTML = "Click Here to Unfollow";
            NAME2.className = "card-content purple-background";
            NAME3.className = "card-reveal purple-background";

       }else{
            if(tempInterest.length >1){
                tempInterest.splice(unfollow, 1);
                document.getElementById(temp1).innerHTML = "Click Here to Follow";
                document.getElementById(temp).innerHTML = "Click Here to Follow";
                NAME2.className = "card-content grey darken-3";
                NAME3.className = "card-reveal grey darken-3";

            }else{
                tempInterest.splice(0,tempInterest.length);

                document.getElementById(temp1).innerHTML = "Click Here to Follow";
                document.getElementById(temp).innerHTML = "Click Here to Follow";
                NAME2.className = "card-content grey darken-3";
                NAME3.className = "card-reveal grey darken-3";

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
                console.log("yesyes");
            },
            error: function(data){
                console.log("nono");
            }
        });

    },

    editYolo: function(event){
        var _this = this;
       var tempInterest = _this.userModel.get("interests");
                tempInterest.splice(0,tempInterest.length);

             $.ajax({
            type: 'POST',
            url: '/api/edituser',
            data: {
              //  data : JSON.stringify({interests: tempInterest})
              data : JSON.stringify({interests: tempInterest})
          },
            success: function (data) {
                console.log("yesyes");
            },
            error: function(data){
                console.log("nono");
            }
        });

    }

});
