var mysql = require('mysql');
var express = require('express');
var session = require('express-session');
var bodyParser = require('body-parser');
var path = require('path');

var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'newuser',
  password : 'password',
  database : 'motel'
});

var app = express();
app.use(session({
  secret: 'secret',
  resave: true,
  saveUninitialized: true
}));
app.use(bodyParser.urlencoded({extended : true}));
app.use(bodyParser.json());

app.get('/', function(request, response) {
  response.sendFile(path.join(__dirname + '/index.html'));
});

app.post('/auth', function(request, response) {
  var email = request.body.email;
  var password = request.body.password;
  if (email && password) {
    connection.query('SELECT * FROM Owner WHERE email = ? AND password = ?', [email, password], function(error, results, fields) {
      if (results.length > 0) {
        request.session.loggedin = true;
        request.session.email = email;
        response.redirect('/home');
      } else {
        response.send('Incorrect Email and/or Password!');
      }
      response.end();
    });
  } else {
    response.send('Please enter Email and Password!');
    response.end();
  }
});

app.get('/home', function(request, response) {
  if (request.session.loggedin) {
    var email = request.session.email;
    // connection.query('SELECT * FROM Owner WHERE email = ?', [email], function(error, results, fields) {
    //     var phone = results[0].phone;
    //     console.log(results[0].phone);
    //   });
    response.send('Welcome back, ' + request.session.email + '!');
  } else {
    response.send('Please login to view this page!');
  }
  response.end();
});

app.listen(3000);
