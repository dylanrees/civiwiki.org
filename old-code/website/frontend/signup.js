$(document).ready(function() {
  $("#passwordHint").hide();
});

$("#signUpBtn").click(function(event) {
  var firstName = document.getElementById("firstName").value;
  var lastName  = document.getElementById("lastName").value;
  var username  = document.getElementById("username").value;
  var email     = document.getElementById("email").value;
  var password  = document.getElementById("password").value;
  var confirm   = document.getElementById("confirmPassword").value;

  if (!firstName || !lastName || !email || !password) {
    alert("Fill out all fields!");
    return;
  }
    if (password.length <8 || confirm.length < 8) {
    $("#passwordHint").show("fast");
    return;
  }else{
	      $("#passwordHint").hide("fast");
  }
  if (!password.match(confirm)) {
    alert("Passwords don't match!");
    return;
  }
 });
