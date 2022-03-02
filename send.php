
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
    
    $current_date=date("Y/m/d");

    $image=$_POST['image'];
    $description=$_POST['description'];
    $incident_type=$_POST['incident_type'];
    $latitude=$_POST['latitude'];
    $longitude=$_POST['longitude'];
    $my_id=rand(100,1000);
    
    $image_name = uniqid();
    
   
    $upload_path="images/$image_name.jpg";

   if($upload_path){

        file_put_contents($upload_path,base64_decode($image));

  $sql_details="INSERT INTO upload (x_coordinate,y_coordinate,latitude,longitude,image_name,type) VALUES (x_coordinate,y_coordinate,'$description','$incident_type','$latitude','$longitude','$image_name','$current_date','Pending')";
  $result= pg_query($db,$sql_details);
// $q=($db,"INSERT INTO sent_information(id, user_id, description, incident_type, latitude, longitude, image_name, date_sent, status)VALUES ('0', '0', 'df', 'jh', 'hg', 'jf', 'gfd', 'fds', 'erd')"); 
 // $result=pg_query($q);

        echo json_encode(array('response'=>'Information Sent Successfully'));
    }else{

        echo json_encode(array('response'=>'Information NOT Sent'));
    }

?>
