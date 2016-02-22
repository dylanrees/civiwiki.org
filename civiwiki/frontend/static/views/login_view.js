var LoginView = Backbone.View.extend({

    el: '#login',

    initialize: function() {
        this.template = _.template($('#login-template').text());

        this.render();
    },

    render: function() {
        this.$el.html(this.template());

        this.$el.find('#beta-section').hide();

        this.$el.find('#register-link').hide();

        this.$el.find('.datepicker').pickadate({
            selectYears: 116,
            max: new Date()
        });
    },

    events: {
        "click #log-in-button": "logIn",
        "click #register-button": "register",
        "click #beta-submit-button" : "submitBeta" //function that will be used to see if beta-code matches
    },

    logIn: function () {
        var _this = this;

        var username = this.$el.find('#username').val(),
            password = this.$el.find('#password').val();

        if (username && password) {

            $.ajax({
                type: 'POST',
                url: 'api/login',
                data: {
                    username: username,
                    password: password
                },
                success: function (data) {
                    if(data.status_code === 200){
                        // Will only return ture if use is beta enabled.

                        window.location.href = _this.findURLParameter('next');
                        //goes home if no redirect specified else redirects.
                    } else if (data.status_code === 400) {
                        Materialize.toast(data.message);
                    } else if (data.status_code === 401) {
                      // Account is not beta verified.
                        window.location.href = '/beta';
                    } else {
                        Materialize.toast('Internal Server Error.');
                    }
                }
            });

            this.$el.find('#welcome-container').hide();
            this.$el.find('#register-link').show();
            this.$el.find('#beta-section').show();

            $('#login_modal').closeModal();

        } else {
            Materialize.toast('Please input your username and password!', 3000);
        }
    },

    register: function () {

        var _this = this;

        var email = this.$el.find('#email').val(),
            username = this.$el.find('#username-register').val(),
            password = this.$el.find('#password-register').val(),
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

            this.$el.find('#welcome-container').hide();
            this.$el.find('#register-link').show();
            this.$el.find('#beta-section').show();

        } else {
            Materialize.toast('Please fill in all the fields!', 3000);
        }
    },

    calculateAge: function(birthday) { // birthday is a date
        birthday = new Date(birthday);
        var ageDifMs = Date.now() - birthday.getTime();
        var ageDate = new Date(ageDifMs); // miliseconds from epoch
        return Math.abs(ageDate.getUTCFullYear() - 1970) >= 13;
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
    },

    submitBeta: function(){
        //need to figure out how to check if beta-code is correct;
    },

});

var login_view = new LoginView();
