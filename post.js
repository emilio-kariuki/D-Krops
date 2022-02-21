const { Client } = require('pg');


const client = new Client({
    host: "localhost",
    password: "postgres",
    port: 5432,
    database:"Space",
    user:"postgres"
});

client.on('connect', ()=>{
    console.log("Connection started")
});
client.on('end',()=>{
    console.log("Connected finished")
});

module.exports = client;