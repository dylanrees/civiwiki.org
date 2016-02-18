var BetaView = Backbone.view.extend({
	    el: '#beta-blocker',

    initialize: function() {
        this.template = _.template($('#beta-block-template').text());

        this.render();
    },

    render: function() {
        this.$el.html(this.template());
    },

    events: {
        

    },

    enterCode: function () {

        var _this = this;

        var betaCode = this.$el.find("#beta-code").val();

        if (betaCode) { //need to figure out server-side way of checking if beta code is correct


        } else {
            Materialize.toast('Please fill in all the fields!', 3000);
        }
    },

    findURLParameter: function(val) {
        var result = "/",
            tmp = [];
        location.search
        .substr(1)
            .split("&")
            .forEach(function (item) {
            tmp = item.split("=");
            if (tmp[0] === val) {
                result = decodeURIComponent(tmp[1]);
            }
        });
        return result;
    }
})