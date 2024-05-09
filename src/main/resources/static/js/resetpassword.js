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
	    let checkpassword = $('#password').val().trim().length > 0 && $('#password-error').html().trim().length == 0;
	    let checkconfirmpassword = $('#confirmpassword').val().trim().length > 0 && $('#confirmpassword-error').html().trim().length == 0;
	    if (checkpassword && checkconfirmpassword) {
	        $("#forgetSubmit").removeAttr("disabled");
	    } else {
	        $("#forgetSubmit").attr("disabled", "disabled");
	    }
	}
	$('#forgetSubmit').click((e)=>{
		e.preventDefault();
		let username = $('#username').val();
		let password = $('#password').val();
		let body={"username":username,"password":password};
		$.ajax({
	        url: "/docker-app/forget/submit",
	        method: "POST",
	        contentType: "application/json",
	        data: JSON.stringify(body),
	        dataType: "json",
	        success: function(response) {
		        if(response.status=='success'){
		        	window.location.replace("/docker-app/login");
			    }else{
				    alert("Error While Forgetting Password.");
				}
	        },
	        error: function(error) {
	        	console.log("error : "+error);
	        }
	    });
		
	})
	 checkPassword();
	 checkConfirmPassword();
	 showPassword();