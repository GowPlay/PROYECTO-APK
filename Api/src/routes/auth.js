const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const db = require('../config/db');

// Registro de usuario
router.post('/register', async (req, res) => {
    const { nombre, telefono, email, password, rol_id } = req.body;

    const hashedPassword = await bcrypt.hash(password, 10);
    db.query('INSERT INTO Usuarios (nombre, telefono, email, password, rol_id) VALUES (?, ?, ?, ?, ?)', 
    [nombre, telefono, email, hashedPassword, rol_id], (err, results) => {
        if (err) {
            return res.status(500).send(err);
        }
        res.json({ id: results.insertId, nombre, telefono, email, rol_id });
    });
});

// Inicio de sesión
router.post('/login', (req, res) => {
    const { email, password } = req.body;
    db.query('SELECT * FROM Usuarios WHERE email = ?', [email], async (err, results) => {
        if (err || results.length === 0) {
            return res.status(400).send('Email o contraseña incorrectos');
        }

        const user = results[0];
        const validPass = await bcrypt.compare(password, user.password);
        if (!validPass) return res.status(400).send('Email o contraseña incorrectos');

        db.query('SELECT p.nombre FROM Permisos p INNER JOIN Rol_Permisos rp ON p.id = rp.permiso_id WHERE rp.rol_id = ?', [user.rol_id], (err, permisos) => {
            if (err) return res.status(500).send(err);

            const token = jwt.sign({ id: user.id, rol: user.rol_id, permissions: permisos.map(p => p.nombre) }, 'your_jwt_secret');
            res.header('Authorization', token).send({ token });
        });
    });
});

module.exports = router;
