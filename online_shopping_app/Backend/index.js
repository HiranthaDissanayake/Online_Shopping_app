const express = require("express");
const mysql = require("mysql2");
const cors = require("cors");
const jwt = require("jsonwebtoken");


const secret_key ="68b0fbe547a2268a6f8f327f06144eb9e79d2a0eb575d93a2b6b2f3d976f81083e46910e68903238581c8610ee0dbf679d5501236c046c4333d76ba25fd3e681";


const app = express();
app.use(cors());
app.use(express.json());

app.listen(5001, () => {
  console.log("Server is running on port 5001");
});

const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "1234",
  database: "red_dress_db",
});

db.connect((err) => {
  if (err) {
    console.log(err);
  } else {
    console.log("Connected to database");
  }
});

// POST API to register new user

app.post("/api/add_user", (req, res) => {
  console.log(req.body);
  const { name, email, password } = req.body;

  const sql = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";

  db.query(sql, [name, email, password], (err, result) => {
    if (err) {
      return res.status(500).send(err);
    }

    res.status(200).json({
      message: "User added successfully",
    });
  });
});



// Middleware to verify JWT token
const verifyToken = (req, res, next) => {
  const token = req.headers.authorization?.split(" ")[1]; // Extract token from "Bearer <token>"

  if (!token) {
    return res.status(403).json({ message: "No token provided" });
  }

  jwt.verify(token, SECRET_KEY, (err, decoded) => {
    if (err) {
      return res.status(401).json({ message: "Invalid token" });
    }

    req.user = decoded; // Store user details in request
    next();
  });
};



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
      const user = result[0];

      // Generate a JWT token
      const token = jwt.sign(
        { userId: user.id, email: user.email }, 
        secret_key, 
        { expiresIn: "1h" } // Token expires in 1 hour
      );

      res.status(200).json({ message: "Login successful", token });
    } else {
      res.status(401).json({ message: "Invalid email or password" });
    }
  });
});

//GET API to all blouses
app.get("/api/blouses", verifyToken, (req, res) => {
  const sql = "SELECT * FROM blouses";
  db.query(sql, (err, results) => {
    if (err) {
      res.status(500).json({ error: err.message });
      return;
    }
    res.status(200).json(results);
  });
});

//GET API to all frocks
app.get("/api/frocks", verifyToken, (req, res) => {
  const sql = "SELECT * FROM frocks";
  db.query(sql, (err, results) => {
    if (err) {
      res.status(500).json({ error: err.message });
      return;
    }
    res.status(200).json(results);
  });
});

//GET API to all sarees
app.get("/api/sarees", verifyToken, (req, res) => {
  const sql = "SELECT * FROM sarees";
  db.query(sql, (err, results) => {
    if (err) {
      res.status(500).json({ error: err.message });
      return;
    }
    res.status(200).json(results);
  });
});

//GET API to all kids
app.get("/api/kids", verifyToken, (req, res) => {
  const sql = "SELECT * FROM kids";
  db.query(sql, (err, results) => {
    if (err) {
      res.status(500).json({ error: err.message });
      return;
    }
    res.status(200).json(results);
  });
});

// API endpoint to fetch all products
app.get("/api/products", verifyToken, (req, res) => {
  const query = `
      SELECT 'blouse' AS type, id, name, color, size, price, imageUrl FROM blouses
      UNION ALL
      SELECT 'frock' AS type, id, name, color, size, price, imageUrl FROM frocks
      UNION ALL
      SELECT 'saree' AS type, id, name, color, size, price, imageUrl FROM sarees
      UNION ALL
      SELECT 'kid' AS type, id, name, color, size, price, imageUrl FROM kids
    `;

  db.query(query, (err, results) => {
    if (err) {
      console.error("Error executing query:", err);
      return res.status(500).json({ error: "Failed to fetch products" });
    }

    if (results.length === 0) {
      return res.status(404).json({ message: "No products found" });
    }

    res.status(200).json(results);
  });
});



// API endpoint to fetch new arrivals
app.get("/api/new_arrivals", verifyToken, (req, res) => {
  const query = `SELECT * 
  FROM frocks 
  WHERE added_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) 
  UNION ALL
  SELECT * FROM blouses
  WHERE added_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
  
  ORDER BY added_date DESC`;
  

  db.query(query , (err, result) => {
    if (err){
      console.error("Error executing query:", err);
      return res.status(500).json({ error: "Failed to fetch products" });
    }
    res.status(200).json(result);
  })
});


// API endpoint to post orders
app.post("/api/orders", verifyToken, (req, res) => {
  const { name, address, phone, email, city, zip, price, latitude, longitude } = req.body;

  // Get the user ID based on the email
  const getUserIdSql = "SELECT id FROM users WHERE email = ?";

  db.query(getUserIdSql, [email], (err, result) => {
    if (err) {
      console.error("Error finding user ID:", err);
      return res.status(500).json({ error: "Failed to find user" });
    }
    
    if (result.length == 0) {
      return res.status(404).json({ error: "User not found" });
    }

    const userId = result[0].id;

    // Insert order with user_id
    const insertOrderSql = `
      INSERT INTO orders (customerName, address, phone, email, city, zip, price, user_id, latitude, longitude) 
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;

    db.query(insertOrderSql, [name, address, phone, email, city, zip, price, userId, latitude, longitude], (err, result) => {
      if (err) {
        console.error("Error inserting order:", err);
        return res.status(500).json({ error: "Failed to place order" });
      }
      res.status(200).json({ message: "Order placed successfull1y" });
    });
  });
});



// API endpoint to fetch orders by user_id
app.get("/api/userOrders/:user_id", verifyToken, (req, res) => {
  const userId = req.params.user_id; // Ensure we get user_id

  console.log("Fetching orders for user_id:", userId); // Debugging log

  const sql = `
    SELECT orders.id AS order_id, orders.customerName, orders.address, 
           orders.phone, orders.email, orders.city, orders.zip, orders.price, orders.orderPlacedDate,
           users.username, users.email
    FROM orders
    JOIN users ON users.id = orders.user_id
    WHERE users.id = ?`;

  db.query(sql, [userId], (err, result) => {
    if (err) {
      console.error("Error fetching user orders:", err);
      return res.status(500).json({ error: "Failed to fetch orders" });
    }

    if (result.length === 0) {
      console.log("No orders found for user:", userId); // Debugging
    }

    res.status(200).json(result);
  });
});


// API endpoint to fetch all orders

app.get("/api/users/email/:email", verifyToken,  (req, res) => {
  const email = req.params.email;

  console.log("Fetching user ID for email:", email); // Debugging log

  const sql = "SELECT id FROM users WHERE email = ? LIMIT 1";

  db.query(sql, [email], (err, result) => {
    if (err) {
      console.error("Error fetching user ID:", err);
      return res.status(500).json({ error: "Failed to fetch user ID" });
    }

    if (result.length === 0) {
      console.log("User not found for email:", email);
      return res.status(404).json({ error: "User not found" });
    }

    res.status(200).json({ id: result[0].id }); //Return as JSON object
  });
});



