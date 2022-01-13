<?php
header('Access-Control-Allow-Origin: *');
include("../includes/conn.php");
?>
[
    <?php
       $i=0;
       $sql=$con->query("select * from sets where ispublished='true'");
       $count=mysqli_num_rows($sql);
       if($count>0){
           while($row=mysqli_fetch_object($sql)){
               ?>
{
        "id": "<?php echo $row->id; ?>",
       "title": "<?php echo $row->name; ?>"
    }


<?php

          $i++;
          if($i!=$count){
              echo ",";
          }
        }}
           ?>
]


