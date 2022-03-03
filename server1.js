const express = require('express');
const bytea = require('postgres-bytea');
const app = express();
app.use(express.json({extended: false}));
const port = 5432;
const hostname = "http://iggresserver.dkut.ac.ke";
const client = require('./post');

app.post('/',(req,res) =>{
    try{
        const {x_coordinate,y_coordinate,lat,long,type} = req.body;
        const dbt = client.query("INSERT INTO crop_mapping(x_coordinate,y_coordinate,geom,type)VALUES($1,$2, ST_SetSRID(ST_MakePoint($3, $4), 4326),$5)",
        [x_coordinate,y_coordinate,lat,long,type]);
        res.json(dbt);

    }catch(err){
        console.log(err.message)
    }
});

app.listen(port,hostname, ()=>{
    console.log('Server Running....')
}); 
