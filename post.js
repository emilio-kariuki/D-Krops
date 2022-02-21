const express = require('pg');
const app = express();

const client = new Client({
    host: "localhost",
    password: "postgress",
    database:"Space",
    username:"postgres",
})