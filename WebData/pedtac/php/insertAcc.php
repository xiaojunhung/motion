<?php
include("connec.php");
$jsonString = file_get_contents('php://input');
$jsonArray = json_decode($jsonString, true);
$_phoneID=$jsonArray["myID"];
$_TrackingID=$jsonArray["TrackingID"];
$count=0;
$_data=array();
array_push($_data,$jsonArray["1"],$jsonArray["2"],$jsonArray["3"],$jsonArray["4"],$jsonArray["5"],$jsonArray["6"],$jsonArray["7"],$jsonArray["8"],$jsonArray["9"],$jsonArray["10"]);
for($x=0;$x<count($_data);$x++){
    if($_data[$x]["Y"] != "" or $_data[$x]["Y"] != null){
        $sql=sprintf("INSERT INTO AccelerationData (AccX,AccY,AccZ,MagX,MagY,MagZ,PhoneDataTime,PhoneID,TrackingID) VALUES(%f,%f,%f,%f,%f,%f,'%s','%s','%s')",mysql_real_escape_string($_data[$x]["X"]),mysql_real_escape_string($_data[$x]["Y"]),mysql_real_escape_string($_data[$x]["Z"]),mysql_real_escape_string($_data[$x]["MagX"]),mysql_real_escape_string($_data[$x]["MagY"]),mysql_real_escape_string($_data[$x]["MagZ"]),mysql_real_escape_string($_data[$x]["CurrentTime"]),mysql_real_escape_string($_phoneID),mysql_real_escape_string($_TrackingID));
    $result=$con->query($sql);
    $count+=$result;
    }
}
echo $count;
?>