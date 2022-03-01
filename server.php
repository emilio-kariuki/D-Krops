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
   // $query = "SELECT * FROM upload"; 

// $rs = pg_query($db, $query) or die("Cannot execute query: $query\n");

// while ($row = pg_fetch_row($rs)) {
//   echo "$row[0] $row[1] $row[2]\n";
// }
$sql = "insert into upload (x_coordinate, x_coordinate, type)  values(-122.222657, 0.2323223, ST_SetSRID(ST_MakePoint(-122.222657, 0.2323223), 4326),'maize')";

pg_close($db); 
?>