const express = require('express');
var format = require('pg-format');
const app = express();
app.use(express.json({extended: false}));
const port = 5000;
const hostname = "127.0.0.1";
const client = require('./post');

app.post('/',(req,res) =>{
    try{
        const {x_coordinate,y_coordinate,lat,long} = req.body;
        const dbt = client.query("INSERT INTO upload(x_coordinate,y_coordinate,geom)VALUES($1,$2,$3,$4)",
        [x_coordinate,y_coordinate,format('ST_SetSRID(ST_MakePoint($${lat}, $long), 4326)')]);
        res.json(dbt);

    }catch(err){
        console.log(err.message)
    }
});

app.listen(port,hostname, ()=>{
    console.log('Server Running....')
});
