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
<c:if test="${error ne null}">
<div class="alert alert-danger" role="alert">
  ${error}
</div>
</c:if>
<div class="modal bg-muted d-block" id="myModal" role="dialog" >
		<div class="modal-dialog">

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
						</div>
						<div class="form-group">
							<label for="password">Password</label> <input type="password"
								class="form-control" id="password" name="password"
								path="password" placeholder="Enter password" required>
						</div>
					</div>
					<div class="modal-footer ">
						<a href="/docker-app/register"  class="btn btn-primary float-right">Register</a>
						<button type="submit" class="btn btn-primary float-left">Submit</button>
					</div>
				</form>
			</div>

		</div>
	</div>
</body>
</html>