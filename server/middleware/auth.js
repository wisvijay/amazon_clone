const jwt = require('jsonwebtoken');

const auth = async (req, res, next) => {
const token = req.header('x-auth-token');
if (!token) {
    return res.status(401).json({msg: "No token found! Access denied!"});
}
const istokenValid = jwt.verify(token, "passwordKey");
if (!istokenValid) {
    return res.status(401).json({msg: "Token not found! Unauthorized user!"});
}

req.user = istokenValid.id;
req.token = token;
next();
}

module.exports = auth;