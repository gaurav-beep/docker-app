<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
</head>
<body>
<jsp:include page="jscss.jsp"></jsp:include>
<div class="modal bg-muted d-block" id="myModal" role="dialog" >
		<div class="modal-dialog">

			<!-- Modal content-->

			<div class="modal-content">
				<form action="registerUser" method="POST">
					<div class="modal-header">
					<h4 class="modal-title" style="text-align:center">Register</h4>
						
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label for="username">User Name</label> <input type="text"
								class="form-control" id="username" name="username"
								path="username" placeholder="Enter User Name" required>
							<p id="username-error" class="text-danger" style="font-size:small;"></p>
						</div>
						<div class="form-group">
							<label for="password">Password</label> <input type="password"
								class="form-control" id="password" name="password"
								path="password" placeholder="Enter password" required>
								<input type="checkbox" id="showPassword"> Show Password
								<p id="password-error" class="text-danger" style="font-size:small;"></p>
						</div>
						<div class="form-group">
							<label for="confirmpassword">Confirm Password</label> <input type="password"
								class="form-control" id="confirmpassword" name="confirmpassword"
								placeholder="Enter Confirm password" required>
								<p id="confirmpassword-error" class="text-danger" style="font-size:small;"></p>
						</div>
						<div class="form-group">
							<label for="email">Email</label> <input type="email"
								class="form-control" id="email" name="email" path="email"
								placeholder="Enter Email" required>
								<p id="email-error" class="text-danger" style="font-size:small;"></p>
						</div>
					</div>
					<div class="modal-footer ">
						<a href="/docker-app/login" class="btn btn-primary float-right">Back</a>
						<button id="registerSubmit" type="submit" class="btn btn-primary float-left" disabled="true">Submit</button>
					</div>
				</form>
			</div>

		</div>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	 <script>
	checkConfirmPassword=()=>{
		 $("#confirmpassword").on("input", () => {
			    let confirmpassword = $('#confirmpassword').val();
			    let password = $('#password').val();
			    if (password!=confirmpassword) {
			        $("#confirmpassword-error").html("Password And Confirm Password Should Be Same.");
			    }else{
				    $("#confirmpassword-error").html("");
				}
			    validateForm();
		});
	}
	 checkPassword = () => {
		    $("#password").on("input", () => {
		        let password = $('#password').val();
		        let confirmpassword = $("#confirmpassword").val();
		        let regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[^\w\s]).{8,}$/;
		        if (!regex.test(password)) {
		            $("#password-error").html("Password should contain at least one uppercase letter, one lowercase letter, one numeric digit, and one special character, and should be at least 8 characters long.");
		        } else {
		            $("#password-error").html("");
		        }
		        if (confirmpassword.trim().length > 0) {
		        	let confirmpassword = $('#confirmpassword').val();
				    let password = $('#password').val();
				    if (password!=confirmpassword) {
				        $("#confirmpassword-error").html("Password And Confirm Password Should Be Same.");
				    }else{
					    $("#confirmpassword-error").html("");
					}
		        }
		        validateForm();
		    });
		}

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
			            	$("#username-error").html("Username Alreday Taken.Try With Different Username.");
			            } else {
			            	$("#username-error").html("");
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
	showPassword = () => {
	    $("#showPassword").change((event) => {
	        if ($(event.target).is(":checked")) {
	            $("#password").attr("type", "text");
	        } else {
	            $("#password").attr("type", "password");
	        }
	    });
	}

	checkEmail=()=>{
		$("#email").on("input", () => {
			let email = $('#email').val();
			var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	   	 	if(!(emailRegex.test(email))){
	   	 		$("#email-error").html("Invalid Email Address.Please Provide Valid Email Address.");
		    }
	   	 	validateForm();
		});
	}

	validateForm = () => {
	    let checkusername = $('#username').val().trim().length > 0 && $('#username-error').html().trim().length == 0;
	    let checkemail = $('#email').val().trim().length > 0 && $('#email-error').html().trim().length == 0;
	    let checkpassword = $('#password').val().trim().length > 0 && $('#password-error').html().trim().length == 0;
	    let checkconfirmpassword = $('#confirmpassword').val().trim().length > 0 && $('#confirmpassword-error').html().trim().length == 0;
	    if (checkusername && checkemail && checkpassword && checkconfirmpassword) {
	        $("#registerSubmit").removeAttr("disabled");
	    } else {
	        $("#registerSubmit").attr("disabled", "disabled");
	    }
	}
	 checkUserName();
	 checkPassword();
	 checkConfirmPassword();
	 showPassword();
	 checkEmail();
</script> 
</body>
</html>