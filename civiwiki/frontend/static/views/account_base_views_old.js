var interest_views = Backbone.Collection.extend({

    url: '/api/categories',

    parse: function (data) {
        return data.result;
    }

});

function fnChangeBorder(imageID){
      var imgElement = document.getElementById(imageID);
      imgElement.setAttribute("style:borderColor", "#00FF00");
};

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
        "click .tab.col.s3.interests": "getInterests"

    },

    getInterests: function(){
        var _this = this;               
            this.interests.fetch({ 
            success: function (collection, response) {
                this.interests = collection;
                
                //how to use this??
                _this.$el.empty().append(_this.baseTemplate({
                    user: _this.userModel.toJSON()
                 }));
               _this.$el.append("<table class='interestTable' >");
               var percentage = (100/(this.interests.length/3));
               for(var i = 0; i < this.interests.length; i=i+3){
                var interest1 = this.interests.models[i].attributes.name.replace(/ /g,'');
                var interest2 = this.interests.models[i+1].attributes.name.replace(/ /g,'');
                var interest3 = this.interests.models[i+2].attributes.name.replace(/ /g,'');
                var interest11 = "static/img/interest_pics/" + interest1 + ".jpg";
                var interest22 = "static/img/interest_pics/" + interest2 + ".jpg";  
                var interest33 = "static/img/interest_pics/" + interest3 + ".jpg";
                _this.$el.append('<tr>'+'<td width='+ percentage + '%><center>' + '<center>' + this.interests.models[i].attributes.name + '</center><br>'+"<img id = " +interest1 + " class='img-circle' src="+interest11+" width = 100% width = autoheight = auto/>" + '</center>'+ '</td>' 
                    +'<td width='+ percentage + '%><center>' +  '<center>' + this.interests.models[i+1].attributes.name + '</center><br>'+"<img id = " +interest2 + " class='img-circle' src="+interest22+" width = 100% height = auto/>"  + '</center>'+ '</td>'
                    +'<td width='+ percentage + '%><center>' +  '<center>' + this.interests.models[i+2].attributes.name + '</center><br>'+"<img id = " +interest3 + " class='img-circle' src="+interest33+" width = 100% height = auto/>"  + '</center>'+ '</td><tr>');
               }
           
               _this.$el.append("</table>");

            }
        });
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

    