<?php
include("includes/checklogin.php");
if(isset($_GET['id'])){
    $id=mysqli_real_escape_string($con,$_GET['id']);
    if($id>0){
        $con->query("DELETE FROM admin where id=$id");
    }
       
    
}
header("location:admin.php");
?>