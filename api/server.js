const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');

const app = express();
const port = 3000;
const host = "localhost";

app.use(cors());
app.use(express.json())
app.use(express.urlencoded({ extended: true }));
// Konfigurasi koneksi database
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'parkir'
});

// Connect ke database
db.connect(err => {
  if (err) {
    throw err;
  }
  console.log('MySQL Connected...');
});

app.post('/api/register', async (req, res) => {
    try {
      const { name, username, password } = req.body;
      const sql = 'INSERT INTO users (name, username, password) VALUES (?, ?, ?)';
      db.query(sql, [name, username, password], (err, result) => {
        res.status(200).json({
          status: true,
          name,
          username,
          password,
        });
      });
    } catch (error) {
      res.status(500).json({
        status: false,
        message: 'Error adding user',
        error: error.message
      });
    }
  });

// LOGIN: Verifikasi pengguna
app.post('/api/login', async (req, res) => {
    try {
      const { username, password } = req.body;
      const sql = 'SELECT * FROM users WHERE username = ? AND password = ?';
      db.query(sql, [username, password], (err, result) => {
        if (err) {
          throw err;
        }
        if (result.length > 0) {
          res.status(200).json({
            status: true,
            message: 'Login successful',
            user: result[0]
          });
        } else {
          res.status(401).json({
            status: false,
            message: 'Invalid username or password'
          });
        }
      });
    } catch (error) {
      res.status(500).json({
        status: false,
        message: 'Error during login',
        error: error.message
      });
    }
  });

  app.post('/api/addKendaraan', async (req, res) => {
    try {
      const { noplat, jenis } = req.body;
      const sql = 'INSERT INTO kendaraan (noplat, jenis) VALUES (?, ?)';
      db.query(sql, [noplat, jenis], (err, result) => {
        res.status(200).json({
          status: true,
          jenis,
          noplat
        });
      });
    } catch (error) {
      res.status(500).json({
        status: false,
        message: 'Error adding user',
        error: error.message
      });
    }
  });
  app.get('/api/getKendaraan/:noplat', async (req, res) => {
    try {
      const { noplat } = req.params;
      const sql = 'SELECT * FROM kendaraan WHERE noplat = ?';
      db.query(sql, [noplat], (err, result) => {
        if (err) {
          return res.status(500).json({
            status: false,
            message: 'Error retrieving kendaraan',
            error: err.message
          });
        }
        if (result.length > 0) {
          const kendaraan = result[0];
          res.status(200).json({
            status: true,
            data: kendaraan
          });
        } else {
          res.status(404).json({
            status: false,
            message: 'Kendaraan not found'
          });
        }
      });
    } catch (error) {
      res.status(500).json({
        status: false,
        message: 'Error retrieving kendaraan',
        error: error.message
      });
    }
  });
  app.get('/api/getKendaraan', async (req, res) => {
    try {
      // const { noplat } = req.params;
      const sql = 'SELECT * FROM kendaraan';
      db.query(sql, (err, result) => {
        if (err) {
          return res.status(500).json({
            status: false,
            message: 'Error retrieving kendaraan',
            error: err.message
          });
        }
        if (result.length > 0) {
          const kendaraan = result;
          res.status(200).json({
            status: true,
            data: kendaraan
          });
        } else {
          res.status(404).json({
            status: false,
            message: 'Kendaraan not found'
          });
        }
      });
    } catch (error) {
      res.status(500).json({
        status: false,
        message: 'Error retrieving kendaraan',
        error: error.message
      });
    }
  });
  
  app.get('/api/deleteKendaraan/:noplat', async (req, res) => {
    try {
      const { noplat } = req.params;
      const sql = 'DELETE FROM kendaraan WHERE noplat = ?';
      db.query(sql, [noplat], (err, result) => {
        if (err) {
          return res.status(500).json({
            status: false,
            message: 'Error deleting kendaraan',
            error: err.message
          });
        }
        if (result.affectedRows > 0) {
          res.status(200).json({
            status: true,
            message: 'Kendaraan deleted successfully'
          });
        } else {
          res.status(404).json({
            status: false,
            message: 'Kendaraan not found'
          });
        }
      });
    } catch (error) {
      res.status(500).json({
        status: false,
        message: 'Error deleting kendaraan',
        error: error.message
      });
    }
  });
  

app.listen(port, host, () => {
  console.log(`Server started on port ${host}:${port}`);
});
