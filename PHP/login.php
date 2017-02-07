<?php
	// 載入設定檔案 - Load config file.
	require_once('dd-config.php');

	// 接收Post資料 並檢查是否為空 - Get post's data and check is null.
	if (!isset($_GET['username']) or !isset($_GET['password'])  )
	{
		$data_array = array(
				'ResultCode' => 3,
				'Message' => "Invild parameter",
			);


		echo json_encode($data_array);
		exit;
	}

	$mysqli = new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
	// 檢查是否連接 - Check is link?
	if (mysqli_connect_error($mysqli)) {
		echo "Failed to connect to MySQL:" . $mysqli->connect_error; 
	} 

	$username = $_GET['username'];
	$password = $_GET['password'];	

	$sql = "SELECT username , password, nickname FROM account WHERE username= '$username' "	;

	// 獲取帳號資料
	$result = mysqli_query($mysqli , $sql);
	$row = mysqli_fetch_array($result);

	if (mysqli_num_rows($result))
	{
		$data_array = array(
				'ResultCode' => 1,
				'Message' => 'Success!',
			);
	}
	else{
		$data_array = array(
				'ResultCode' => 2,
				'Message' => 'Wrong : [' . $username . $password . "]",

			);
	}

	echo json_encode($data_array);
	
	mysqli_free_result($result);
	$mysqli->close();
?>