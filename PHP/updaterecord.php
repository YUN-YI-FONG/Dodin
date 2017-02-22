<?php
//updaterecord.php
require('connect.php');

$playernumber = $_POST['number'];
$redteamscore = $_POST['redscore'];
$blueteamscore = $_POST['bluescore'];
$player1 = $_POST['player1'];
$player2 = $_POST['player2'];
$id = $_POST['roomtime'];
$playerT = array();
if($playernumber == 4){
	$playerT = array($player1,$player2);
}else if($playernumber == 4){

	$player3 = $_POST['player3'];
	$player4 = $_POST['player4'];
	$playerT = array($player1,$player2,$player3,$player4);
	
}



if($redteamscore > $blueteamscore){

	$sql="INSERT INTO record(id,red_score,blue_score,win) VALUES('$id','$redteamscore','$blueteamscore','RW')";
	$result= mysql_query($sql,$con) or die("失敗" .mysql_error());

}else if($redteamscore < $blueteamscore){

	$sql="INSERT INTO record(id,red_score,blue_score,win) VALUES('$id','$redteamscore','$blueteamscore','BW')";
	$result= mysql_query($sql,$con) or die("失敗" .mysql_error());

}

sleep(2);

for($i=0 ; $i<count($playerT);$i++){

	$sql="INSERT INTO record(id,nickname) VALUES('$id','$playerT[$i]')";
	$result= mysql_query($sql,$con) or die("失敗" .mysql_error());

}
