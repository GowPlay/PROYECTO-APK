const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth');
const checkPermission = require('../middleware/checkPermission');
const db = require('../config/db');

// Obtener todas las categorías
router.get('/', auth, checkPermission('ver_categorias'), (req, res) => {
    db.query('SELECT * FROM Categorias', (err, results) => {
        if (err) return res.status(500).send(err);
        res.json(results);
    });
});

// Crear una nueva categoría
router.post('/', auth, checkPermission('gestionar_categorias'), (req, res) => {
    const { nombre, descripcion } = req.body;
    db.query('INSERT INTO Categorias (nombre, descripcion) VALUES (?, ?)', 
    [nombre, descripcion], (err, results) => {
        if (err) return res.status(500).send(err);
        res.json({ id: results.insertId, nombre, descripcion });
    });
});

module.exports = router;
