const express = require('express')
const app = express()
const port = process.env.PORT || 3000;

app.use(express.json());

app.get('/', (req, res) => {
    req.setEncoding('Hello, this is the IMS API!');
});

app.listen(port, () => {
    console.log(`IMS app listening at http://localhost:${port}`);
})

