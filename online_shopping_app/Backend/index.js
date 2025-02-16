const express = require("express");
const mysql = require("mysql2");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json());

app.listen(5001, ()=>{
    console.log("Server is running on port 5001");
});

const db = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "1234",
    database: "red_dress_db",
});

db.connect((err)=>{
    if(err) {
        console.log(err);
    }else{
        console.log("Connected to database");
    }
});


// POST API to register new user

app.post("/api/add_user", (req, res)=>{

    console.log(req.body);
    const {name , email , password} = req.body;

    const sql = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";

    db.query(sql, [name, email, password], (err, result) => {
        if(err){
            return res.statusCode(500).send(err);
        }

        res.status(200).json({
            message : "User added successfully",
        })
    })
});


// Login API

app.post("/api/login", (req, res) => {
    const { email, password } = req.body;
  
    if (!email || !password) {
      return res.status(400).json({ message: "Email and password are required" });
    }
  
    const sql = "SELECT * FROM users WHERE email = ? AND password = ?";
    
    db.query(sql, [email, password], (err, result) => {
      if (err) {
        return res.status(500).json({ message: "Database error", error: err });
      }
  
      if (result.length > 0) {
        // User found
        res.status(200).json({ message: "Login successful", user: result[0] });
      } else {
        // User not found
        res.status(401).json({ message: "Invalid email or password" });
      }
    });
  });