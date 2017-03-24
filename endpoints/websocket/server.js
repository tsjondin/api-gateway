'use strict';

const WebSocket = require('ws');
const port = 20000;
const server = new WebSocket.Server({port});

server.on('error', console.log)
	.on('listening', () => {
		console.log('server listening');
	}).on('connection', ws => {
		console.log("websocket connection");
		ws.on('message', message => {
			console.log(`received message ${message}`);
			ws.send("pong");
		});
});

console.log('Running on ws://localhost:' + port);
