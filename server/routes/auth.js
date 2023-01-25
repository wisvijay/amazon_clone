const express = require('express');

const Router = express.Router();

Router.get('/user', (req, res) => {
    res.json({"name": "vijay"});
})

module.exports = Router;