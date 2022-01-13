<?php
include("includes/checklogin.php");

if(isset($_GET['id'])){
    $rid=$_GET['redirectid'];
    $id=mysqli_real_escape_string($con,$_GET['id']);
    if($id>0){
        $con->query("UPDATE sets SET ispublished='true' where id=$id");
    }
       
    
}
header("location:sets.php");
?>