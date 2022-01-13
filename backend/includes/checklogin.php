<?php
session_start();
    include("conn.php");
                            
    if(isset($_SESSION['email']) && isset($_SESSION['password'])){
        $email=mysqli_real_escape_string($con,$_SESSION['email']);
        $password=mysqli_real_escape_string($con,$_SESSION['password']);
        $sql=$con->query("Select * from admin where email='$email' and password='$password'");
        if(mysqli_num_rows($sql)!=1){
            session_destroy();
            header("location:index.php");
            return;
        }
        
        
    }else{
        
        header("location:index.php");
        return;
    }
    ?>