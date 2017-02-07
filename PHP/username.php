<?php 
require('connect.php'); 
$email=$_POST["email"];
$json = array(); 

$sql2="select nickname from account where username = '$email'";
			
$result= mysql_query($sql2,$con) or die("失敗2" .mysql_error());


if(mysql_num_rows($result)){

	while($row = mysql_fetch_array($result)){//印出資料
	        $json[]=$row['nickname'];
	  
	    }
	 print json_encode($json);   
} 



mysql_close($con); 

?>