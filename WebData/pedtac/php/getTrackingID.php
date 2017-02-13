<?php
include("connec.php");
$TrackingID="";
$sql='SELECT TrackingID FROM AccelerationData WHERE YEAR(PhoneDataTime)=YEAR(CURRENT_TIMESTAMP) AND MONTH(PhoneDataTime)=MONTH(CURRENT_TIMESTAMP) AND DAYOFMONTH(PhoneDataTime)=DAYOFMONTH(CURRENT_TIMESTAMP) ORDER BY `PhoneDataTime` DESC LIMIT 1';
$result=$con->query($sql);
if($result->num_rows > 0){
    $prerow="";
    $predate="";
    $preindex=0;
    while($row = $result->fetch_assoc()){
        $prerow=$row["TrackingID"];
    }
    $predate=substr($prerow,0,8);
    $preindex=intval(substr($prerow,8));
    $preindex++;
    $TrackingID=$predate.$preindex;
}else{
    $sql2='SELECT YEAR(CURRENT_TIMESTAMP) "YEAR",MONTH(CURRENT_TIMESTAMP) "MONTH",DAYOFMONTH(CURRENT_TIMESTAMP) "DAYOFMONTH"';
    $result2=$con->query($sql2);
    while($row = $result2->fetch_assoc()){
        $YEAR="";
        $MONTH="";
        $DAY="";
        $YEAR=$row["YEAR"];
        if($row["MONTH"]<10){
            $MONTH="0".strval($row["MONTH"]);
        }else{
            $MONTH=strval($row["MONTH"]);
        }
        if($row["DAYOFMONTH"]<10){
            $DAY="0".strval($row["DAYOFMONTH"]);
        }else{
            $DAY=strval($row["DAYOFMONTH"]);
        }
        $TrackingID=$YEAR.$MONTH.$row["DAYOFMONTH"]."1";
    }
}
echo $TrackingID;
?>