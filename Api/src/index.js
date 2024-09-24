const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();

app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

const authRoute = require('./routes/auth');
const clientesRoute = require('./routes/clientes');
const empleadosRoute = require('./routes/empleados');
const productosRoute = require('./routes/productos');
const pedidosRoute = require('./routes/pedidos');
const entregasRoute = require('./routes/entregas');
const categoriasRoute = require('./routes/categorias');
const pagosRoute = require('./routes/pagos');
const detallePedidosRoute = require('./routes/detallePedidos');

app.use('/api/auth', authRoute);
app.use('/api/clientes', clientesRoute);
app.use('/api/empleados', empleadosRoute);
app.use('/api/productos', productosRoute);
app.use('/api/pedidos', pedidosRoute);
app.use('/api/entregas', entregasRoute);
app.use('/api/categorias', categoriasRoute);
app.use('/api/pagos', pagosRoute);
app.use('/api/detallePedidos', detallePedidosRoute);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Servidor ejecutándose en el puerto ${PORT}`);
});
