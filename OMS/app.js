const express = require('express')
const app = express()
const port = 8080;

app.use(express.json());

app.get('/', (req, res) => {
    req.setEncoding('Hello, this is the OMS API!');
});

app.listen(port, () => {
    console.log(`OMS app listening at http://localhost:${port}`);
})

