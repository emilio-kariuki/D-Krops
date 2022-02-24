const { Client } = require('pg');


const client = new Client({
    host: "ec2-54-209-221-231.compute-1.amazonaws.com",
    port: 5432,
    user: "cxojqgbeleyzoq",
    password: "3244e4641c78e858ffce9cfa521c526095b97a8ea295f75650033f028656efab",
    database: "d75sjlpi046aae",
});

client.on('connect', ()=>{
    console.log("Connection started")
});
client.on('end',()=>{
    console.log("Connected finished")
});
client.connect();

module.exports = client;