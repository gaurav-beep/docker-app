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
				<form action="submit" method="POST">
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
	<script src="${pageContext.request.contextPath}/static/js/register.js"></script>
</body>
</html>
	