var interest_views = Backbone.Collection.extend({

    url: '/api/categories',

    parse: function (data) {
        return data.result;
    }

});


var AccountBaseView = Backbone.View.extend({

    el: '#account-base',


    baseTemplate: _.template($('#base-template').html()),

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
        "click .tab.col.s3.interests": "getInterests"

    },

    getInterests: function(){
        console.log("heythere");
            this.interests.fetch({ 
            success: function (collection, response) {
                this.interests = collection;
                console.log(this.interests.length);
                console.log(this);
                //debugger;

                _.each(this.interests.models,function(someThing){
                    console.log(someThing.attributes.name);
                });
            }
        });
        console.log("yolo");
    },



    render: function () {

        var _this = this;

        _this.$el.empty().append(_this.baseTemplate({
            user: _this.userModel.toJSON()
        }));

    }
});
var temp =  new Backbone.Model();
var account_base_view = new AccountBaseView({userModel : temp});

    