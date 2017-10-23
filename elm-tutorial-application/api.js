const jsonServer = require('json-server');
const server = jsonServer.create();
const router = jsonServer.router('db.json');

server.use(jsonServer.create());
server.use(router);

console.log('Listening at 4000');
server.listen(4000);
