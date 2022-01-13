<?php
include("includes/navbar.php");

?>
<style>
    .sets a{
        color:red!important;
    }
    </style>



<!-- Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
<form action="sets.php" method="post">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Add New Admin</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <b>Set Name:</b>
      <input type="text" style="margin:10px 0px;border-radius:15px;" class="form-control" name="sname" placeholder="Set Name">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" style="border-radius:15px;" data-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-primary" style="border-radius:15px;">Add</button>
      </div>
      </form>
    </div>
  </div>
</div>
    <div class="container">
    <?php
if(isset($_POST['sname'])){
    $title=mysqli_real_escape_string($con,$_POST['sname']);
    if($con->query("INSERT INTO `sets` (`name`) VALUES ('$title')")){
        echo "<b style='color:green;'> Set Added Successfully! </b>";

    }else{
        echo "<b style='color:red;'> Something went wrong! </b>";
    }
}
    ?>
        <button style="margin:20px;float:right;"  class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter"> <i  class="fa fa-plus"></i> Add New Set</button>
        <div class="clear"></div>
        <br>

        <?php
        $sql=$con->query("select * from sets");
        if(mysqli_num_rows($sql)>0){
            while($row=mysqli_fetch_object($sql)){
            ?>
            <div class="card" style="padding:50px 10px;border-radius:15px;margin-bottom:15px;">

<span>

<?php 
if($row->ispublished=="true"){
?>
            <div style="float:right;padding:10px 10px;">
            <a href="unpublish.php?id=<?php echo $row->id; ?>" class="btn btn-danger">
            <i  class="fa fa-trash"></i> UnPublish
            </a>
            
            
        </div>

<?php

}else{
?>
         <div style="float:right;padding:10px 10px;">
            <a href="publish.php?id=<?php echo $row->id; ?>" class="btn btn-success">
            <i  class="fa fa-trash"></i> Publish
            </a>
            
            
        </div>

<?php
}
?>

    <div style="float:left;padding:0px 10px;"><i style="font-size:30px;color:green;" class="fa fa-book" ></i></div>
            <div style="float:right;padding:10px 10px;">
            <a href="removeset.php?id=<?php echo $row->id; ?>" class="btn btn-danger">
            <i  class="fa fa-trash"></i> Delete
            </a>
            
            
        </div>
        <div style="float:right;padding:10px 10px;">
            <a href="questions.php?id=<?php echo $row->id; ?>" class="btn btn-info">
            <i  class="fa fa-edit"></i> Edit
            </a>
            
            
        </div>
        <b>  
              
        <?php
            echo $row->name;
        ?>
        </b>
        </span>
          
        
        </span>
        </div>
           <?php
            }
        }else{
            ?>

            <div class="card" style="padding:50px;border-radius:15px;">
            <center><i  class="fa fa-exclamation-circle" style="font-size:30px;color:red;"></i> </center>
                <h2> No Sets Found</h2>
            </div>
        
        
        
            <?php
        }
?>

</div>

<?php
include("includes/footer.php");

?>