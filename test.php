
<?php
    $host        = "host = iggresserver.dkut.ac.ke ";
    $port        = "port = 5432";
    $dbname      = "dbname = crop_mapping";
    $user = "user = postgres";
    $password= "password=.Xy!@D3K_3ev3R.2!jL!";
    
    $dsn = "pgsql:host=$host;port=$port;dbname=$dbname;user=$user;password=$password";
  
    $db = new PDO($dsn);
    if(!$db) {
    echo "Error : Unable to open database\n";
    } else {
    echo "Opened database successfully\n";
    }

    $image=$_POST['image'];
    $x_coordinate=$_POST['x_coordinate'];
    $y_coordinate=$_POST['y_coordinate'];
    $latitude=$_POST['latitude'];
    $longitude=$_POST['longitude'];
    $type=$_POST['type'];
    
    $image_name = uniqid();
    
   
    $upload_path="images/$image_name.jpg";

   if($upload_path){

        file_put_contents($upload_path,base64_decode($image));

  $sql_details="INSERT INTO crop_mapping (x_coordinate,y_coordinate,geom,picture,type) VALUES ('$x_coordinate',0,'$y_coordinate',ST_SetSRID(ST_MakePoint('$longitude', '$latitude'), 4326),'$type')";
  $result= pg_query($db,$sql_details);
// $q=($db,"INSERT INTO sent_information(id, user_id, description, incident_type, latitude, longitude, image_name, date_sent, status)VALUES ('0', '0', 'df', 'jh', 'hg', 'jf', 'gfd', 'fds', 'erd')"); 
 // $result=pg_query($q);

        echo json_encode(array('response'=>'Information Sent Successfully'));
    }else{

        echo json_encode(array('response'=>'Information NOT Sent'));
    }

?>
