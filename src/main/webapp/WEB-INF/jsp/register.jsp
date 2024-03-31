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
        let password = $("#password").val();
        let confirmpassword = $("#confirmpassword").val();
        let passwordField = document.getElementById("password");
        let confirmPasswordField = document.getElementById("confirmpassword");

        if (!password) {
            passwordField.setCustomValidity("Password should not be empty.");
            confirmPasswordField.setCustomValidity("");
            return false;
        }
        if (!confirmpassword) {
            confirmPasswordField.setCustomValidity("Confirm password should not be empty.");
            passwordField.setCustomValidity("");
            return false;
        }
        if (password === confirmpassword) {
            confirmPasswordField.setCustomValidity("");
            passwordField.setCustomValidity("");
            return true;
        } else {
            passwordField.setCustomValidity("");
            confirmPasswordField.setCustomValidity("Password and confirm should be same.");
            return false;
        }
    });
</script>
</body>
</html>