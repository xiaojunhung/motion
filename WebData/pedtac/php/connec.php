<?php
$servername="localhost";
$username="16631101";
$password="0813";
$database="pedtacdb";

//建立連線
$con=new mysqli($server,$username,$password,$database);
if($con->connect_error){
    die("資料庫連線失敗：".$con->connect_error);
}
mysql_query("SET NAMES UTF8");
header('Access-Control-Allow-Origin: *');
?>