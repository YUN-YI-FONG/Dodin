<?php
//Register2.php
require('connect.php'); 

$email = $_POST["email"];
$country =$_POST["country"];
$firstname = $_POST["firstname"];
$lastname = $_POST["lastname"];
$sex = $_POST["gender"];
$date = date("Y-m-d H:i:s");

$sql = "SELECT entity_id FROM customer_entity WHERE email='$email'";
$result = mysql_query($sql,$con) or die("失敗" .mysql_error());

while($row = mysql_fetch_array($result)){//印出資料
              $id=$row['entity_id'];
      }

$sql2 = "SELECT entity_id FROM customer_address_entity WHERE parent_id='$id'";
$result2 = mysql_query($sql2,$con) or die("失敗2" .mysql_error());

while($row = mysql_fetch_array($result2)){//印出資料
              $id2=$row['entity_id'];
      }

$sql3="INSERT INTO customer_address_entity_varchar(value_id,entity_type_id,attribute_id,	entity_id,value) VALUES (null,'2','18','$id2',null),(null,'2','20','$id2','$firstname'),(null,'2','21','$id2',null),(null,'2','22','$id2','$lastname'),(null,'2','23','$id2',null),(null,'2','24','$id2',null),(null,'2','26','$id2',null),(null,'2','27','$id2','$country'),(null,'2','28','$id2',null),(null,'2','30','$id2',null),(null,'2','31','$id2',null),(null,'2','32','$id2',null),(null,'2','36','$id2',null)";
mysql_query($sql3,$con) or die("失敗3" .mysql_error());

/*$sql4="INSERT INTO customer_address_entity_varchar(value_id,entity_type_id,attribute_id,	entity_id,value) VALUES(null,'2','20','$id','$firstname')";
mysql_query($sql4,$con) or die("失敗4" .mysql_error());
$sql5="INSERT INTO customer_address_entity_varchar(value_id,entity_type_id,attribute_id,	entity_id,value) VALUES(null,'2','21','$id',null)";
mysql_query($sql5,$con) or die("失敗5" .mysql_error());
$sql6="INSERT INTO customer_address_entity_varchar(value_id,entity_type_id,attribute_id,	entity_id,value) VALUES(null,'2','22','$id','$lastname')";
mysql_query($sql6,$con) or die("失敗6" .mysql_error());
$sql7="INSERT INTO customer_address_entity_varchar(value_id,entity_type_id,attribute_id,	entity_id,value) VALUES(null,'2','23','$id',null)";
mysql_query($sql7,$con) or die("失敗7" .mysql_error());
$sql8="INSERT INTO customer_address_entity_varchar(value_id,entity_type_id,attribute_id,	entity_id,value) VALUES(null,'2','24','$id',null)";
mysql_query($sql8,$con) or die("失敗8" .mysql_error());
$sql9="INSERT INTO customer_address_entity_varchar(value_id,entity_type_id,attribute_id,	entity_id,value) VALUES(null,'2','26','$id',null)";
mysql_query($sql9,$con) or die("失敗9" .mysql_error());
$sql10="INSERT INTO customer_address_entity_varchar(value_id,entity_type_id,attribute_id,	entity_id,value) VALUES(null,'2','27','$id','$country')";
mysql_query($sql10,$con) or die("失敗10" .mysql_error());
$sql11="INSERT INTO customer_address_entity_varchar(value_id,entity_type_id,attribute_id,	entity_id,value) VALUES(null,'2','28','$id',null)";
mysql_query($sql11,$con) or die("失敗11" .mysql_error());
$sql12="INSERT INTO customer_address_entity_varchar(value_id,entity_type_id,attribute_id,	entity_id,value) VALUES(null,'2','30','$id',null)";
mysql_query($sql12,$con) or die("失敗12" .mysql_error());
$sql13="INSERT INTO customer_address_entity_varchar(value_id,entity_type_id,attribute_id,	entity_id,value) VALUES(null,'2','31','$id',null)";
mysql_query($sql13,$con) or die("失敗13" .mysql_error());
$sql14="INSERT INTO customer_address_entity_varchar(value_id,entity_type_id,attribute_id,	entity_id,value) VALUES(null,'2','32','$id',null)";
mysql_query($sql14,$con) or die("失敗14" .mysql_error());
$sql15="INSERT INTO customer_address_entity_varchar(value_id,entity_type_id,attribute_id,	entity_id,value) VALUES(null,'2','36','$id',null)";
mysql_query($sql15,$con) or die("失敗15" .mysql_error());
*/
if($sex=="male"){
	$gender = 1;
}else{
	$gender = 2;
}

$sql5="INSERT INTO customer_entity_int(value_id,entity_type_id,attribute_id,	entity_id,value) VALUES(null,'1','13','$id','$id2')";
mysql_query($sql5,$con) or die("失敗6" .mysql_error());

$sql4="INSERT INTO customer_entity_int(value_id,entity_type_id,attribute_id,	entity_id,value) VALUES(null,'1','18','$id','$gender')";
mysql_query($sql4,$con) or die("失敗4" .mysql_error());


