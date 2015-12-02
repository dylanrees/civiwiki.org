$("#logInBtn").click(function(event) {
  var username  = document.getElementById("username").value;
  var password  = document.getElementById("password").value;

  var restriction = false;
  if (!restriction){
	  window.location.replace("beta.html");
  }else{
	  window.location.replace("success.html");
  }
 });
