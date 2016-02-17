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

        	var email = this.$el.find('#email').val(),
            username = this.$el.find('#username').val(),
            password = this.$el.find('#password').val(),
            firstName = this.$el.find('#first-name').val(),
            lastName = this.$el.find('#last-name').val(),
            birthday = this.$el.find('#bday').val();
        if (!this.calculateAge(birthday)) {
            Materialize.toast('Must be 13+ to join civiwiki.', 3000);
            return;
        }

        if (email && password && firstName && lastName && username) {

            $.ajax({
                type: 'POST',
                url: 'api/register',
                data: {
                    email: email,
                    username: username,
                    password: password,
                    first_name: firstName,
                    last_name: lastName,
                    birthday: birthday
                },
                success: function (data) {
                    if (data.status_code === 200) {
                        window.location.href = _this.findURLParameter('next');
                        //goes home if no redirect specified else redirects.

                    } else if (data.status_code === 500) {
                        Materialize.toast('We already have a user with this email address!', 3000);
                    }
                }
            });

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