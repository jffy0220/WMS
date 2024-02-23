const express = require('express');
const orderRoutes = require('./routes/orderRoutes');
const app = express();
const port = 8080;

app.use(express.json());

app.get('/', (req, res) => {
    req.setEncoding('Hello, this is the OMS API!');
});

app.use('/api/orders', orderRoutes);

app.listen(port, () => {
    console.log(`OMS app listening at http://localhost:${port}`);
});

