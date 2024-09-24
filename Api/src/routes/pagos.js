const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth');
const checkPermission = require('../middleware/checkPermission');
const db = require('../config/db');

// Obtener todos los pagos de un pedido
router.get('/:pedido_id', auth, checkPermission('ver_pagos'), (req, res) => {
    const { pedido_id } = req.params;
    db.query('SELECT * FROM Pagos WHERE pedido_id = ?', [pedido_id], (err, results) => {
        if (err) return res.status(500).send(err);
        res.json(results);
    });
});

// Añadir un pago a un pedido
router.post('/', auth, checkPermission('gestionar_pagos'), (req, res) => {
    const { pedido_id, metodo_pago, monto_pagado, fecha_pago } = req.body;
    db.query('INSERT INTO Pagos (pedido_id, metodo_pago, monto_pagado, fecha_pago) VALUES (?, ?, ?, ?)', 
    [pedido_id, metodo_pago, monto_pagado, fecha_pago], (err, results) => {
        if (err) return res.status(500).send(err);
        res.json({ id: results.insertId, pedido_id, metodo_pago, monto_pagado, fecha_pago });
    });
});

module.exports = router;
