const express = require('express');
const morgan = require('morgan');
const path = require('path');
const routes = require('./routes');
const cors = require('cors');
require('dotenv').config();

const { wsServer } = require('./websockets');

const app = express();

app.use(morgan('dev'));
app.use(cors());

app.use(express.static(path.join(__dirname, '/public')));

app.use('/', routes);

const PORT = process.env.PORT ?? 5000;

const httpServer = app.listen(PORT);

// start Websockets server based on httpServer
wsServer(httpServer);
