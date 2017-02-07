<?php
require('connect.php'); 

	$email =$_POST["email"];

	$pwd =$_POST["password"];

	$name =$_POST["nickname"];





$sql="INSERT INTO account(id,username,password,nickname) VALUES(null,'$email','$pwd','$name')";
mysql_query($sql,$con) or die("失敗" .mysql_error());

mysql_close($con); 
?>