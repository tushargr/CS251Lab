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

function test_input($data) {
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}

if($_POST["stage"]=="authentication"){
	$return = <<<HTML
	<!DOCTYPE html>
	<html>
	<head>
	<title>Admin Authentication</title>
	<style>
		form { 
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
		<button name="anotherreg" style="float:right;" onclick="window.location='/index.php';">Another Registration</button>
		<form action="admin.php" method="post">
				<center><label for="register"><h2>Admin Authentication</h2></label></center>
				<br />
				<input type="hidden" name="stage" value="details" >	
				<label style="float:left;" for="name"><strong>Admin login :</strong></label>
				<input style="float:right;" type="text" name="adminlogin" required />
				<br /><br />
				<label style="float:left;" for="passwd"><strong>Password :</strong></label>
				<input style="float:right;" type="password" name="adminpasswd" required/>
				<br /><br />
				<center><input type="submit" value="Log in" name="adminauth"></center>
		</form>
	</body>
	</html>
HTML;
	echo $return;
}

else if($_POST["stage"]=="details"){
	$db = new SQLite3('mysqlitedb.db');
	$adminlogin=test_input($_POST["adminlogin"]);
	$adminpasswd=test_input($_POST["adminpasswd"]);
	$result = $db->query("SELECT * FROM admin WHERE adminlogin = '$adminlogin'");
	$count=0;
	while($row = $result->fetchArray()) {
		$count++;
	}
	if($count == 0){
		$_SESSION["error"]="Login Failed: Admin login not found";
		header('Location: admin.php');
		exit;
	}
	else if($count == 1){
		$row = $result->fetchArray();
		if(strcmp($row[1],$adminpasswd)!=0){
			$_SESSION["error"]="Login Failed: Password Incorrect";
			header('Location: admin.php');
			exit;
		}
		else{
			$return = <<<HTML
	<!DOCTYPE html>
	<html>
	<head>
	<title>All Registration</title>
	<style>
		table{
			 border-collapse: collapse;
			 border: 1px solid black;
			 width:80%;
		}
		th,td{
			border: 1px solid black;
		 	border-collapse: collapse;	
		}
	</style>
	</head>
	<body>
		<button name="anotherreg" style="float:right;" onclick="window.location='/index.php';">Another Registration</button>
		<center><h2>All Registration</h2></center>
		<br /><br />
		<center><table>
		<tr>
			<th>Name</th>
    		<th>Address</th> 
    		<th>Email</th> 
    		<th>Mobile</th> 
    		<th>Account no.</th>
		</tr>
HTML;
			
			$results = $db->query('SELECT * FROM registrations');
			while($row = $results->fetchArray()){
	    		$return .= <<<HTML
		<tr>
			<td>{$row[0]}</td>
    		<td>{$row[1]}</td> 
    		<td>{$row[2]}</td> 
    		<td>{$row[3]}</td> 
    		<td>{$row[4]}</td>
		</tr>
HTML;
			}
			$return .= <<<HTML
		</table></center>
		</body>
	</html>
HTML;
			echo $return;
		}	
	}
	
}

else{
	$return = <<<HTML
	<!DOCTYPE html>
	<html>
	<head>
	<title>Admin Authentication</title>
	<style>
		form { 
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
		<button name="anotherreg" style="float:right;" onclick="window.location='/index.php';">Another Registration</button>
		<form action="admin.php" method="post">
				<center><label for="register"><h2>Admin Authentication</h2></label></center>
				<br />
				<input type="hidden" name="stage" value="details" >	
				<label style="float:left;" for="name"><strong>Admin login :</strong></label>
				<input style="float:right;" type="text" name="adminlogin" required />
				<br /><br />
				<label style="float:left;" for="passwd"><strong>Password :</strong></label>
				<input style="float:right;" type="password" name="adminpasswd" required/>
				<br /><br />
				<center><input type="submit" value="Log in" name="adminauth"></center>
		</form>
	</body>
	</html>
HTML;
	echo $return;
}
?>