<?php

session_start();
require('connect.php'); 


$_SESSION['Register']="";

$emailErr1 = null;
$emailErr2 = null;
$ageErr = null;
$pwdErr = null;
$nullErr = null;
$nameerror = null;

	//手機傳過來的值
	$firstname = $_POST["firstname"];
	$lastname = $_POST["lastname"];
	$username = $_POST["username"];
	$email = $_POST["email"];
	$pwd = $_POST["password"];
	$country =$_POST["country"];
	$age = $_POST["age"];
	$sex = $_POST["gender"];
	
	$date = date("Y-m-d H:i:s");


$error = array();




/******************************************************************************/

// magneto加密方式
			function getRandomString($length = 10)
			{
				$char = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
				$charLength = strlen($char);//得到字串長度
				$randomString = "";
				for($i = 0; $i < $length; $i++){
					$randomString .= $char[rand(0, $charLength - 1)];
				}//從$char字串中隨機抓取兩個字元

				return $randomString;	//回傳兩個字元
			}



			//$salt是隨機產生兩個字元
			 function getHash($password, $salt = false)
		    {
		        if (is_integer($salt)) {
		            $salt = getRandomString($salt);//隨機抓兩個字元
		        }
		        return $salt === false ? hash('md5',$password) :hash('md5',$salt . $password) . ':' . $salt;
		        //Magento加密密碼=$salt+$password結合起來做md5加密加上分號在加上$salt
		    }
/**************************************************************************/
		//判斷email格式有沒有效
		if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
			
	  		$emailErr1 = "無效的 email 格式！"; 
	  		
	  		
		}

		


		//判斷age是不是數字
		if( is_numeric($age)){
			
		}else{
			$ageErr = "age欄位請輸入正確數字";
			
		}

		//判斷密碼必須為數字與字母組合
		$plen=strlen($pwd);
		if(!preg_match("/^(([a-z]+[0-9]+)|([0-9]+[a-z]+))[a-z0-9]*$/i",$pwd)or$plen<6 or $plen>15){
		 	 $pwdErr = '密碼必須為6-15位的數字和字母的组合';
		 	
		}
		/**********************************/
		
		/**********************************/
		//判斷是不是空值
		if(empty($email) or empty($age) or empty($firstname) or empty($country) or empty($sex) or empty($pwd) or empty($lastname) or empty($username)){
			
			$nullErr ="不能有空值";

		}else{
			
		}

		if(is_null($username)){
				

			}else{
				$sql="SELECT value FROM customer_entity_varchar WHERE attribute_id = '217'";
				$result= mysql_query($sql,$con) or die("失敗" .mysql_error());
				$i=0;
				while($row = mysql_fetch_array($result)){//印出資料
				    	$usname[$i]=$row['value'];
				 		$i++;
				}
				if(isset($usname)){
					for($i=0;$i<count($usname);$i++){
						if($usname[$i]==$username){
							$nameerror = "username重覆";
						}
					}
				}
			}

	array_push($error,$emailErr1,$ageErr,$pwdErr,$nullErr,$nameerror);

		
/**************************************************************************/
//有錯誤就session=error 沒錯誤就session=correct並且新增到資料庫
if(is_null($emailErr1)&& is_null($ageErr)&& is_null($pwdErr) && is_null($nullErr)&& is_null($nameerror))
{
	
			$result ="correct";
			$_SESSION['Register']=$result;
			echo $_SESSION['Register'];

		     //getHash($pwd,2),$pwd->輸入的密碼,2->產生兩個字元
			
			$md52 = getHash($pwd,2);


	/*************************************************************************************/

		
			$sql2="INSERT INTO customer_entity(entity_id,entity_type_id,attribute_set_id,website_id,email,group_id,increment_id,store_id,created_at,updated_at,is_active,disable_auto_group_change) VALUES(null,'1','0','1','$email','1',null,'1','$date','$date','1','0')";

			 



			$sql3="SELECT entity_id from customer_entity WHERE email = '$email'";
			mysql_query($sql2,$con) or die("失敗2" .mysql_error());
			$result3= mysql_query($sql3,$con) or die("失敗3" .mysql_error());


			while($row = mysql_fetch_array($result3)){//印出資料
			        $id=$row['entity_id'];
			 
			    }
			    



			$sql4="INSERT INTO customer_entity_varchar(	value_id,entity_type_id,attribute_id,entity_id,value) VALUES(null,'1','5','$id','$firstname')";

			$sql5="INSERT INTO customer_entity_varchar(	value_id,entity_type_id,attribute_id,entity_id,value) VALUES(null,'1','7','$id','$lastname')";

			$sql6="INSERT INTO customer_entity_varchar(	value_id,entity_type_id,attribute_id,entity_id,value) VALUES(null,'1','12','$id','$md52')";
			$sql7="INSERT INTO customer_entity_varchar(	value_id,entity_type_id,attribute_id,entity_id,value) VALUES(null,'1','3','$id','English')";


			$sql8="INSERT INTO customer_entity_varchar(	value_id,entity_type_id,attribute_id,entity_id,value) VALUES(null,'1','210','$id','$country')";
			$sql9="INSERT INTO customer_entity_varchar(	value_id,entity_type_id,attribute_id,entity_id,value) VALUES(null,'1','211','$id','$age')";
			$sql10="INSERT INTO customer_entity_varchar(	value_id,entity_type_id,attribute_id,entity_id,value) VALUES(null,'1','15','$id','$sex')";
			$sql11="INSERT INTO customer_entity_varchar(	value_id,entity_type_id,attribute_id,entity_id,value) VALUES(null,'1','217','$id','$username')";
			$sql12="INSERT INTO customer_address_entity(entity_id,entity_type_id,attribute_set_id,increment_id,parent_id,created_at,updated_at,is_active) VALUES(null,'2','0',null,'$id','$date','$date','1')";
			


			mysql_query($sql4,$con) or die("失敗4" .mysql_error());
			mysql_query($sql5,$con) or die("失敗5" .mysql_error());
			mysql_query($sql6,$con) or die("失敗6" .mysql_error());
			mysql_query($sql7,$con) or die("失敗7" .mysql_error());
			mysql_query($sql8,$con) or die("失敗8" .mysql_error());
			mysql_query($sql9,$con) or die("失敗9" .mysql_error());
			mysql_query($sql10,$con) or die("失敗10" .mysql_error());
			mysql_query($sql11,$con) or die("失敗11" .mysql_error());
			mysql_query($sql12,$con) or die("失敗12" .mysql_error());

		
		
			
		
			

}else {
	
	print json_encode($error);
			

	
}

function FunctionValue($value)
	{
		if($value == "correct")
			return "correct";
		else if($value == "error")
			return "error";
	}
$value=FunctionValue($_SESSION['Register']);

$_SESSION['Register'] = $value;
mysql_close($con); 


/*else {
	$result ="error";
	writefile($result);

	$json2 = [
    		"email-error" => "$emailErr",
    		"age-error" => "$ageErr",
    		"pwd-error" => "$pwdErr",
    		"null-Err" => "$nullErr",
		];
}
*/

/*********************************************************************************************/

?>