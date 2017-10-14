require('ace-cess/css/ace.css');
require('font-awesome/css/font-awesome.css');

require('./index.html');

const Elm = require('Main.eml');
const mountNode = document.getElementById('main');

const app = Elm.Main.embed(mountNode);
