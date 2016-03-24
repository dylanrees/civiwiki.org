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

    events: {

    },

    getInterests: function(){
        var _this = this;               
            this.interests.fetch({ 
            success: function (collection, response) {
                this.interests = collection;
             

            }
        });
    },



    render: function () {

        var _this = this;
        _this.$el.empty().append(_this.baseTemplate({
            user: _this.userModel.toJSON()
        }));
        this.$el.find('#interests').empty().append(this.interest-tab-template({}));

        
    }
});
var temp =  new Backbone.Model();
var account_base_view = new AccountBaseView({userModel : temp});

    