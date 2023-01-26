console.log('hello from node');

const express = require('express');
const mongoose = require('mongoose');
const authRouter = require('./routes/auth')
mongoose.set('strictQuery', false);

const app = express();
const DB = "mongodb+srv://wisvijay:vijay123@cluster0.zbppopx.mongodb.net/?retryWrites=true&w=majority";

app.use(express.json());
app.use(authRouter);

const PORT = 3000;
const IP = "0.0.0.0";

mongoose.connect(DB).then(() => {
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