const { Client } = require('pg');


const client = new Client({
    host: "localhost",
    port: 5432,
    user: "postgres",
    password: "postgres",
    database: "Space",
});

client.on('connect', ()=>{
    console.log("Connection started")
});
client.on('end',()=>{
    console.log("Connected finished")
});
client.connect();

module.exports = client;