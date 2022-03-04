
<?php
    $host        = "host = iggresserver.dkut.ac.ke ";
    $port        = "port = 5432";
    $dbname      = "dbname = crop_mapping";
    $user = "user = postgres password=.Xy!@D3K_3ev3R.2!jL!";
    

    $db = pg_connect( "$host $port $dbname $user "  );
    if(!$db) {
    echo "Error : Unable to open database\n";
    } else {
    echo "Opened database successfully\n";
    }

    echo "opening";

    

    $name='Emilio';
    

  $sql="INSERT INTO table(name) VALUES ($name)";
  $result= pg_query($db,$sql);
// $q=($db,"INSERT INTO sent_information(id, user_id, description, incident_type, latitude, longitude, image_name, date_sent, status)VALUES ('0', '0', 'df', 'jh', 'hg', 'jf', 'gfd', 'fds', 'erd')"); 
 // $result=pg_query($q);
?>
