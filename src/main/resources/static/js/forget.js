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
			            if (response.status == "success") {
			            	$("#username-error").html("");
			            } else {
			            	$("#username-error").html("Username Does Not Exists.");
			            }
			            validateForm();
			        },
			        error: function(error) {
			        	$("#username-error").html("Error While Getting Username.");
			            console.log(error);
			        }
			    });
		});
	}
	validateForm = () => {
	    let checkusername = $('#username').val().trim().length > 0 && $('#username-error').html().trim().length == 0;
	    if (checkusername) {
	        $("#forgetSubmit").removeAttr("disabled");
	    } else {
	        $("#forgetSubmit").attr("disabled", "disabled");
	    }
	}
	 checkUserName();