var CiviCollection = Backbone.Collection.extend({

    model: CiviModel,

    initialize: function (models, options) {
        options = options || {};

        this.civiType = options.civiType;
        this.url = options.url;
    },

    parse: function (data) {
        // var civis = data.result;
        //
        // var civiModels;
        //
        // _.each(civis, function (civi) {
        //     civiModels.push(new CiviModel(civi));
        // });
        //
        // return civiModels;

        return data.result;
    }

});
