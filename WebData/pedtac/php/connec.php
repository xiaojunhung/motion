<?php

//建立連線
$con=new mysqli("localhost","16631101","0813","pedtacdb");
if($con->connect_error){
    die("資料庫連線失敗：".$con->connect_error);
}
mysql_query("SET NAMES UTF8");
header('Access-Control-Allow-Origin: *');
?>