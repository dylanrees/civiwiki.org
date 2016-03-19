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
        var _this = this;               
        _this.$el.empty();
        console.log("heythere");
            this.interests.fetch({ 
            success: function (collection, response) {
                this.interests = collection;
                //console.log(this.interests.length);
                //console.log(this);
                //debugger;
               var counter = 1;
               _this.$el.append("<table style='width:100%'>");
               var percentage = (100/(this.interests.length/3));
               for(var i = 0; i < this.interests.length; i=i+3){
                var interest1 = this.interests.models[i].attributes.name.replace(/ /g,'');
                var interest2 = this.interests.models[i+1].attributes.name.replace(/ /g,'');
                var interest3 = this.interests.models[i+2].attributes.name.replace(/ /g,'');
                var interest11 = "static/img/interest_pics/" + interest1 + ".jpg";
                var interest22 = "static/img/interest_pics/" + interest2 + ".jpg";
                var interest33 = "static/img/interest_pics/" + interest3 + ".jpg";
                _this.$el.append('<tr>'+'<td width='+ percentage + '%><center>' + '<center>' + this.interests.models[i].attributes.name + '</center><br>'+"<img src="+interest11+" width = 100% width = autoheight = auto/>" + '</center>'+ '</td>' 
                    +'<td width='+ percentage + '%><center>' +  '<center>' + this.interests.models[i+1].attributes.name + '</center><br>'+"<img src="+interest22+" width = 100% height = auto/>"  + '</center>'+ '</td>'
                    +'<td width='+ percentage + '%><center>' +  '<center>' + this.interests.models[i+2].attributes.name + '</center><br>'+"<img src="+interest33+" width = 100% height = auto/>"  + '</center>'+ '</td><tr>');




               }

            /*_.each(this.interests.models,function(someThing){
                    console.log(someThing.attributes.name);
                    if(counter%3 == 1){
                        _this.$el.append('<tr><td><center>' + "<img src='static/img/interest_pics/Business&Economy.jpg' width = 20%/>" + '</center><br>'+ '<center>' + someThing.attributes.name + '</center></td>')
                    }else if (counter%3 == 2){
                        _this.$el.append('<td><center>' + "<img src='static/img/interest_pics/Business&Economy.jpg' width = 20%/>" + '</center><br>'+ '<center>' + someThing.attributes.name + '</center></td>')
                    }else{
                        _this.$el.append('<td><center>' + "<img src='static/img/interest_pics/Business&Economy.jpg' width = 20%/>" + '</center><br>'+ '<center>' + someThing.attributes.name + '</center></td></tr>')
                    }
                });
            */
               _this.$el.append("</table>");
                           

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

    