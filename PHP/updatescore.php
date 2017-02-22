<?php
//updatescore.php
require('connect.php');
$playernumber = $_POST['number'];
$idT =  array();
$playerT = array();
//判斷有幾個人
if($playernumber == 1){
	$player1 = $_POST['player1'];
	$score1 = $_POST['score1'];

	$playerT = array($player1);
	$scoreT = array($score1);
}else if($playernumber == 2 ){
	$player1 = $_POST['player1'];
	$score1 = $_POST['score1'];
	$player2 = $_POST['player2'];
	$score2 = $_POST['score2'];

	$playerT = array($player1,$player2);
	$scoreT = array($score1,$score2);
}else if($playernumber == 4 ){
	$player1 = $_POST['player1'];
	$score1 = $_POST['score1'];
	$player2 = $_POST['player2'];
	$score2 = $_POST['score2'];
	$player3 = $_POST['player3'];
	$score3 = $_POST['score3'];
	$player4 = $_POST['player4'];
	$score4 = $_POST['score4'];

	$playerT = array($player1,$player2,$player3,$player4);
	$scoreT = array($score1,$score2,$score3,$score4);
}

//從account找出他們的id
for($i=0 ; $i<count($playerT);$i++){
	$sql="select id from account where nickname = '$playerT[$i]'";
				
	$result= mysql_query($sql,$con) or die("失敗" .mysql_error());


	while($row = mysql_fetch_array($result)){//印出資料
		 $id=$row['id'];
		 array_push($idT,$id);		  
	}
}

//在score裡找到玩家的分數
for($i=0 ; $i<count($idT);$i++){
	$sql2="select score from score where id = '$idT[$i]'";
				
	$result2= mysql_query($sql2,$con) or die("失敗2" .mysql_error());


	while($row = mysql_fetch_array($result2)){//印出資料
		 $scoreT2=$row['score'];
		 		  
	}

	//判斷Score裡面有沒有上傳過的值 有的話直接修改 空值就新增一筆
	if($scoreT2 != null){
		$sql3="UPDATE score SET score='$scoreT[$i]' WHERE id='$idT[$i]'";
		$result3= mysql_query($sql3,$con) or die("失敗3" .mysql_error());
	}else{
		$sql3="INSERT INTO score(id,score) VALUES('$idT[$i]','$scoreT[$i]')";

		$result3= mysql_query($sql3,$con) or die("失敗3" .mysql_error());
	}
}

?>