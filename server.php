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
   
      echo "opening";
               // require 'init.php';
          
         //  $current_date=date("Y/m/d");
      
          $image=$_POST['image'];
          $x_coordinate=$_POST['x_coordinate'];
          $y_coordinate=$_POST['y_coordinate'];
          $latitude=$_POST['latitude'];
          $longitude=$_POST['longitude'];
          $type=$_POST['type'];
          
          $image_name = uniqid();
          
         
          $upload_path="images/$image_name.jpg";
      
         if($upload_path){
      
            //   file_put_contents($upload_path,base64_decode($image));
      
      //   $sql_details="INSERT INTO upload (x_coordinate,y_coordinate,geom,type) VALUES ($x_coordinate,$y_coordinate,ST_SetSRID(ST_MakePoint($longitude, $latitude), 4326),$type)";
      
       
             $sql = "insert into upload (x_coordinate, y_coordinate,geom,picture,type)  values($x_coordinate, $y_coordinate, ST_SetSRID(ST_MakePoint($longitude, $latitude), 4326),'$upload_path','$type')";
        $result= pg_query($db,$sql);
      // $q=($db,"INSERT INTO sent_information(id, user_id, description, incident_type, latitude, longitude, image_name, date_sent, status)VALUES ('0', '0', 'df', 'jh', 'hg', 'jf', 'gfd', 'fds', 'erd')"); 
       // $result=pg_query($q);
      
              echo json_encode(array('response'=>'Information Sent Successfully'));
          }else{
      
              echo json_encode(array('response'=>'Information NOT Sent'));
          }
// pg_close($db); 

?>