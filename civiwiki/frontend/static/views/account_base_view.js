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
        console.log("the view")
        console.log(this.View);

    },

    render: function () {
        var _this = this;
        console.log(Object.prototype.toString.call(_this.userModel.toJSON().interests) + " hey");

        _this.$el.empty().append(_this.baseTemplate({
            user: _this.userModel.toJSON()
        }));
        this.getInterests();
        
    },

    getInterests: function(){
                var _this = this;
            this.interests.fetch({ 
            success: function (collection, response) {
                this.interests = collection;

                _this.$el.find('#interests').empty().append(_this.interestTemplate({
                    interest: this.interests.toJSON(),
                    user: _this.userModel.toJSON()


                }));
            }
        });
    },
        events: {
        'click .followInterest': 'editFollowInterest',
    },

    editFollowInterest: function(event){
        console.log("hey we got here");
        var _this = this;
        debugger;
            $.ajax({
                type: 'POST',
                url: 'api/register',
                data: {

                },
                success: function (data) {
                    
                },
                error: function(data){

                }
            });

    }


});
var temp =  new Backbone.Model();
var account_base_view = new AccountBaseView({userModel : temp});

function editInterest(intElement){
    debugger;
    $(element).toggleClass('mynewclass');
    alert($(element));
}
    