$("#logInBtn").click(function(event) {
  var username  = document.getElementById("username").value;
  var password  = document.getElementById("password").value;
]
	$.ajax({
            url: 'civiwiki.ngrok.com/api/getUser',
		data = {'username':username ,
		  'password' password: ,
		  };
		  type: 'POST',
          dataType: 'json',
            success: function(json) {
				var restriction = false;
					if (!restriction){
						window.location.replace("beta.html");
					}else{
						window.location.replace("success.html");
					}
			}
			error: function(json){
				window.location.replace("login.html");
			}
			}
		)
  
 });
