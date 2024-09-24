const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth');
const checkPermission = require('../middleware/checkPermission');
const db = require('../config/db');

// Obtener todos los clientes
router.get('/', auth, checkPermission('ver_clientes'), (req, res) => {
    db.query('SELECT * FROM Clientes', (err, results) => {
        if (err) return res.status(500).send(err);
        res.json(results);
    });
});

// Crear un nuevo cliente
router.post('/', auth, checkPermission('gestionar_clientes'), (req, res) => {
    const { nombre, telefono, direccion, email } = req.body;
    db.query('INSERT INTO Clientes (nombre, telefono, direccion, email) VALUES (?, ?, ?, ?)', 
    [nombre, telefono, direccion, email], (err, results) => {
        if (err) return res.status(500).send(err);
        res.json({ id: results.insertId, nombre, telefono, direccion, email });
    });
});

module.exports = router;
