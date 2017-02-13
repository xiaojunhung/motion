<?php
include("connec.php");
$jsonString = file_get_contents('php://input');
$jsonArray = json_decode($jsonString, true);
$Magx=$jsonArray["Magx"];
$Magy=$jsonArray["Magy"];
$Magz=$jsonArray["Magz"];
$X=$jsonArray["X"];
$Y=$jsonArray["Y"];
$sql=sprintf("INSERT INTO MagneticData (AxisX,AxisY,MagX,MagY,MagZ) VALUES(%f,%f,%f,%f,%f)",mysql_real_escape_string($Magx),mysql_real_escape_string($Magy),mysql_real_escape_string($Magz),mysql_real_escape_string($X),mysql_real_escape_string($Y));
$result=$con->query($sql);
echo $result;
?>