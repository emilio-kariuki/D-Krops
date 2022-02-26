const express = require('express');
const app = express();
app.use(express.json({extended: false}));
const port = 5000;
const hostname = "127.0.0.1";
const client = require('./post');

app.post('/',(req,res) =>{
    try{
        const {x_coordinate,y_coordinate} = req.body;
        const dbt = client.query("INSERT INTO trer(x,y)VALUES($1,$2)",
        [x_coordinate,y_coordinate]);
        res.json(dbt);

    }catch(err){
        console.log(err.message)
    }
});

app.listen(port,hostname, ()=>{
    console.log('Server Running....')
});
