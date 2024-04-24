<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style>
body {
  font-family: "Lato", sans-serif;
}

.sidenav {
  height: 100%;
  width: 36px;
  position: fixed;
  z-index: 1;
  top: 0;
  left: 0;
  background-color: #F4F5F7;
  overflow-x: hidden;
  transition: 0.5s;
  margin-top: 56px;
}

.sidenav button {
  text-decoration: none;
  font-size: 25px;
  color: #818181;
  display: block;
  transition: 0.3s;
  width: 100%;
  border-width: 0;
}

.closebtn {
  border-radius: 50%;
  background-color: white;
  padding: 0;
  margin-right: -36px;
  top: 0;
  right: 4%;
  z-index: 100;
  font-size: 18px;
  margin-left: 50px;
  border: 2px solid black;
  position:relative;
  cursor:pointer;
  transition: 0.5s;
}
#home span,#server span,#clipboard span,#phone span{
font-size: 18px;
}

@media screen and (max-height: 450px) {
  .sidenav {padding-top: 15px;}
  .sidenav a {font-size: 18px;}
}
</style>
</head>
<body>
<jsp:include page="jscss.jsp"></jsp:include>
<jsp:include page="navbar.jsp"></jsp:include>
<div id="mySidenav" class="sidenav">
  <button href="#" id="home"><i class="fa fa-home" aria-hidden="true"></i><span></span></button>
  <button href="#" id="server"><i class="fa fa-server" aria-hidden="true"></i><span></span></button>
  <button href="#" id="clipboard"><i class="fa fa-clipboard" aria-hidden="true"></i><span></span></button>
  <button href="#" id="phone"><i class="fa fa-volume-control-phone" aria-hidden="true"></i><span></span></button>
</div>
<script>
$(document).ready(function(){
    // Handle hover event
    $("#mySidenav").hover(
        function(){
        	document.getElementById("mySidenav").style.width = "250px";
        	$('#home span').html("Home");
        	$('#server span').html("Server");
        	$('#clipboard span').html("Clipboard");
        	$('#phone span').html("Phone");
        },
        function(){
        	$('#home span').html("");
        	$('#server span').html("");
        	$('#clipboard span').html("");
        	$('#phone span').html("");
        	document.getElementById("mySidenav").style.width = "36px";
        }
    );
});
</script>
</body>
</html>