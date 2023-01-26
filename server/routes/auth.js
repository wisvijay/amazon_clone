const express = require('express');
const User = require('../modules/user');

const authRouter = express.Router();

authRouter.post('/api/signup', async (req, res) => {
    try {
        const {name, email, password} = req.body;
        let existingUser = await User.findOne({email});
    
        if (existingUser) {
            return res.status(400).json({msg: "User already exists!"});
        } 

    let user = new User({name, email, password});
    user = await user.save();
    res.json(user);

    } catch (err) {
        return res.status(500).json({error: err.message});
    }
})

module.exports = authRouter;