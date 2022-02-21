const express = require('express');
const app = express();
app.use(express.json({extended: false}));
const port = 5000;
const hostname = "127.0.0.1";
const client = require('./post');

app.post('/',(req,res) =>{
    try{
        const {type,x_coordinate,y_coordinate} = req.body;
        const dbt = client.query("INSERT INTO emilio(first_name,second_name)VALUES($1,$2)",[first_name,second_name]);
        res.json(dbt);

    }catch(err){
        console.log(err.message)
    }
});
