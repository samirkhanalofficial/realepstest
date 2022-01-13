<?php
header('Access-Control-Allow-Origin: *');
include("../includes/conn.php");
if(isset($_GET['quiz_id'])){
    $id=mysqli_real_escape_string($con,$_GET['quiz_id']);
}else{
    echo "Error ";
    return;
}
?>
[
    <?php
       $i=0;
       $sql=$con->query("select * from questions where set_id=$id");
       $count=mysqli_num_rows($sql);
       if($count>0){
           while($row=mysqli_fetch_object($sql)){
               ?>
{
        "id": "<?php echo $row->id; ?>",
        "type": "<?php echo htmlentities($row->type); ?>",
        "title": "<?php echo htmlentities($row->question); ?>",
        "audio": "https://samirk.com.np/realepstest/<?php echo htmlentities($row->audio); ?>",
        "picture": "https://samirk.com.np/realepstest/<?php echo htmlentities($row->image); ?>",
        "quiz_id": "<?php echo $row->set_id; ?>",
        "option1": "<?php echo htmlentities($row->option1); ?>",
        "option2": "<?php echo htmlentities($row->option2); ?>",
        "option3": "<?php echo htmlentities($row->option3); ?>",
        "option4": "<?php echo htmlentities($row->option4); ?>",
        "correct_option": "option<?php echo $row->correct_option; ?>",
        "feedback": "<?php echo htmlentities($row->title); ?>"
    }


<?php

          $i++;
          if($i!=$count){
              echo ",";
          }
        }}
           ?>
]


