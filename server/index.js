console.log('hello from node');

const express = require('express');
const authRouter = require('./routes/auth')

const app = express();

app.use(authRouter);

const PORT = 3000;
const IP = "0.0.0.0";

//GET
app.get('/', (req, res) => {
    res.send("This is home page");
});

app.listen(PORT, IP, () => {
    console.log(`Connected to port ${PORT} hello`);
});