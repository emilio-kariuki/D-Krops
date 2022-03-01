<?php
   $host        = "host = localhost";
   $port        = "port = 5432";
   $dbname      = "dbname = Agent";
   $credentials = "user = postgres password=postgres";

//    $db = pg_connect( "$host $port $dbname $credentials"  );
   // if(!$db) {
   //    echo "Error : Unable to open database\n";
   // } else {
   //    echo "Opened database successfully\n";
   // }
//    // $query = "SELECT * FROM upload"; 

// // $rs = pg_query($db, $query) or die("Cannot execute query: $query\n");

// // while ($row = pg_fetch_row($rs)) {
// //   echo "$row[0] $row[1] $row[2]\n";
// // }
// $val = isset($_POST["x_coordinate"]) && isset($_POST["y_coordinate"])
//          && isset($_POST["lat"]) && isset($_POST["long"]) && isset($_POST["type"]);

//          if($val){
//             //checking if there is POST data
     
//             $x_coordinate = $_POST["x_coordinate"]; //grabing the data from headers
//             $y_coordinate = $_POST["y_coordinate"];
//             $lat = $_POST["lat"];
//             $long = $_POST["long"];
//             $type = $_POST["type"];
     
//             //validation name if there is no error before
//             if($return["error"] == false ){
//                 $return["error"] = true;
//                 $return["message"] = "Enter name up to 3 characters.";
//             }
     
//             //add more validations here
     
//             //if there is no any error then ready for database write
//             if($return["error"] == false){
//                  $x_coordinate = mysqli_real_escape_string($link, $x_coordinate);
//                  $y_coordinate = mysqli_real_escape_string($link, $y_coordinate);
//                  $lat = mysqli_real_escape_string($link, $lat);
//                  $long = mysqli_real_escape_string($link, $long);
//                  $type = mysqli_real_escape_string($link, $type);
//                  //escape inverted comma query conflict from string
     
//                  $sql = "INSERT INTO student_list SET
//                                      x_coordinate = '$x_coordinate',
//                                      y_coordinate = '$y_coordinate',
//                                      geom = 'ST_SetSRID(ST_MakePoint($long, $lat), 4326)',
//                                      type = '$type'";
//                  //student_id is with AUTO_INCREMENT, so its value will increase automatically
     
//                  $res = mysqli_query($link, $sql);
//                  if($res){
//                      //write success
//                      echo "Inserted successfully";
//                  }else{
//                      $return["error"] = true;
//                      $return["message"] = "Database error";
//                  }
//             }
//        }else{
//            $return["error"] = true;
//            $return["message"] = 'Send all parameters.';
//        }
     





// // $result = pg_query($db, $sql);
// // if(!$result){
// //   echo pg_last_error($dbconn);
// // } else {
// //   echo "Inserted successfully";
// // }
// // pg_close($db); 

$return["error"] = false;
  $return["message"] = "";

  $link = mysqli_connect("$host $port $dbname $credentials");
  if(!$link) {
   echo "Error : Unable to open database\n";
} else {
   echo "Opened database successfully\n";
}
  //connecting to database server

  $val = isset($_POST["x_coordinate"]) && isset($_POST["y_coordinate"])
         && isset($_POST["lat"]) && isset($_POST["long"]) && isset($_POST["type"]);

  if($val){
       //checking if there is POST data

       $x_coordinate = $_POST["x_coordinate"]; //grabing the data from headers
       $y_coordinate = $_POST["y_coordinate"];
       $lat = $_POST["lat"];
       $long = $_POST["long"];
       $type = $_POST["type"];

       //validation name if there is no error before
       if($return["error"] == false && strlen($name) < 3){
           $return["error"] = true;
           $return["message"] = "Enter name up to 3 characters.";
       }

       //add more validations here

       //if there is no any error then ready for database write
       if($return["error"] == false){
         $x_coordinate = mysqli_real_escape_string($link, $x_coordinate);
         $y_coordinate = mysqli_real_escape_string($link, $y_coordinate);
         $lat = mysqli_real_escape_string($link, $lat);
         $long = mysqli_real_escape_string($link, $long);
         $type = mysqli_real_escape_string($link, $type);
            //escape inverted comma query conflict from string

            $sql = "INSERT INTO student_list SET
                                     x_coordinate = '$x_coordinate',
                                     y_coordinate = '$y_coordinate',
                                     geom = 'ST_SetSRID(ST_MakePoint($long, $lat), 4326)',
                                     type = '$type'";
            //student_id is with AUTO_INCREMENT, so its value will increase automatically

            $res = mysqli_query($link, $sql);
            if($res){
                //write success
            }else{
                $return["error"] = true;
                $return["message"] = "Database error";
            }
       }
  }else{
      $return["error"] = true;
      $return["message"] = 'Send all parameters.';
  }

  mysqli_close($link); //close mysqli

  header('Content-Type: application/json');
  // tell browser that its a json data
  echo json_encode($return);
  //converting array to JSON string
?>