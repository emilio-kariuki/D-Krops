
<?php

$host        = "host = localhost";
$port        = "port = 5432";
$dbname      = "dbname = Agent";
$credentials = "user = postgres password=postgres";

$db = pg_connect( "$host $port $dbname $credentials"  );
if(!$db) {
   echo "Error : Unable to open database\n";
} else {
   echo "Opened database successfully\n";
}

    // require 'init.php';
    
//     $current_date=date("Y/m/d");

//     $image=$_POST['image'];
    $x_coordinate=36.38757163764297;
    $y_coordinate=0.12213698040289252;
    $latitude=36.38757163764297;
    $longitude=0.12213698040289252;
    $type='spinach';
    
//     $image_name = uniqid();
    
   
//     $upload_path="images/$image_name.jpg";

//    if($upload_path){

//         file_put_contents($upload_path,base64_decode($image));

// //   $sql_details="INSERT INTO upload (x_coordinate,y_coordinate,geom,type) VALUES ($x_coordinate,$y_coordinate,ST_SetSRID(ST_MakePoint($longitude, $latitude), 4326),$type)";

 
//        $sql = "SELECT * FROM upload";
//   $result= pg_query($db,$sql);
  $result = pg_query($db, "insert into upload (x_coordinate, y_coordinate,geom,type)  values($x_coordinate, $y_coordinate, ST_SetSRID(ST_MakePoint($longitude, $latitude), 4326),'$type')");
  if (!$result) {
      echo "An error occurred.\n";
      exit;
  }
  
  $arr = pg_fetch_all($result);
  
  print_r($arr);
// $q=($db,"INSERT INTO sent_information(id, user_id, description, incident_type, latitude, longitude, image_name, date_sent, status)VALUES ('0', '0', 'df', 'jh', 'hg', 'jf', 'gfd', 'fds', 'erd')"); 
 // $result=pg_query($q);

    //     echo json_encode(array('response'=>'Information Sent Successfully'));
    // }else{

    //     echo json_encode(array('response'=>'Information NOT Sent'));
    // }

?>
