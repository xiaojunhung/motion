<?php
$_phoneID=$_POST["myID"];
$_data=array();
array_push($_data,$_POST["1"],$_POST["2"],$_POST["3"],$_POST["4"],$_POST["5"],$_POST["6"],$_POST["7"],$_POST["8"],$_POST["9"],$_POST["10"]);
for($x=0;$x<10;$x++){
    echo $_data[$x]["X"]."<br>";
}
?>