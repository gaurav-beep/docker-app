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
						</div>
						<div id="forget-password-div" class="d-none">
							<div class="form-group">
								<label for="password">Password</label> <input type="password"
									class="form-control" id="password" name="password"
									path="password" placeholder="Enter password">
							</div>
							<div class="form-group">
								<label for="confirmpassword">Confirm Password</label> <input type="password"
									class="form-control" id="confirmpassword" name="confirmpassword"
									placeholder="Enter Confirm password">
							</div>
						</div>
					</div>
					<div class="modal-footer ">
						<a href="/docker-app/login" class="btn btn-primary float-right">Back</a>
						<button id="checkusername" type="submit" class="btn btn-primary float-left">Submit</button>
					</div>
				</form>
			</div>

		</div>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script>
	$('#checkusername').click(() => {
	    let username = $("#username").val();
	    if (username.trim() === "") {
	    	$("#custom-alert").removeClass("d-none");
	    	$("#custom-alert").html("Please Provide Username.");
	        return false;
	    }
	    if(!($("#forget-password-div").hasClass('d-none'))){
	    	let password = $("#password").val();
		    let confirmpassword = $("#confirmpassword").val();
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
		}else{
			$("#custom-alert").addClass("d-none");
	    	$("#custom-alert").html("");
		}
	    if($("#forget-password-div").hasClass('d-none')){
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
		                $("#forget-password-div").removeClass("d-none");
		                $("#custom-alert").addClass("d-none");
		    	    	$("#custom-alert").html("");
		            } else {
		                $("#forget-password-div").addClass("d-none");
		                $("#custom-alert").removeClass("d-none");
		    	    	$("#custom-alert").html("Username Does Not Exist.");
		            }
		        },
		        error: function(error) {
		            $("#forget-password-div").addClass("d-none");
		            $("#custom-alert").removeClass("d-none");
		            $("#custom-alert").html("Username Does Not Exist.");
		            console.log(error);
		        }
		    });
		    return false;
	    }else{
		    return true;
		}
	});

	</script>
</body>
</html>