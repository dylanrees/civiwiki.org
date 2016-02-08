var LoginView = Backbone.View.extend({

    el: '#login',

    initialize: function() {
        this.template = _.template($('#login-template').text());

        this.render();
    },

    render: function() {
        this.$el.html(this.template());

        $('.datepicker').pickadate({
            selectYears: 116,
            max: new Date()
        });
    },

    events: {
        "click #log-in-button": "logIn",
        "click #register-button": "register"
    },

    logIn: function () {
        var username = $('#username').val(),
            password = $('#password').val();

        if (username && password) {

            $.ajax({
                type: 'POST',
                url: 'login',
                data: {
                    username: username,
                    password: password
                },
                success: function (data) {
                    if (data.data === 'invalid_login') {
                        Materialize.toast('User does not exist!', 3000);
                    } else {
                        window.location.href = 'home';
                    }
                }
            });

        } else {
            Materialize.toast('Please input your email and password!', 3000);
        }
    },

    register: function () {
        var email = $('#email').val(),
            username = $('#username').val(),
            password = $('#password').val(),
            firstName = $('#first-name').val(),
            lastName = $('#last-name').val();

        if (email && password && firstName && lastName && username) {

            $.ajax({
                type: 'POST',
                url: 'register',
                data: {
                    email: email,
                    username: username,
                    password: password,
                    first_name: firstName,
                    last_name: lastName
                },
                success: function (data) {
                    if (data.data === 'user_exists_error') {
                        Materialize.toast('We already have a user with this email address!', 3000);
                    } else {
                        window.location.href = 'home';
                    }
                }
            });

        } else {
            Materialize.toast('Please fill all the fields!', 3000);
        }
    }

});

var login_view = new LoginView();
