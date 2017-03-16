'use strict';

const express = require('express');

const PORT = 10000;
const app = express();

app.get(['/', '/*'], function (req, res) {
	res.send(`<h1>Node Endpoint</h1><p>requested: ${req.url}</p>`);
});

app.listen(PORT);
console.log('Running on http://localhost:' + PORT);

