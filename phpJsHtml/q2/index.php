<?php

session_start();

if(isset($_SESSION["msg"])) {
	$msg = $_SESSION["msg"];
	session_unset($_SESSION["msg"]);
} else {
	$msg = "";
}
if(isset($_SESSION["error"])) {
	$error = $_SESSION["error"];
	session_unset($_SESSION["error"]);
} else {
	$error = "";
}


	$return = <<<HTML
	<!DOCTYPE html>
<html>
<head>
<title>Register</title>
<style>
	.register_form { 
		margin: 0 auto; 
		width:280px;
	}
	.message {
		color:green;
	}
	.error {
		color:red;
	}

</style>
</head>


<body>
	<div class="message"><center>{$msg}</center></div><br />
	<div class="error"><center>{$error}</center></div><br />
	<form action="admin.php" method="post">
	<input type="hidden" name="stage" value="authentication" >	
	<input type="submit" name="allreg" style="float:right;" value="See All Registration" >
	</form>
	<form action="register.php" method="post" class="register_form">
			<center><label for="register"><h2>Registration</h2></label></center>
			<br />
			<label style="float:left;" for="name"><strong>Name :</strong></label>
			<input style="float:right;" type="text" name="name" pattern="[A-Za-z]{1}[A-Za-z ]+[A-Za-z]{1}" maxlength="20" required />
			<br /><br />
			<label style="float:left;" for="address"><strong>Address :</strong></label>
			<input style="float:right;" type="text" name="address" maxlength="100" required />
			<br /><br />
			<label style="float:left;" for="email"><strong>Email :</strong></label>
			<input style="float:right;" type="text" pattern="[A-Za-z]+[@]{1}[A-Za-z]+.com" name="email"  required />
			<br /><br />
			<label style="float:left;" for="mobile"><strong>Mobile No. :</strong></label>
			<input style="float:right;" type="text" pattern="[1-9]{1}[0-9]{9}" name="mobile"  required/>
			<br /><br />
			<label style="float:left;" for="acntno"><strong>Bank Acnt No. :</strong></label>
			<input style="float:right;" type="text" pattern="[0-9]{5}" name="acntno" required/>
			<br /><br />
			<label style="float:left;" for="passwd"><strong>Password :</strong></label>
			<input style="float:right;" type="password" pattern="[1-9A-Za-z]+" name="acntpasswd" required/>
			<br /><br />
			<center><input type="submit" value="Register"></center>
			<br /><br /><br />
	</form>
	<div><center>
				name : Maximum 20 characters with only english alphabets and space<br />
				address: Maximum 100 characters<br />
				email should be of the form &quot; someone@xyz.com &quot; where leftside may contain
				english alphabets only and rightside must end with a &quot; .com &quot; domain name<br />
				Mobile number is a 10-digit numeric value<br />
				Bank account number is a 5-digit numeric value<br />
				Bank password can be maximum 20 alphanumeric characters<br />
	</center></div>

</body>
</html>
HTML;
	echo $return;
?>