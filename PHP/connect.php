<?php


$host="localhost";                  //replace with your hostname 
$username="root";       //replace with your username 
$password="";               //replace with your password 
$db_name="sample1922";                //replace with your database 
$con = mysql_connect($host, $username, $password) or die("cannot connect"); 
mysql_select_db($db_name, $con) or die("mysql_select_db() 資料庫無法連結！".mysql_error()); 
?>