
var express = require('express');
var config = require('./config');
var app = express();

app.use(express.static(__dirname + '/public'));


app.get('/', function(req, res) {
    res.sendFile('index');
});
app.listen(config.PORT, config.HOST, function() {
    console.log(`app listening on port ${config.PORT}`);
});
