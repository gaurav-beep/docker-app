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
<div class="alert alert-danger d-none" role="alert" id="custom-alert">
</div>
<div class="modal bg-muted d-block" id="myModal" role="dialog" >
		<div class="modal-dialog">

			<!-- Modal content-->

			<div class="modal-content">
				<form action="forgetPassword" method="POST">
					<div class="modal-header">
					<h4 class="modal-title" style="text-align:center">Forget Password</h4>
						
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label for="username">User Name</label> <input type="text"
								class="form-control" id="username" name="username"
								path="username" placeholder="Enter User Name">
								<p id="username-error" class="text-danger" style="font-size:small;"></p>
						</div>
						<div id="forget-password-div" class="d-none">
							<div class="form-group">
								<label for="password">Password</label> <input type="password"
									class="form-control" id="password" name="password"
									path="password" placeholder="Enter password">
									<input type="checkbox" id="showPassword"> Show Password
								<p id="password-error" class="text-danger" style="font-size:small;"></p>
							</div>
							<div class="form-group">
								<label for="confirmpassword">Confirm Password</label> <input type="password"
									class="form-control" id="confirmpassword" name="confirmpassword"
									placeholder="Enter Confirm password">
									<p id="confirmpassword-error" class="text-danger" style="font-size:small;"></p>
							</div>
						</div>
					</div>
					<div class="modal-footer ">
						<a href="/docker-app/login" class="btn btn-primary float-right">Back</a>
						<button id="forgetSubmit" type="submit" class="btn btn-primary float-left" disabled="true">Submit</button>
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
			            	$("#forget-password-div").removeClass('d-none');
			            	$("#username-error").html("");
			            } else {
			            	$("#username-error").html("Username Does Not Exists.");
			            	$("#forget-password-div").addClass('d-none');
			            }
			        },
			        error: function(error) {
			        	$("#forget-password-div").addClass('d-none');
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
	validateForm = () => {
	    let checkusername = $('#username').val().trim().length > 0 && $('#username-error').html().trim().length == 0;
	    let checkpassword = $('#password').val().trim().length > 0 && $('#password-error').html().trim().length == 0;
	    let checkconfirmpassword = $('#confirmpassword').val().trim().length > 0 && $('#confirmpassword-error').html().trim().length == 0;
	    if (checkusername && checkpassword && checkconfirmpassword) {
	        $("#forgetSubmit").removeAttr("disabled");
	    } else {
	        $("#forgetSubmit").attr("disabled", "disabled");
	    }
	}
	 checkUserName();
	 checkPassword();
	 checkConfirmPassword();
	 showPassword();
	</script>
</body>
</html>