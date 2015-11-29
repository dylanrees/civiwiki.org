$(document).ready(function() {
  $("#passwordHint").hide();
  $("#passwordHint2").hide();

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
    /*if ((password.length <8)|| ( /[^a-zA-Z0-9]/.test( password ) )) {
    $("#passwordHint").show("fast");
    return;
  }else{
	      $("#passwordHint").hide("fast");
  }*/
	alert ("hi");
	var p = password;
	var nonAlpha = p.search(/^[a-z]+$/i);
	var nonAlpha = p.search(/[A-Z]+$/i);
	var containsUpper = /[A-Z]/.test(password)
	var goodPassword = false;
    if (p.length < 8 || p.length > 16) {
	  $("#passwordHint2").hide("fast");

	$("#passwordHint").show("fast");
        alert("Your password must be at least 8 characters and leess than 16 characters");
    }
    else if (nonAlpha >= 0 || !containsUpper) {
     $("#passwordHint").hide("fast");

    $("#passwordHint2").show("fast");
        alert("Your password must contain at least one uppercase letter and a number or alphanemeric symbol.");
    }
    else {
        alert("none");
      $("#passwordHint").hide("fast");
	  $("#passwordHint2").hide("fast");
	  goodPassword = true;
	}

if (goodPassword){
	alert("was good?");
	alert(password);
	alert(confirm);
	var samePass = !(password == confirm) ;
  if (samePass) {
    alert("Passwords don't match!");
    return;
  }
}else{
	return;
}
 });
