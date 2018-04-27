<?php
session_start();
$db = new SQLite3('mysqlitedb.db');

function test_input($data) {
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}


$name = test_input($_POST["name"]);
$address = test_input($_POST["address"]);
$email = test_input($_POST["email"]);
$mobile = (int)(test_input($_POST["mobile"]));
$acntno = (int)(test_input($_POST["acntno"]));
$acntpasswd = test_input($_POST["acntpasswd"]);

$result = $db->query("SELECT * FROM registrations WHERE email = '$email'");
$count=0;
while($row = $result->fetchArray()) {
	$count++;
}
if($count > 0){
	$_SESSION["error"]="Registration Failed: Already Registered";
	header('Location: index.php');
	exit;
}
$result=$db->query("SELECT * FROM accounts WHERE acntno = '$acntno'");
$count=0;
while($row = $result->fetchArray()) {
	$count++;
}
if($count == 0){
	$_SESSION["error"]="Registration Failed: Bank Account no. does not exist";
	header('Location: index.php');
	exit;
}
$row=$result->fetchArray();
if(strcmp($row[1],$acntpasswd)!=0){
	$_SESSION["error"]="Registration Failed: Password Incorrect";
	header('Location: index.php');
	exit;
}
if($row[2]<1000){
	$_SESSION["error"]="Registration Failed: Account Balance less than 1000";
	header('Location: index.php');
	exit;	
}
else{
	$newbal=(int)($row[2])-1000;
	$db->exec("UPDATE accounts SET balance='$newbal' WHERE acntno='$acntno'");

	$db->exec("INSERT INTO registrations (name, address, email, mobile, acntno, acntpasswd) VALUES ('$name', '$address','$email','$mobile', '$acntno','$acntpasswd')");

	$_SESSION["msg"]="Registration Successful";
	header('Location: index.php');
	exit;
}

?>