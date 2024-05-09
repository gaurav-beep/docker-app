<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style>
body {
	background-color: #ebecf0;
}

.otp-letter-input {
	max-width: 100%;
	height: 90px;
	border: 1px solid #198754;
	border-radius: 10px;
	color: #198754;
	font-size: 60px;
	text-align: center;
	font-weight: bold;
}

.btn {
	height: 50px;
}
</style>
</head>
<body>
	<jsp:include page="jscss.jsp"></jsp:include>
	<div class="container p-5">
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-5 mt-5">
				<div class="bg-white p-5 rounded-3 shadow-sm border">
					<div>
						<p class="text-center text-success" style="font-size: 5.5rem;">
							<i class="fa-solid fa-envelope-circle-check"></i>
						</p>
						<p class="text-center text-center h5 ">Please check your email</p>
						<p class="text-muted text-center">We've sent a code to ${user.email}</p>
						<input type="number" id="otpInput" min="0" max="9999" placeholder="Enter OTP"/>
						<p id="otp-error" class="text-danger" style="font-size:small;"></p>
						<p class="text-muted text-center">
							Didn't get the code? <a href="#" class="text-success">Click
								to resend.</a>
						</p>

						<div class="row pt-5">
							<div class="col-6">
								<button class="btn btn-outline-secondary w-100">Cancel</button>
							</div>
							<div class="col-6">
								<button class="btn btn-success w-100" id="verifyOtp">Verify</button>
							</div>


						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
	const otp = "${otp}";
	const userString = JSON.parse('${userString}');
	const username = "${user.username}"
	</script>
	<script src="${pageContext.request.contextPath}/static/js/otpverify.js"></script>
</body>
</html>