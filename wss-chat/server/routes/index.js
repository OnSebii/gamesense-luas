const express = require('express');
const router = express.Router();
const fs = require('fs');
const path = require('path');
const { updateNickNames } = require('../websockets');

// clear old pics after start of server
fs.rmdirSync(path.join(__dirname, '../public/images'), { recursive: true });
fs.mkdirSync(path.join(__dirname, '../public/images'));

module.exports = router;
