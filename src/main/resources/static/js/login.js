	checkUserName=()=>{
		 $("#username").on("input", () => {
			    let username = $('#username').val();
			    let body = { "username": username };
			    $.ajax({
			        url: "/docker-app/m/checkUserName",
			        method: "POST",
			        contentType: "application/json",
			        data: JSON.stringify(body),
			        dataType: "json",
			        success: function(response) {
			            console.log(response);
			            if (response.status == "success") {
			            	$("#username-error").html("");
			            	$("#password").removeAttr("disabled");
			            	$("#password").val("");
			            	$("#password-error").html("");
			            } else {
			            	$("#username-error").html("Username Does Not Exists.Try With Different Username.");
			            	$("#password-error").html("");
			            	$("#password").attr("disabled","disabled");
			            	$("#password").val("");
			            }
			        },
			        error: function(error) {
			        	$("#username-error").html("Error While Getting Username.");
			            console.log(error);
			        }
			    });
			    validateForm();
		});
	}
	validateForm = () => {
	    let checkusername = $('#username').val().trim().length > 0 && $('#username-error').html().trim().length == 0;
	    let checkpassword = $('#password').val().trim().length > 0 && $('#password-error').html().trim().length == 0;
	    console.log("checkusername:"+checkusername);
	    console.log("checkpassword:"+checkpassword);
	    if (checkusername && checkpassword) {
	        $("#loginSubmit").removeAttr("disabled");
	    } else {
	        $("#loginSubmit").attr("disabled", "disabled");
	    }
	}
	checkPassword = () => {
	    $("#password").on("input", () => {
	        let password = $('#password').val();
	        let username = $('#username').val();
		    let body = { "username": username,"password":password };
		    $.ajax({
		        url: "/docker-app/m/checkPassword",
		        method: "POST",
		        contentType: "application/json",
		        data: JSON.stringify(body),
		        dataType: "json",
		        success: function(response) {
		            console.log(response);
		            if (response.status == "success") {
		            	$("#password-error").html("");
		            } else {
		            	$("#password-error").html("Incorrect Password.Try With Correct Password.");
		            }
		        },
		        error: function(error) {
		        	$("#username-error").html("Error While Getting password.");
		            console.log(error);
		        }
		    });
	        validateForm();
	    });
	}
	showPassword = () => {
	    $("#showPassword").change((event) => {
	        if ($(event.target).is(":checked")) {
	            $("#password").attr("type", "text");
	        } else {
	            $("#password").attr("type", "password");
	        }
	    });
	}
	checkPassword();
	checkUserName();
	showPassword();