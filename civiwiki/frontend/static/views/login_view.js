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
        "click #open-register-form-button": "openRegisterForm",
        "click #open-login-form-button": "closeRegisterForm",
        "click #register-button": "register",

    },

    logIn: function () {
        var username = $('#username').val(),
            password = $('#password').val();

        if (username && password) {

            $.ajax({
                type: 'POST',
                url: 'api/login',
                data: {
                    username: username,
                    password: password
                },
                success: function (data) {
                    if(data.status_code == 200){
                      
                    } else if (data.status_code == 400) {
                      Materialize.toast(data.error);
                    } else {
                      Materialize.toast('Internal Server Error.');
                    }
                }
            });

        } else {
            Materialize.toast('Please input your email and password!', 3000);
        }
    },
    openRegisterForm: function() {
      $("#login-register-action-buttons").hide();
      $(".register").show();
    },
    closeRegisterForm: function() {
      $("#login-register-action-buttons").show();
      $(".register").hide();
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
                url: 'api/register',
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
