const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth');
const checkPermission = require('../middleware/checkPermission');
const db = require('../config/db');

// Obtener todos los productos
router.get('/', auth, checkPermission('ver_productos'), (req, res) => {
    db.query('SELECT * FROM Productos', (err, results) => {
        if (err) return res.status(500).send(err);
        res.json(results);
    });
});

// Crear un nuevo producto
router.post('/', auth, checkPermission('gestionar_productos'), (req, res) => {
    const { nombre, descripcion, precio, categoria_id } = req.body;
    db.query('INSERT INTO Productos (nombre, descripcion, precio, categoria_id) VALUES (?, ?, ?, ?)', 
    [nombre, descripcion, precio, categoria_id], (err, results) => {
        if (err) return res.status(500).send(err);
        res.json({ id: results.insertId, nombre, descripcion, precio, categoria_id });
    });
});

module.exports = router;
