const WebSocket = require('ws');
const fs = require('fs');
const path = require('path');

let connections = { websockets: [], users: [] }; // all current connections

function wsServer(httpServer) {
  const wss = new WebSocket.Server({ server: httpServer });
  wss.on('connection', (ws) => {
    // send an array with registered nicknames

    connections.websockets.push(ws);

    ws.send(JSON.stringify({ type: 'connected', payload: connections.users }));

    ws.on('message', (data) => {
      // restore object from JSON string
      console.log(data);
      const msg = data;
      console.log(connections);
      // do nickname registration
      if (msg.type == 'new nickname') registerNickname(ws, msg);
      // dispatch message to all connections
      if (msg.type == 'text') {
        connections.websockets.forEach((ws) => ws.send(JSON.stringify({ type: 'text', payload: msg.payload })));
      }
    });
    ws.on('close', () => {
      console.log('closed');
      const indexOfConnection = connections.websockets.indexOf(ws);
      const removedUser = connections.users[indexOfConnection];
      if (indexOfConnection != -1) {
        // remove connection from list of all connections
        connections.websockets.splice(indexOfConnection, 1);
        connections.users.splice(indexOfConnection, 1);
        // inform other connections of the fact
        connections.websockets.forEach((ws) => ws.send(JSON.stringify({ type: 'text', payload: { message: 'logged out', nick: removedUser } })));
        updateNickNames();
      }
    });
  });
}

function registerNickname(ws, msg) {
  // Check if nickname is already in use
  if (connections.users.includes(msg.payload)) return ws.send(JSON.stringify({ type: 'nickname status', payload: 'rejected' }));

  // save nickname and websocket in connections
  connections.websockets.push(ws);
  connections.users.push(msg.payload);

  // Create image for nickname

  fs.copyFile(path.join(__dirname, '../public/temp.png'), path.join(__dirname, `../public/images/${msg.payload}.png`), (err) => {
    if (err) throw err;
  });

  // update all connections with new list of nicknames
  updateNickNames();
  // send success status to client
  return ws.send(JSON.stringify({ type: 'nickname status', payload: 'success' }));
}

function updateNickNames() {
  // send all nicknames to connections
  let connectedWs = connections.websockets;

  connectedWs.forEach((ws) => {
    ws.send(JSON.stringify({ type: 'update nicknames', payload: connections.users }));
  });
}

module.exports = { wsServer, updateNickNames };
