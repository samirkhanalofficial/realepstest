<?php
include("includes/navbar.php");

  if(isset($_POST['id'])){
    $id=mysqli_real_escape_string($con,$_POST['id']);
  }else{
    if(isset($_GET['id'])){
      $id=mysqli_real_escape_string($con,$_GET['id']);
      if($id>0){}
      else{
        return;
      }
      }else{
        return;
      }
  }

?>
<style>
    .sets a{
        color:red!important;
    }
    </style>



<!-- Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
<form action="questions.php" method="post" enctype="multipart/form-data">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Add New Question</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <b>Title:</b>
      <input type="text" style="margin:10px 0px;border-radius:15px;" class="form-control" name="ftitle" placeholder="Title">
      <b>Question Type:</b>
      <select id="type" name="ftype" style="padding-right:20px!important;border-radius:15px;" class="form-control" onchange="changed()">
          <option value="text">text</option>
          <option value="image">image</option>
          <option value="audio">audio</option>
          
      </select>
      <div id="file" style="display:none;">
      <input type="hidden" name="id" value="<?php echo $id; ?>">
      <b  >Audio / Image File:</b>
      <input type="file"  style="margin:10px 0px;border-radius:15px;" class="form-control" name="ffile">
      </div>
      <div id="question">
      <b id="question" >Question:</b>
      <input type="text" id="question" style="margin:10px 0px;border-radius:15px;" class="form-control" name="fquestion" placeholder="Question">
      </div>
      <b>Option 1:</b>
      <input type="text" style="margin:10px 0px;border-radius:15px;" class="form-control" name="fo1" placeholder="Question">
      <b>Option 2:</b>
      <input type="text" style="margin:10px 0px;border-radius:15px;" class="form-control" name="fo2" placeholder="Question">
      <b>Option 3:</b>
      <input type="text" style="margin:10px 0px;border-radius:15px;" class="form-control" name="fo3" placeholder="Question">
      <b>Option 4:</b>
      <input type="text" style="margin:10px 0px;border-radius:15px;" class="form-control" name="fo4" placeholder="Question">
      <b>Correct Option:</b>
      <select name="fcorrectoption" style="margin:10px 0px;border-radius:15px;" class="form-control" >
          <option value="1">option 1</option>
          <option value="2">option 2</option>
          <option value="3">option 3</option>
          <option value="4">option 4</option>
      </select>
      
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" style="border-radius:15px;" data-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-primary" style="border-radius:15px;">Add Question</button>
      </div>
      </form>
    </div>
  </div>
</div>
      

      </div>
<div class="container">

<?php
$error="";

if(isset($_POST['ftitle'])){
  $setid=mysqli_real_escape_string($con,$_POST['id']);
$title=mysqli_real_escape_string($con,$_POST['ftitle']);
$type=mysqli_real_escape_string($con,$_POST['ftype']);
if($type=="audio" || $type=="image"){
$question="";
if(
move_uploaded_file($_FILES['ffile']['tmp_name'],"uploads/".basename($_FILES['ffile']['name']))){
if($type=="image"){
  $image=$_FILES['ffile']['name'];
  $audio="";
}else{
  $audio=$_FILES['ffile']['name'];
  $image="";
}
}else{
  $error="file not uploaded";
}
}else{
  $question=mysqli_real_escape_string($con,$_POST['fquestion']);
  $image="";
  $audio="";
}
$op1=mysqli_real_escape_string($con,$_POST['fo1']);
$op2=mysqli_real_escape_string($con,$_POST['fo2']);
$op3=mysqli_real_escape_string($con,$_POST['fo3']);
$op4=mysqli_real_escape_string($con,$_POST['fo4']);
$correct=mysqli_real_escape_string($con,$_POST['fcorrectoption']);
if($error==""){
  if(
  $con->query("INSERT INTO `questions`( `question`, `type`, `audio`, `image`, `title`, `option1`, `option2`, `option3`, `option4`, `correct_option`, `set_id`) VALUES ('$question','$type','uploads/$audio','uploads/$image','$title','$op1','$op2','$op3','$op4','$correct','$setid')")){
    echo "<script>alert(`Congrat! Question Inserted Successfully.`);</script>";
    header("location:questions.php?id=$setid");
  }else{
    $error="Error inserting data.";
  }
}
}


echo "<b color='red'> $error </b>";

?>
        <button style="margin:20px;float:right;"  class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter"> <i  class="fa fa-plus"></i> Add Question</button>
        <div class="clear"></div>
        <br>
    
        <?php
       $yyy=0;
        $sql=$con->query("select * from questions where set_id=$id");
        if(mysqli_num_rows($sql)>0){
            while($row=mysqli_fetch_object($sql)){
                $yyy++;
            ?>
            <div class="card" style="padding:50px 10px;border-radius:15px;margin-bottom:15px;">

<span>
    <div style="float:left;padding:0px 10px;"><i style="font-size:30px;color:green;" class="fa fa-book" ></i></div>
            <div style="float:right;padding:10px 10px;">
            <a href="deletequestion.php?id=<?php echo $row->id; ?>&redirectid=<?php echo $id; ?>" class="btn btn-danger">
            <i  class="fa fa-trash"></i> Delete
            </a>
            
            
        </div>
        
        <b>   
              
        <?php
            echo $yyy.") ".$row->title."<br>";
            if($row->type=="text"){
              echo "<i style='color:red;'>".$row->question."</i>";
            }
            if($row->type=="audio"){
              echo "<audio src='".$row->audio."' controls></audio>";
            }
            if($row->type=="image"){
              echo "<img src='".$row->image."' width='200px'>";
            }

        ?>

        </b>
        <div>
          <br>
          <br>
        <ul>
          <li>
          <?php
          if($row->correct_option=="1"){
              echo "<span style='color:green'>";
          }else{
              echo "<span>";
          }
            echo $row->option1;
            echo "</span>";
        ?>
          </li>
          <li>
          <?php
          if($row->correct_option=="2"){
              echo "<span style='color:green'>";
          }else{
              echo "<span>";
          }
            echo $row->option2;
            echo "</span>";
        ?>
          </li>
          <li>
          <?php
          if($row->correct_option=="3"){
              echo "<span style='color:green'>";
          }else{
              echo "<span>";
          }
            echo $row->option3;
            echo "</span>";
        ?>
          </li>
          <li>
          <?php
          if($row->correct_option=="4"){
              echo "<span style='color:green'>";
          }else{
              echo "<span>";
          }
            echo $row->option4;
            echo "</span>";
        ?>
          </li>
        </ul>
        </div>
        </span>
          
        
        </span>
        </div>
           <?php
            }
        }else{
            ?>

            <div class="card" style="padding:50px;border-radius:15px;">
            <center><i  class="fa fa-exclamation-circle" style="font-size:30px;color:red;"></i> <br>
                <h2> No Questions Found</h2></center>
            </div>
        
        
        
            <?php
        }
?>


</div>
<script>
    function changed(){
        var typee=document.getElementById("type").value;
        if(typee=="text"){
            $("#question").css("display","block");
            $("#file").css("display","none");
        }else{
            $("#question").css("display","none");
            $("#file").css("display","block");
        }
    }
</script>
<?php
include("includes/footer.php");

?>