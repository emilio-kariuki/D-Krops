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
   if(isset($_POST["x_coordinate"]) && isset($_POST["y_coordinate"]) && isset($_POST["lat"]) && isset($_POST["long"]) && isset($_POST["type"]))
   {	 
      echo "opening";
       $x_coordinate = $_POST['x_coordinate'];
       $y_coordinate = $_POST['y_coordinate'];
       $lat = $_POST['lat'];
       $long = $_POST['long'];
       $type = $_POST['type'];
       $sql = "insert into upload (x_coordinate, y_coordinate,geom,type)  values($x_coordinate, $y_coordinate, ST_SetSRID(ST_MakePoint($long, $lat), 4326),'$type')";
      //  values ('$first_name','$last_name','$city_name','$email')";
       $result = pg_query($db, $sql);
       if($result = pg_query($query)){
         echo "Data Added Successfully.";
       }
       else{
         echo "Error.";
       }
   }


// $sql = "insert into upload (x_coordinate, y_coordinate,geom,type)  values(-122.222657, 0.2323223, ST_SetSRID(ST_MakePoint(-122.222657, 0.2323223), 4326),'maize')";
// $result = pg_query($db, $sql);
// if(!$result){
//   echo pg_last_error($dbconn);
// } else {
//   echo "Inserted successfully";
// }
pg_close($db); 

?>