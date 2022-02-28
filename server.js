const express = require('express');
const bytea = require('postgres-bytea');
const app = express();
app.use(express.json({extended: false}));
const port = 5000;
const hostname = "127.0.0.1";
const client = require('./post');

app.post('/',(req,res) =>{
    try{
        const {x_coordinate,y_coordinate,pic_path,lat,long,type} = req.body;
        const dbt = client.query("INSERT INTO trer(x_coordinate,y_coordinate,geom,picture,type)VALUES($1,$2,$3,$4,$5)",
        [x_coordinate,y_coordinate,'bytea(pic_path)','type,geometry::point(lat,long)']);
        res.json(dbt);

    }catch(err){
        console.log(err.message)
    }
});

app.listen(port,hostname, ()=>{
    console.log('Server Running....')
}); 
