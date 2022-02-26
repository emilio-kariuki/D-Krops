const express = require('express');
const app = express();
app.use(express.json({extended: false}));
const port = 5000;
const hostname = "127.0.0.1";
const client = require('./post');

app.post('/',(req,res) =>{
    try{
        const {type,x_coordinate,y_coordinate,lat,long} = req.body;
        const dbt = client.query("INSERT INTO upload(x_coordinate,y_coordinate,picture,geom,type)VALUES($1,$2,$3,$4)",
        [x_coordinate,y_coordinate,ST_SetSRID(ST_MakePoint(long, lat), 4326),type ]);
        res.json(dbt);

    }catch(err){
        console.log(err.message)
    }
});

app.listen(port,hostname, ()=>{
    console.log('Server Running....')
});
