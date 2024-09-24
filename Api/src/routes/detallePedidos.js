const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth');
const checkPermission = require('../middleware/checkPermission');
const db = require('../config/db');

// Obtener detalle de un pedido
router.get('/:pedido_id', auth, checkPermission('ver_detalle_pedidos'), (req, res) => {
    const { pedido_id } = req.params;
    db.query('SELECT * FROM DetallePedidos WHERE pedido_id = ?', [pedido_id], (err, results) => {
        if (err) return res.status(500).send(err);
        res.json(results);
    });
});

// Añadir un producto al detalle de un pedido
router.post('/', auth, checkPermission('gestionar_pedidos'), (req, res) => {
    const { pedido_id, producto_id, cantidad, precio_unitario } = req.body;
    db.query('INSERT INTO DetallePedidos (pedido_id, producto_id, cantidad, precio_unitario) VALUES (?, ?, ?, ?)', 
    [pedido_id, producto_id, cantidad, precio_unitario], (err, results) => {
        if (err) return res.status(500).send(err);
        res.json({ id: results.insertId, pedido_id, producto_id, cantidad, precio_unitario });
    });
});

module.exports = router;
