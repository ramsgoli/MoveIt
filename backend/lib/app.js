'use strict';

var _express = require('express');

var _express2 = _interopRequireDefault(_express);

var _config = require('./config');

var _config2 = _interopRequireDefault(_config);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var app = (0, _express2.default)();
app.use(_express2.default.static(__dirname + '../public'));

app.get('/', function (req, res) {
    res.sendFile('index');
});

app.get('/users');

app.listen(_config2.default.PORT, _config2.default.HOST, function () {
    console.log('app listening on port ' + _config2.default.PORT);
});