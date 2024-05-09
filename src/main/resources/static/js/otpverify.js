$('#verifyOtp').click(()=>{
		let otpInput = $('#otpInput').val();
		if(otpInput!=null&&otpInput==otp){
			$("#otp-error").html("");
			var currentUrl = window.location.href;
			if(currentUrl.indexOf('forget')!=-1){
				window.location.replace("/docker-app/forget/resetPassword?username="+username);
			}else{
				let body=userString;
				$.ajax({
			        url: "/docker-app/register/submit",
			        method: "POST",
			        contentType: "application/json",
			        data: JSON.stringify(body),
			        dataType: "json",
			        success: function(response) {
				        if(response.status=='success'){
				        	window.location.replace("/docker-app/login");
					    }else{
						    alert("Error While Registering User.");
						}
			        },
			        error: function(error) {
			        	console.log("error : "+error);
			        }
			    });
			}

		}else{
			$("#otp-error").html("Invalid Otp.");
		}
	});