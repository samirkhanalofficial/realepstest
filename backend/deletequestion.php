<?php
include("includes/checklogin.php");
$rid=0;
if(isset($_GET['id']) && isset($_GET['redirectid']) ){
    $rid=$_GET['redirectid'];
    $id=mysqli_real_escape_string($con,$_GET['id']);
    if($id>0){
        $con->query("DELETE FROM questions where id=$id");
    }
       
    
}
header("location:questions.php?id=$rid");
?>