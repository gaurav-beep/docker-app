<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
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
			<c:if test="${error ne null}">
				<div class="alert alert-danger" role="alert">${error}</div>
			</c:if>
			<!-- Modal content-->

			<div class="modal-content">
				<form action="login" method="POST">
					<div class="modal-header">
					<h4 class="modal-title" style="text-align:center">Login</h4>
						
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
								<p id="username-error" class="text-danger" style="font-size:small;"></p>
						</div>
						<div class="form-group">
							<label for="password">Password</label> <input type="password"
								class="form-control" id="password" name="password"
								path="password" placeholder="Enter password" required disabled="true">
								<input type="checkbox" id="showPassword"> Show Password
								<p id="password-error" class="text-danger" style="font-size:small;"></p>
						</div>
					</div>
					<div class="modal-footer">
						<a href="/docker-app/forget/form"  class="btn btn-info">Forget Password</a>
						<a href="/docker-app/register/form"  class="btn btn-primary">Register</a>
						<button id="loginSubmit"  type="submit" class="btn btn-success" disabled="true">Submit</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script src="${pageContext.request.contextPath}/static/js/login.js"></script>
</body>
</html>