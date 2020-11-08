var mysql = require('mysql');
var express = require('express');
var session = require('express-session');
var bodyParser = require('body-parser');
var path = require('path');

var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'newuser',
  password : 'password',
  database : 'motel',
  multipleStatements : 'true'
});

connection.connect((err) => {
  if (err) throw err;
  console.log('Connected to MySQL Server!');
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
  // var email = 'beerhouse@gmail.com';
  // var password = 'ellemayoh';
  // ^ use for testing
  if (email && password) {
    connection.query('SELECT * FROM Staff WHERE email = ? AND password = ?', [email, password], function(error, results, fields) {
      if (results != null && results.length != 0) {
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

app.post('/cust-auth', function(request, response) {
  var email = request.body.email;
  var password = request.body.password;
  // var email = 'pmedina@gmail.com';
  // var password = 'princess';
  // ^ use for testing
  if (email && password) {
    connection.query('SELECT Pet.name, Pet.age, Pet.species, Owner.email FROM Owner, Pet WHERE email = ? AND password = ? AND Pet.ownerID = Owner.custID', [email, password], function(error, results, fields) {
      if (results != null && results.length != 0) {
        request.session.loggedin = true;
        request.session.email = email;
        request.session.results = results;
        return response.redirect('/cust-home');
      } else {
        response.send('Incorrect Email and/or Password! Second if');
      }
      response.end();
    });
  } else {
    response.send('Please enter Email and Password!');
    response.end();
  }
});

app.get('/home', function(request, response) {
  return response.sendFile(path.join(__dirname + '/home.html'));
});

app.post('/staffOptions', function(request, response) {
  console.log(request.body);
  if (request.body['staffOptions'] == 'insert') {
    response.redirect('/insert');
  } else if (request.body['staffOptions'] == 'edit') {
    response.redirect('/edit');
  } else if (request.body['staffOptions'] == 'select') {
    response.redirect('/select')
  } else if (request.body['staffOptions'] == 'delete') {
    response.redirect('/delete')
  } else if (request.body['staffOptions'] == 'join') {
    response.redirect('/join')
  } else if (request.body['staffOptions'] == 'division') {
    response.redirect('/division')
  }
  response.end();
});

/**
INSERT
**/
app.get('/insert', function(request, response) {
  let html = "<div class='login-form'><h1>Add Customer</h1><form action='insert' method='GET'><input type='text' name='custID' placeholder='custID'><input type='text' name='email' placeholder='Email' ><input type='text' name='phone' placeholder='Phone Number'><input type='text' name='password' placeholder='Password'><input type='text' name='postalCode' placeholder='Postal Code'><input type='text' name='street' placeholder='Street'><input type='text' name='firstName' placeholder='First Name' ><input type='text' name='lastName' placeholder='Last Name'><input type='submit'></form></div>";
  let url = request.url;
  if (url.includes("&")) {
    // hi abbi split the request URL so we get back all the customer info they inputted!
    let custID = url.split("&")[0].split("=")[1];
    console.log(custID);
    addCustomer([ARGUMENTS], function (results) {
      // console.log(results);
    })
  }
  response.send(html);
  response.end();
});

function addCustomer([ARGUMENTS], callback) {
  // you can look at editOwner for inspo
}


/**
EDIT
**/
app.get('/edit', function(request, response) {
  let html = "<style type='text/css'> html{height: 100%;}table, td{border: 1px solid #000;}body{color: white; margin: 0; padding: 0; font-family: sans-serif; background: linear-gradient(#790972, #00d4ff);}.login-box{position: absolute; top: 50%; left: 50%; width: 400px; padding: 40px; transform: translate(-50%, -50%); background: rgba(0, 0, 0, 0.5); box-sizing: border-box; box-shadow: 0 15px 25px rgba(0, 0, 0, 0.6); border-radius: 10px;}.login-box h2{margin: 0 0 30px; padding: 0; color: #fff; text-align: center;}input{position: relative; display: inline-block; padding: 10px 20px; color: black; font-size: 16px; text-decoration: none; text-transform: uppercase; overflow: hidden; transition: 0.5s; margin-top: 40px; letter-spacing: 2px;}.login-box .user-box{position: relative;}.login-box .user-box input{width: 100%; padding: 10px 0; padding-left: 5px; font-size: 16px; color: #fff; margin-bottom: 30px; border: none; border-bottom: 1px solid #fff; outline: none; background: transparent;}.login-box .user-box label{position: absolute; top: 0; left: 0; padding: 10px 0; font-size: 16px; color: #fff; pointer-events: none; transition: 0.5s;}.login-box .user-box input:focus ~ label, .login-box .user-box input:valid ~ label{top: -20px; left: 0; color: #03e9f4; font-size: 12px;}input:hover{background: #03e9f4; color: black; border-radius: 5px; box-shadow: 0 0 5px #03e9f4, 0 0 25px #03e9f4, 0 0 50px #03e9f4, 0 0 100px #03e9f4;}input span{position: absolute; display: block;}input span:nth-child(1){top: 0; left: -100%; width: 100%; height: 2px; background: linear-gradient(90deg, transparent, #03e9f4); animation: btn-anim1 1s linear infinite;}@keyframes btn-anim1{0%{left: -100%;}50%, 100%{left: 100%;}}input span:nth-child(2){top: -100%; right: 0; width: 2px; height: 100%; background: linear-gradient(180deg, transparent, #03e9f4); animation: btn-anim2 1s linear infinite; animation-delay: 0.25s;}@keyframes btn-anim2{0%{top: -100%;}50%, 100%{top: 100%;}}input span:nth-child(3){bottom: 0; right: -100%; width: 100%; height: 2px; background: linear-gradient(270deg, transparent, #03e9f4); animation: btn-anim3 1s linear infinite; animation-delay: 0.5s;}@keyframes btn-anim3{0%{right: -100%;}50%, 100%{right: 100%;}}] input span:nth-child(4){bottom: -100%; left: 0; width: 2px; height: 100%; background: linear-gradient(360deg, transparent, #03e9f4); animation: btn-anim4 1s linear infinite; animation-delay: 0.75s;}@keyframes btn-anim4{0%{bottom: -100%;}50%, 100%{bottom: 100%;}}.tab{overflow: hidden; border: 1px solid #ccc; background-color: #f1f1f1;}/* Style the buttons inside the tab */ .tab button{background-color: inherit; float: left; border: none; outline: none; cursor: pointer; padding: 14px 16px; transition: 0.3s; font-size: 17px;}/* Change background color of buttons on hover */ .tab button:hover{background: #03e9f4; color: black; border-radius: 5px; box-shadow: 0 0 5px #03e9f4, 0 0 25px #03e9f4, 0 0 50px #03e9f4, 0 0 100px #03e9f4;}/* Create an active/current tablink class */ .tab button.active{background-color: #ccc;}/* Style the tab content */ .tabcontent{display: none; padding: 6px 12px; border-top: none;}</style><div class='login-box'> <h2>Edit Customer Info</h2> <form action='edit' method='GET'> <div class='user-box'><input type='text' name='custID' required=''/><label>Customer ID</label></div><div class='user-box'><input type='text' name='newFirstName' required=''/><label>New Name</label></div><div id='submit'><input type='submit'/> <span></span> <span></span></div></form></div><form style = 'padding-left:15px;'><input type='button' value='Go back!' onclick='history.back()'></form>";
  let url = request.url;
  if (url.includes("&")) {
    let custID = url.split("&")[0].split("=")[1];
    let newName = url.split("=")[2];
    // console.log(custID);
    // console.log(newName);
    editOwner(custID, newName, function (results) {
      // console.log(results);
    })
  }
  response.send(html);
  response.end();
});

function editOwner(custID, toChange, callback) {
  let updateQuery = "UPDATE Owner SET firstName = ? WHERE custID = ?";
  connection.query(updateQuery, [toChange, custID], function(error, results) {
    return callback(results);
  });
}


/**
SELECT
**/
app.get('/select', function(request, response) {
  let html = "<style type='text/css'> html{height: 100%;}table, td{border: 1px solid #000;}body{color: white; margin: 0; padding: 0; font-family: sans-serif; background: linear-gradient(#790972, #00d4ff);}.login-box{position: absolute; top: 50%; left: 50%; width: 400px; padding: 40px; transform: translate(-50%, -50%); background: rgba(0, 0, 0, 0.5); box-sizing: border-box; box-shadow: 0 15px 25px rgba(0, 0, 0, 0.6); border-radius: 10px;}.login-box h2{margin: 0 0 30px; padding: 0; color: #fff; text-align: center;}input{position: relative; display: inline-block; padding: 10px 20px; color: black; font-size: 16px; text-decoration: none; text-transform: uppercase; overflow: hidden; transition: 0.5s; margin-top: 40px; letter-spacing: 2px;}.login-box .user-box{position: relative;}.login-box .user-box input{width: 100%; padding: 10px 0; padding-left: 5px; font-size: 16px; color: #fff; margin-bottom: 30px; border: none; border-bottom: 1px solid #fff; outline: none; background: transparent;}.login-box .user-box label{position: absolute; top: 0; left: 0; padding: 10px 0; font-size: 16px; color: #fff; pointer-events: none; transition: 0.5s;}.login-box .user-box input:focus ~ label, .login-box .user-box input:valid ~ label{top: -20px; left: 0; color: #03e9f4; font-size: 12px;}input:hover{background: #03e9f4; color: black; border-radius: 5px; box-shadow: 0 0 5px #03e9f4, 0 0 25px #03e9f4, 0 0 50px #03e9f4, 0 0 100px #03e9f4;}input span{position: absolute; display: block;}input span:nth-child(1){top: 0; left: -100%; width: 100%; height: 2px; background: linear-gradient(90deg, transparent, #03e9f4); animation: btn-anim1 1s linear infinite;}@keyframes btn-anim1{0%{left: -100%;}50%, 100%{left: 100%;}}input span:nth-child(2){top: -100%; right: 0; width: 2px; height: 100%; background: linear-gradient(180deg, transparent, #03e9f4); animation: btn-anim2 1s linear infinite; animation-delay: 0.25s;}@keyframes btn-anim2{0%{top: -100%;}50%, 100%{top: 100%;}}input span:nth-child(3){bottom: 0; right: -100%; width: 100%; height: 2px; background: linear-gradient(270deg, transparent, #03e9f4); animation: btn-anim3 1s linear infinite; animation-delay: 0.5s;}@keyframes btn-anim3{0%{right: -100%;}50%, 100%{right: 100%;}}] input span:nth-child(4){bottom: -100%; left: 0; width: 2px; height: 100%; background: linear-gradient(360deg, transparent, #03e9f4); animation: btn-anim4 1s linear infinite; animation-delay: 0.75s;}@keyframes btn-anim4{0%{bottom: -100%;}50%, 100%{bottom: 100%;}}.tab{overflow: hidden; border: 1px solid #ccc; background-color: #f1f1f1;}/* Style the buttons inside the tab */ .tab button{background-color: inherit; float: left; border: none; outline: none; cursor: pointer; padding: 14px 16px; transition: 0.3s; font-size: 17px;}/* Change background color of buttons on hover */ .tab button:hover{background: #03e9f4; color: black; border-radius: 5px; box-shadow: 0 0 5px #03e9f4, 0 0 25px #03e9f4, 0 0 50px #03e9f4, 0 0 100px #03e9f4;}/* Create an active/current tablink class */ .tab button.active{background-color: #ccc;}/* Style the tab content */ .tabcontent{display: none; padding: 6px 12px; border-top: none;}</style><div class='login-box'> <h2>Show Room Inhabitants</h2> <form action='select-result' method='GET'> <div class='user-box'><input type='text' name='branchID' required=''/><label>Branch ID #</label></div><div class='user-box'><input type='text' name='roomNo' required=''/><label>Room #</label></div><div id='submit'><input type='submit'/> <span></span> <span></span></div></form></div><form style='padding-left:15px;'><input type='button' style='padding-left:15px;' value='Go back!' onclick='history.back()'></form>";
  response.send(html);
  response.end();
});

app.get('/select-result', function(request, response) {

  let url = request.url;

  if (url.includes("&")) {
    let branchID = url.split("&")[0].split("=")[1];
    let roomNo = url.split("=")[2];
    // console.log(custID);
    // console.log(newName);
    selectInhabitants(branchID, roomNo, function (results) {
      let allResults = '<style type="text/css">table, td { border: 1px solid #000; border-collapse:collapse;}</style>';

      petResult = results;

      let petFields = ['age', 'species'];

      for (i = 0; i < petResult.length; i++) { // looping over pets
        let tableResult = '<table>';
        allResults += '<h1>' + petResult[i]['name'] + '</h1>';
        for (j = 0; j < petFields.length; j++) {
          tableResult += "<tr><td>" + petFields[j] + "</td><td>" + petResult[i][petFields[j]] + "</td></tr>";
        }
        tableResult += '</table>';
        allResults += tableResult;
      }
      // console.log(results);
      send(response, allResults);
    })
  }
});

function send(response, allResults) {
  response.send(allResults);
  response.end();
}

function selectInhabitants(branchID, roomNo, callback) {
  let selectQuery = "SELECT * FROM Pet WHERE branchID = ? AND roomNo = ?";
  connection.query(selectQuery, [branchID, roomNo], function(error, results) {
    return callback(results);
  });
}


/**
DELETE
**/

app.get('/delete', function(request, response) {
  let html = "<style type='text/css'> html{height: 100%;}table, td{border: 1px solid #000;}body{color: white; margin: 0; padding: 0; font-family: sans-serif; background: linear-gradient(#790972, #00d4ff);}.login-box{position: absolute; top: 50%; left: 50%; width: 400px; padding: 40px; transform: translate(-50%, -50%); background: rgba(0, 0, 0, 0.5); box-sizing: border-box; box-shadow: 0 15px 25px rgba(0, 0, 0, 0.6); border-radius: 10px;}.login-box h2{margin: 0 0 30px; padding: 0; color: #fff; text-align: center;}input{position: relative; display: inline-block; padding: 10px 20px; color: black; font-size: 16px; text-decoration: none; text-transform: uppercase; overflow: hidden; transition: 0.5s; margin-top: 40px; letter-spacing: 2px;}.login-box .user-box{position: relative;}.login-box .user-box input{width: 100%; padding: 10px 0; padding-left: 5px; font-size: 16px; color: #fff; margin-bottom: 30px; border: none; border-bottom: 1px solid #fff; outline: none; background: transparent;}.login-box .user-box label{position: absolute; top: 0; left: 0; padding: 10px 0; font-size: 16px; color: #fff; pointer-events: none; transition: 0.5s;}.login-box .user-box input:focus ~ label, .login-box .user-box input:valid ~ label{top: -20px; left: 0; color: #03e9f4; font-size: 12px;}input:hover{background: #03e9f4; color: black; border-radius: 5px; box-shadow: 0 0 5px #03e9f4, 0 0 25px #03e9f4, 0 0 50px #03e9f4, 0 0 100px #03e9f4;}input span{position: absolute; display: block;}input span:nth-child(1){top: 0; left: -100%; width: 100%; height: 2px; background: linear-gradient(90deg, transparent, #03e9f4); animation: btn-anim1 1s linear infinite;}@keyframes btn-anim1{0%{left: -100%;}50%, 100%{left: 100%;}}input span:nth-child(2){top: -100%; right: 0; width: 2px; height: 100%; background: linear-gradient(180deg, transparent, #03e9f4); animation: btn-anim2 1s linear infinite; animation-delay: 0.25s;}@keyframes btn-anim2{0%{top: -100%;}50%, 100%{top: 100%;}}input span:nth-child(3){bottom: 0; right: -100%; width: 100%; height: 2px; background: linear-gradient(270deg, transparent, #03e9f4); animation: btn-anim3 1s linear infinite; animation-delay: 0.5s;}@keyframes btn-anim3{0%{right: -100%;}50%, 100%{right: 100%;}}] input span:nth-child(4){bottom: -100%; left: 0; width: 2px; height: 100%; background: linear-gradient(360deg, transparent, #03e9f4); animation: btn-anim4 1s linear infinite; animation-delay: 0.75s;}@keyframes btn-anim4{0%{bottom: -100%;}50%, 100%{bottom: 100%;}}.tab{overflow: hidden; border: 1px solid #ccc; background-color: #f1f1f1;}/* Style the buttons inside the tab */ .tab button{background-color: inherit; float: left; border: none; outline: none; cursor: pointer; padding: 14px 16px; transition: 0.3s; font-size: 17px;}/* Change background color of buttons on hover */ .tab button:hover{background: #03e9f4; color: black; border-radius: 5px; box-shadow: 0 0 5px #03e9f4, 0 0 25px #03e9f4, 0 0 50px #03e9f4, 0 0 100px #03e9f4;}/* Create an active/current tablink class */ .tab button.active{background-color: #ccc;}/* Style the tab content */ .tabcontent{display: none; padding: 6px 12px; border-top: none;}</style><div class='login-box'> <h2>Remove Customer</h2> <form action='delete-result' method='GET'> <div class='user-box'><input type='text' name='custID' required=''/><label>Customer ID</label></div><div id='submit'><input type='submit'/> <span></span> <span></span></div></form></div><form style='padding-left:15px;'><input type='button' style='padding-left:15px;' value='Go back!' onclick='history.back()'></form>";
  response.send(html);
  response.end();
});

function deleteCust(custID, callback) {
  console.log(custID);
  let deleteQuery = "DELETE FROM Owner WHERE custID = ?";
  connection.query(deleteQuery, [custID], function(error, results) {
    return callback(results);
  });
}

app.get('/delete-result', function(request, response) {
  let url = request.url;
  if (url.includes("?")) {
    let custID = url.split("=")[1];
    // console.log(newName);
    deleteCust(custID, function (results) {
      // console.log(results);
    })
  }
  let html = "Customer successfully deleted.";
  response.send(html);
  response.end();
});

/**
JOIN
**/

app.get('/join', function(request, response) {
  let html = "<style type='text/css'> html{height: 100%;}table, td{border: 1px solid #000;}body{color: white; margin: 0; padding: 0; font-family: sans-serif; background: linear-gradient(#790972, #00d4ff);}.login-box{position: absolute; top: 50%; left: 50%; width: 400px; padding: 40px; transform: translate(-50%, -50%); background: rgba(0, 0, 0, 0.5); box-sizing: border-box; box-shadow: 0 15px 25px rgba(0, 0, 0, 0.6); border-radius: 10px;}.login-box h2{margin: 0 0 30px; padding: 0; color: #fff; text-align: center;}input{position: relative; display: inline-block; padding: 10px 20px; color: black; font-size: 16px; text-decoration: none; text-transform: uppercase; overflow: hidden; transition: 0.5s; margin-top: 40px; letter-spacing: 2px;}.login-box .user-box{position: relative;}.login-box .user-box input{width: 100%; padding: 10px 0; padding-left: 5px; font-size: 16px; color: #fff; margin-bottom: 30px; border: none; border-bottom: 1px solid #fff; outline: none; background: transparent;}.login-box .user-box label{position: absolute; top: 0; left: 0; padding: 10px 0; font-size: 16px; color: #fff; pointer-events: none; transition: 0.5s;}.login-box .user-box input:focus ~ label, .login-box .user-box input:valid ~ label{top: -20px; left: 0; color: #03e9f4; font-size: 12px;}input:hover{background: #03e9f4; color: black; border-radius: 5px; box-shadow: 0 0 5px #03e9f4, 0 0 25px #03e9f4, 0 0 50px #03e9f4, 0 0 100px #03e9f4;}input span{position: absolute; display: block;}input span:nth-child(1){top: 0; left: -100%; width: 100%; height: 2px; background: linear-gradient(90deg, transparent, #03e9f4); animation: btn-anim1 1s linear infinite;}@keyframes btn-anim1{0%{left: -100%;}50%, 100%{left: 100%;}}input span:nth-child(2){top: -100%; right: 0; width: 2px; height: 100%; background: linear-gradient(180deg, transparent, #03e9f4); animation: btn-anim2 1s linear infinite; animation-delay: 0.25s;}@keyframes btn-anim2{0%{top: -100%;}50%, 100%{top: 100%;}}input span:nth-child(3){bottom: 0; right: -100%; width: 100%; height: 2px; background: linear-gradient(270deg, transparent, #03e9f4); animation: btn-anim3 1s linear infinite; animation-delay: 0.5s;}@keyframes btn-anim3{0%{right: -100%;}50%, 100%{right: 100%;}}] input span:nth-child(4){bottom: -100%; left: 0; width: 2px; height: 100%; background: linear-gradient(360deg, transparent, #03e9f4); animation: btn-anim4 1s linear infinite; animation-delay: 0.75s;}@keyframes btn-anim4{0%{bottom: -100%;}50%, 100%{bottom: 100%;}}.tab{overflow: hidden; border: 1px solid #ccc; background-color: #f1f1f1;}/* Style the buttons inside the tab */ .tab button{background-color: inherit; float: left; border: none; outline: none; cursor: pointer; padding: 14px 16px; transition: 0.3s; font-size: 17px;}/* Change background color of buttons on hover */ .tab button:hover{background: #03e9f4; color: black; border-radius: 5px; box-shadow: 0 0 5px #03e9f4, 0 0 25px #03e9f4, 0 0 50px #03e9f4, 0 0 100px #03e9f4;}/* Create an active/current tablink class */ .tab button.active{background-color: #ccc;}/* Style the tab content */ .tabcontent{display: none; padding: 6px 12px; border-top: none;}</style><div class='login-box'> <h2>Show all pets and owners</h2> <form action='join-result' method='GET'> <div class='user-box'><input type='text' name='species' required=''/><label>e.g. Dog, Cat, Turtle</label></div><div id='submit'><input type='submit'/> <span></span> <span></span></div></form></div><form style='padding-left:15px;'><input type='button' style='padding-left:15px;' value='Go back!' onclick='history.back()'></form>";
  response.send(html);
  response.end();
});

app.get('/join-result', function(request, response) {

  let url = request.url;

  if (url.includes("?")) {
    let species = url.split("=")[1];
    // console.log(custID);
    // console.log(newName);
    joinPetOwner(species, function (results) {
      let allResults = '<style type="text/css">table, td { border: 1px solid #000; border-collapse:collapse;}</style>';

      petResult = results;

      let petFields = ['firstName', 'lastName', 'name'];
      allResults += "<table> <tr><td> Owner's first name </td> <td> Owner's last name </td> <td> Pet name </td></tr>";

      for (i = 0; i < petResult.length; i++) { // looping over pets
        let tableResult = '<tr>';
        for (j = 0; j < petFields.length; j++) {
          tableResult += "<td>" + petResult[i][petFields[j]] + "</td>";
        }
        allResults += tableResult;
        allResults += "</tr>"
      }
      allResults += '</table> <br>';

      // console.log(results);
      send(response, allResults);
    })
  }
});

function send(response, allResults) {
  response.send(allResults);
  response.end();
}

function joinPetOwner(species, callback) {
  let joinQuery = "SELECT Owner.firstName, Owner.lastName, Pet.name FROM Pet, Owner WHERE species = ? AND Owner.custID = Pet.ownerID";
  connection.query(joinQuery, [species], function(error, results) {
    return callback(results);
  });
}

/**
DIVISION
**/
app.get('/division', function(request, response) {

    getBirdBranch(function (results) {
      let allResults = '<style type="text/css"> html{height: 100%;}table, td{border: 1px solid white; border-collapse: collapse;}body{color: white; margin: 0; padding: 0; font-family: sans-serif; background: linear-gradient(#790972, #00d4ff);}.login-box{position: absolute; top: 50%; left: 50%; width: 400px; padding: 40px; transform: translate(-50%, -50%); background: rgba(0, 0, 0, 0.5); box-sizing: border-box; box-shadow: 0 15px 25px rgba(0, 0, 0, 0.6); border-radius: 10px;}.login-box h2{margin: 0 0 30px; padding: 0; color: #fff; text-align: center;}input{position: relative; display: inline-block; padding: 10px 20px; color: black; font-size: 16px; text-decoration: none; text-transform: uppercase; overflow: hidden; transition: 0.5s; margin-top: 40px; letter-spacing: 2px;}.login-box .user-box{position: relative;}.login-box .user-box input{width: 100%; padding: 10px 0; padding-left: 5px; font-size: 16px; color: #fff; margin-bottom: 30px; border: none; border-bottom: 1px solid #fff; outline: none; background: transparent;}.login-box .user-box label{position: absolute; top: 0; left: 0; padding: 10px 0; font-size: 16px; color: #fff; pointer-events: none; transition: 0.5s;}.login-box .user-box input:focus ~ label, .login-box .user-box input:valid ~ label{top: -20px; left: 0; color: #03e9f4; font-size: 12px;}input:hover{background: #03e9f4; color: black; border-radius: 5px; box-shadow: 0 0 5px #03e9f4, 0 0 25px #03e9f4, 0 0 50px #03e9f4, 0 0 100px #03e9f4;}input span{position: absolute; display: block;}input span:nth-child(1){top: 0; left: -100%; width: 100%; height: 2px; background: linear-gradient(90deg, transparent, #03e9f4); animation: btn-anim1 1s linear infinite;}@keyframes btn-anim1{0%{left: -100%;}50%, 100%{left: 100%;}}input span:nth-child(2){top: -100%; right: 0; width: 2px; height: 100%; background: linear-gradient(180deg, transparent, #03e9f4); animation: btn-anim2 1s linear infinite; animation-delay: 0.25s;}@keyframes btn-anim2{0%{top: -100%;}50%, 100%{top: 100%;}}input span:nth-child(3){bottom: 0; right: -100%; width: 100%; height: 2px; background: linear-gradient(270deg, transparent, #03e9f4); animation: btn-anim3 1s linear infinite; animation-delay: 0.5s;}@keyframes btn-anim3{0%{right: -100%;}50%, 100%{right: 100%;}}] input span:nth-child(4){bottom: -100%; left: 0; width: 2px; height: 100%; background: linear-gradient(360deg, transparent, #03e9f4); animation: btn-anim4 1s linear infinite; animation-delay: 0.75s;}@keyframes btn-anim4{0%{bottom: -100%;}50%, 100%{bottom: 100%;}}.tab{overflow: hidden; border: 1px solid #ccc; background-color: #f1f1f1;}/* Style the buttons inside the tab */ .tab button{background-color: inherit; float: left; border: none; outline: none; cursor: pointer; padding: 14px 16px; transition: 0.3s; font-size: 17px;}/* Change background color of buttons on hover */ .tab button:hover{background: #03e9f4; color: black; border-radius: 5px; box-shadow: 0 0 5px #03e9f4, 0 0 25px #03e9f4, 0 0 50px #03e9f4, 0 0 100px #03e9f4;}/* Create an active/current tablink class */ .tab button.active{background-color: #ccc;}/* Style the tab content */ .tabcontent{display: none; padding: 6px 12px; border-top: none;}</style>';

      petResult = results;

      let petFields = ['branchID', 'phone', 'postalCode', 'street'];

      for (i = 0; i < petResult.length; i++) { // looping over pets
        let tableResult = '<table>';
        for (j = 0; j < petFields.length; j++) {
          tableResult += "<tr><td>" + petFields[j] + "</td><td>" + petResult[i][petFields[j]] + "</td></tr>";
        }
        tableResult += '</table>';
        allResults += tableResult;
      }
      // console.log(results);
      send(response, allResults);
    })
});

function getBirdBranch(callback) {
  let divisionQuery = "SELECT * FROM Branch WHERE NOT EXISTS (SELECT Bird.petID FROM Bird WHERE NOT EXISTS ( SELECT Pet.petID FROM Pet, Bird WHERE Pet.petID = Bird.petID AND Pet.branchID = Branch.branchID));";
  connection.query(divisionQuery, [], function(error, results) {
    return callback(results);
  });
}

/**
PROJECT (Using initial home page results as our project query)
**/

function getPetInfo(custResult, callback) {
  connection.query('SELECT * FROM Pet WHERE ownerID = ?', [custResult], function(error, petResult, fields) {
    return callback(petResult);

  });
}

app.get('/cust-home', function(request, response) {
  if (request.session.loggedin) {
    var email = request.session.email;
    var results = request.session.results;
    let petResult = results;

    let allResults = '<style type="text/css">table, td { border: 1px solid #000; border-collapse:collapse;}</style>';

    let petFields = ['age', 'species'];

    for (i = 0; i < petResult.length; i++) { // looping over pets
      let tableResult = '<table>';
      allResults += '<h1>' + petResult[i]['name'] + '</h1>';
      for (j = 0; j < petFields.length; j++) {
        tableResult += "<tr><td>" + petFields[j] + "</td><td>" + petResult[i][petFields[j]] + "</td></tr>";
      }
      tableResult += '</table>';
      allResults += tableResult;
    }
    response.send(allResults);
    // console.log(results);
  } else {
    response.send('Please login to view this page!');
  }
  response.end();
});

app.listen(3000);
