console.log('hello from node');

const express = require('express');
const mongoose = require('mongoose');
const authRouter = require('./routes/auth')
const passwords = require('./passwords')
mongoose.set('strictQuery', false);

const app = express();


app.use(express.json());
app.use(authRouter);

const PORT = 3000;
const IP = "0.0.0.0";

mongoose.connect(passwords.DB).then(() => {
    console.log('Connection Successful!');
}).catch(() => {
    console.log('Connection Failed!');
})

//GET
app.get('/', (req, res) => {
    res.send("This is home page");
});

app.listen(PORT, IP, () => {
    console.log(`Connected to port ${PORT} hello`);
});