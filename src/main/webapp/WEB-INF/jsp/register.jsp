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
				<form action="registerUser" method="POST">
					<div class="modal-header">
					<h4 class="modal-title" style="text-align:center">Register</h4>
						
					</div>
					<div class="modal-body">
						<%--disable csrf in web config file --%>
						<%-- <input type="hidden"
						    name="${_csrf.parameterName}"
						    value="${_csrf.token}"/>  --%>
						<div class="form-group">
							<label for="username">User Name</label> <input type="text"
								class="form-control" id="username" name="username"
								path="username" placeholder="Enter User Name" required>
						</div>
						<div class="form-group">
							<label for="password">Password</label> <input type="password"
								class="form-control" id="password" name="password"
								path="password" placeholder="Enter password" required>
						</div>
						<div class="form-group">
							<label for="confirmpassword">Confirm Password</label> <input type="password"
								class="form-control" id="confirmpassword" name="confirmpassword"
								placeholder="Enter Confirm password" required>
						</div>
						<div class="form-group">
							<label for="email">Email</label> <input type="email"
								class="form-control" id="email" name="email" path="email"
								placeholder="Enter Email" required>
						</div>
					</div>
					<div class="modal-footer ">
						<a href="/docker-app/login" class="btn btn-primary float-right">Back</a>
						<button id="registerSubmit" type="submit" class="btn btn-primary float-left">Submit</button>
					</div>
				</form>
			</div>

		</div>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	 <script>
    $('#registerSubmit').click(() => {
	    let username = $("#username").val();
    	let password = $("#password").val();
	    let confirmpassword = $("#confirmpassword").val();
	    let email = $("#email").val();
	    if (username.trim() === "") {
	    	$("#custom-alert").removeClass("d-none");
	    	$("#custom-alert").html("Please Provide Username.");
	        return false;
	    }

    	if (password.trim() === "") {
	    	$("#custom-alert").removeClass("d-none");
	    	$("#custom-alert").html("Please Provide Password.");
	        return false;
	    }
	    
    	if (confirmpassword.trim() === "") {
	    	$("#custom-alert").removeClass("d-none");
	    	$("#custom-alert").html("Please Provide Confirm Password.");
	        return false;
	    }
	    
    	if (password!=confirmpassword) {
	    	$("#custom-alert").removeClass("d-none");
	    	$("#custom-alert").html("Password And Confirm Password Should Be Same.");
	        return false;
	    }

    	if (email.trim() === "") {
	    	$("#custom-alert").removeClass("d-none");
	    	$("#custom-alert").html("Please Provide Email Id.");
	        return false;
	    }else{
	    	 var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	    	 if(!emailRegex.test(email)){
	    		 $("#custom-alert").removeClass("d-none");
	 	    	 $("#custom-alert").html("Please Provide Proper Email Id.");
		    	 return false;
		     }
		}

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
	            	$("#custom-alert").removeClass("d-none");
	    	    	$("#custom-alert").html("Username Does Not Exist.");
	    	    	return false;
	            } else {
	                $("#custom-alert").addClass("d-none");
	    	    	$("#custom-alert").html("");
	    	    	return true;
	            }
	        },
	        error: function(error) {
	        	$("#custom-alert").removeClass("d-none");
    	    	$("#custom-alert").html("Error While Getting Username.");
    	    	return false;
	            console.log(error);
	        }
	    });
	});
</script> 
</body>
</html>