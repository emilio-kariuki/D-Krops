const express = require('express');
const app = express();
app.use(express.json({extended: false}));
const port = 5000;
const hostname = "127.0.0.1";
const client = require('./post');

app.post('/',(req,res) =>{
    try{
        const {type,x_coordinate,y_coordinate} = req.body;
        const dbt = client.query("INSERT INTO space(type,x_coordinate,y_coordinate,geom)VALUES($1,$2,$3,$4)",
        [type,x_coordinate,y_coordinate,ST_GeomFromText('POINT(-73.985744 40.748549)',4269)]);
        res.json(dbt);

    }catch(err){
        console.log(err.message)
    }
});

app.listen(port,hostname, ()=>{
    console.log('Server Running....')
});
