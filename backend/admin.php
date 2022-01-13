<?php
include("includes/navbar.php");

?>
<style>
    .admin a{
        color:red!important;
    }
    </style>



<!-- Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
<form action="admin.php" method="post">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Add New Admin</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <b>Full Name:</b>
      <input type="text" style="margin:10px 0px;border-radius:15px;" class="form-control" name="aname" placeholder="Full Name">
      <b>Email:</b>  
      <input type="text" style="margin:10px 0px;border-radius:15px;" class="form-control" name="aemail" placeholder="email">
      <b>Password:</b>
      <input type="password" style="margin:10px 0px;border-radius:15px;" class="form-control" name="apassword" placeholder="Password">
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" style="border-radius:15px;" data-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-primary" style="border-radius:15px;">Add as Admin</button>
      </div>
      </form>
    </div>
  </div>
</div>
    <div class="container">
        <button style="margin:20px;float:right;"  class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter"> <i  class="fa fa-plus"></i> Add New Admin</button>
        <div class="clear"></div>
        <br>
        
<?php

if(isset($_POST['aemail']) &&isset($_POST['aname']) && isset($_POST['apassword'])){
    $aemail=mysqli_real_escape_string($con,$_POST['aemail']);
    $aname=mysqli_real_escape_string($con,$_POST['aname']);
    $apassword=md5(mysqli_real_escape_string($con,$_POST['apassword']));
    $sql=$con->query("Select * from admin where email='$aemail'");
    if(mysqli_num_rows($sql)==1){
        echo "<b style='color:red;'> Email Already Exists </b>";
    }else{
        $sqll=$con->query("INSERT INTO `admin` (`email`, `password`, `name`) VALUES ('$aemail','$apassword','$aname')");
        if($sqll){
            echo "<b style='color:green;'> Admin Added Successfully.</b>"; 
        }else{
            echo "<b style='color:red;'> Error Occurred. </b>";
        }
    }
}


$sql=$con->query("select * from admin");
if(mysqli_num_rows($sql)>0){
while($row=mysqli_fetch_object($sql)){
    ?>
    
<div class="card" style="padding:50px 10px;border-radius:15px;margin-bottom:15px;">

<span>
    <div style="float:left;padding:0px 10px;"><i style="font-size:50px;color:green;" class="fa fa-user" ></i></div>
    <?php 
    if($row->email!=$_SESSION['email']){
        ?>
    <div style="float:right;padding:10px 10px;">
    <a href="removeadmin.php?id=<?php echo $row->id; ?>" class="btn btn-danger">
    <i  class="fa fa-trash"></i> Remove
    </a>
</div>
<?php
    }
    ?>
  <b>  
<?php
    echo $row->name;
?>
</b>
<br>
<?php
    echo $row->email;
?>

</span>
</div>
    <?php
}
}else{
    ?>

    <div class="card" style="padding:50px;border-radius:15px;">
    <center><i  class="fa fa-exclamation-circle" style="font-size:30px;color:red;"></i> </center>
        <h2> No Admins Found</h2>
    </div>



    <?php
}

?>
</div>

<?php
include("includes/footer.php");

?>