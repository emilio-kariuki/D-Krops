const { Client } = require('pg');


const client = new Client({
    host: "http://iggresserver.dkut.ac.ke",
    port: 5432,
    user: "postgres",
    password: ".Xy!@D3K_3ev3R.2!jL!",
    database: "crop_mapping",
});

client.on('connect', ()=>{
    console.log("Connection started")
});
client.on('end',()=>{
    console.log("Connected finished")
});
client.connect();

module.exports = client;