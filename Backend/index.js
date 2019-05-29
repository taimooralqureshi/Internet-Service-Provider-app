const express = require('express');
const cors = require('cors');
const mysql = require('mysql');

const SERVICE_QUERY = "SELECT * FROM service";
const DEVICE_QUERY = "SELECT * FROM device";



const app = express();
const connection = mysql.createConnection({
    host : 'localhost',
    user : 'root',
    password : 'taimoor',
    database : 'isp_db'

});

connection.connect(function(err) {
    if (err) throw err;
    console.log("Database Connected!");
  });


app.use(cors());

app.get('/', (req,res) => {
    res.send("hello world, its express server")
});


app.get('/services', (req,res) => {
    connection.query(SERVICE_QUERY, (err, result) => {
        if (err) throw err;
        else
          return res.json(result)
    });
});

//  Retrieve user with id 
app.get('/services/:id', function (req, res) {
    let id = req.params.id;
    connection.query(SERVICE_QUERY+'where id=?', id, (err, result) => {
        if (err) throw err;
        else
          return res.json(result)
    });
   
});



app.get('/devices', (req,res) => {
    connection.query(DEVICE_QUERY, (err, result) => {
        if (err) throw err;
        else
          return res.json(result)
    });
});

//  Retrieve user with id 
app.get('/devices/:id', function (req, res) {
    let id = req.params.id;
    connection.query(DEVICE_QUERY+'where id=?', id, (err, result) => {
        if (err) throw err;
        else
          return res.json(result)
    });
   
});






app.get('/customers', (req,res) => {
    connection.query('CALL customers_data()', (err, result) => {
        if (err) throw err;
        else
          return res.json(result[0])
    });
});

app.get('/customers/:id', function (req, res) {
    let id = req.params.id;
        
    connection.query("call customer_data(?)",id, (err, result) => {
        if (err) throw err;
        else
          return res.json(result[0])
    });
   
});




app.listen(4000,()=>{
    console.log("server runing on port 4000");
})
