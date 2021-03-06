var mysql = require('mysql');
var express = require('express');
var session = require('express-session');
var bodyParser = require('body-parser');
var path = require('path');

var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'newuser',
  password : 'password',
  database : 'demoMotel',
  multipleStatements : 'true'
});

connection.connect((err) => {
  if (err) throw err;
  console.log('Connected to MySQL Server + app successfully running!');
});

var app = express();
app.use(session({
  secret: 'secret',
  resave: true,
  saveUninitialized: true
}));
app.use(bodyParser.urlencoded({extended : true}));
app.use(bodyParser.json());
app.use(express.static(path.join(__dirname, '')));

app.get('/', function(request, response) {
  response.sendFile(path.join(__dirname + '/index.html'));
});

// Authentication for staff login
app.post('/auth', function(request, response) {
  var email = request.body.email;
  var password = request.body.password;
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

// Authentication for customer login
app.post('/cust-auth', function(request, response) {
  var email = request.body.email;
  var password = request.body.password;
  if (email && password) {
    connection.query('SELECT Pet.name, Pet.age, Pet.species, Owner.firstName FROM Owner, Pet WHERE email = ? AND password = ? AND Pet.ownerID = Owner.custID', [email, password], function(error, results, fields) {
      if (results != null && results.length != 0) {
        request.session.loggedin = true;
        request.session.email = email;
        request.session.results = results;
        return response.redirect('/cust-home');
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

// Home page for Staff
app.get('/home', function(request, response) {
  return response.sendFile(path.join(__dirname + '/home.html'));
});

// Node.js/express for handling the dropdown menu
app.post('/staffOptions', function(request, response) {
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
  } else if (request.body['staffOptions'] == 'aggregationGroup') {
    response.redirect('/aggregationGroup')
  } else if (request.body['staffOptions'] == 'aggregationHaving') {
    response.redirect('/aggregationHaving')
  } else if (request.body['staffOptions'] == 'nestedAggregation') {
    response.redirect('/nestedAggregation')
  }
  response.end();
});

/**
INSERT
**/
app.get('/insert', function(request, response) {
  let html = "<link rel='stylesheet' href='home-style.css'><input type='button' style='padding:15px 15px; margin:15px;' value='Go back!' onclick='history.back()'><div class='login-form insert'><h1>Add Customer</h1><form accept-charset='utf-8' action='insert' method='GET'><input type='text' name='custID' placeholder='custID'><input type='text' name='email' placeholder='Email' ><input type='text' name='phone' placeholder='Phone Number'><input type='text' name='password' placeholder='Password'><input type='text' name='postalCode' placeholder='Postal Code'><input type='text' name='street' placeholder='Street'><input type='text' name='firstName' placeholder='First Name' ><input type='text' name='lastName' placeholder='Last Name'><input type='submit'></form>";

  //Note: there are 8 args
  let url = request.url;
  if (url.includes("&")) {
    let argArr = url.split("&");
    let pass = [];

    // Recovers special characters from URL
    argArr[1] = argArr[1].replace("%40", "@");
    argArr[5] = argArr[5].split("+").join(" ");

    for (i = 0; i < 8; i++) {
      pass.push(argArr[i].split("=")[1]);
    }

    addCustomer(pass[0],pass[1],pass[2],pass[3],pass[4],pass[5],pass[6],pass[7], function (results) {
      // Calls back
    })
  }
  response.send(html);
  response.end();
});

// Query for insert
function addCustomer(a1, a2, a3, a4, a5, a6, a7, a8, callback) {
  let insertQuery = "INSERT INTO Owner VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
  connection.query(insertQuery, [a1,a2,a3,a4,a5,a6,a7,a8], function(error, results){
    return callback(results);
  })
}


/**
EDIT
**/
app.get('/edit', function(request, response) {
  let html = "<link rel='stylesheet' href='home-style.css'><input type='button' style='padding:15px 15px; margin:15px;' value='Go back!' onclick='history.back()'><div class='login-form'><h1>Edit Customer Information</h1><form action='edit' method='GET'><input type='text' name='custID' placeholder='custID' ><input type='text' name='newFirstName' placeholder='New Name' ><input type='submit'></form></div>";
  let url = request.url;
  if (url.includes("&")) {
    let custID = url.split("&")[0].split("=")[1];
    let newName = url.split("=")[2];
    editOwner(custID, newName, function (results) {
      // Calls back
    })
  }
  response.send(html);
  response.end();
});

// Query for edit
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
  let html = "<link rel='stylesheet' href='home-style.css'><input type='button' style='padding:15px 15px; margin:15px;' value='Go back!' onclick='history.back()'><div class='login-form'><h1>Show Room Inhabitants</h1><form action='select-result' method='GET'><input type='text' name='branchID' placeholder='Branch ID #' ><input type='text' name='roomNo' placeholder='Room #' ><input type='submit'></form></div>";
  response.send(html);
  response.end();
});

app.get('/select-result', function(request, response) {

  let url = request.url;

  if (url.includes("&")) {
    let branchID = url.split("&")[0].split("=")[1];
    let roomNo = url.split("=")[2];
    selectInhabitants(branchID, roomNo, function (results) {
      let allResults = "<link rel='stylesheet' href='home-style.css'><div class='login-form'><table><tr>";

      petResult = results;

      let petFields = ['name', 'age', 'species'];

      for (i = 0; i < petFields.length; i++) {
        allResults += '<td>' + petFields[i] + '</td>';
      }
      allResults += '</tr>'

      for (i = 0; i < petResult.length; i++) { // looping over pets
        let tableResult = '<tr>';
        for (j = 0; j < petFields.length; j++) {
          tableResult += "<td>" + petResult[i][petFields[j]] + "</td>";
        }
        tableResult += '</tr>';
        allResults += tableResult;
      }
      allResults += "</table></div><input type='button' style='padding:15px 15px; margin:15px;' value='Go back!' onclick='history.back()'><link rel='stylesheet' href='home-style.css'>";
      send(response, allResults);
    })
  }
});

function send(response, allResults) {
  response.send(allResults);
  response.end();
}

// Query for select
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
  let html = "<link rel='stylesheet' href='home-style.css'><input type='button' style='padding:15px 15px; margin:15px;' value='Go back!' onclick='history.back()'><div class='login-form'><h1>Remove Customer</h1><form action='delete-result' method='GET'><input type='text' name='custID' placeholder='custID' ><input type='submit'></form></div>";
  response.send(html);
  response.end();
});

// Query for delete
function deleteCust(custID, callback) {
  let deleteQuery = "DELETE FROM Owner WHERE custID = ?";
  connection.query(deleteQuery, [custID], function(error, results) {
    return callback(results);
  });
}

app.get('/delete-result', function(request, response) {
  let url = request.url;
  if (url.includes("?")) {
    let custID = url.split("=")[1];
    deleteCust(custID, function (results) {
      // Calls back
    })
  }
  let html = "<link rel='stylesheet' href='home-style.css'><div class='login-form'>Customer successfully deleted.</div><input type='button' style='padding:15px 15px; margin:15px;' value='Go back!' onclick='history.back()'>";
  response.send(html);
  response.end();
});

/**
JOIN
**/

app.get('/join', function(request, response) {
  let html = "<link rel='stylesheet' href='home-style.css'><input type='button' style='padding:15px 15px; margin:15px;' value='Go back!' onclick='history.back()'><div class='login-form'><h1>Show all pets and owners</h1><form action='join-result' method='GET'><input type='text' name='species' placeholder='e.g. Dog, Cat, Turtle' ><input type='submit'></div>";
  response.send(html);
  response.end();
});

app.get('/join-result', function(request, response) {

  let url = request.url;

  if (url.includes("?")) {
    let species = url.split("=")[1];
    joinPetOwner(species, function (results) {
      let allResults = "<link rel='stylesheet' href='home-style.css'><input type='button' style='padding:15px 15px; margin:15px;' value='Go back!' onclick='history.back()'><div class='login-form'>";

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
      allResults += '</div></table>';

      send(response, allResults);
    })
  }
});

function send(response, allResults) {
  response.send(allResults);
  response.end();
}

// Query for join
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

    getOwnerBookingInAllBranches(function (results) {
      let allResults = "<link rel='stylesheet' href='home-style.css'><div class='login-form'><table><tr>";

      ownerResult = results;

      let ownerFields = ['custID', 'firstName', 'lastName'];

      for (i = 0; i < ownerFields.length; i++) {
        allResults += '<td>' + ownerFields[i] + '</td>';
      }
      allResults += '</tr>';

      for (i = 0; i < ownerResult.length; i++) { // looping over owners
        let tableResult = '<tr>';
        for (j = 0; j < ownerFields.length; j++) {
          tableResult += "<td>" + ownerResult[i][ownerFields[j]] + "</td>";
        }
        tableResult += "</tr>";
        allResults += tableResult;
      }
      allResults += '</table>';
      allResults += "</div><input type='button' style='padding:15px 15px; margin:15px;' value='Go back!' onclick='history.back()'>";
      send(response, allResults);
    })
});

// Query for division
function getOwnerBookingInAllBranches(callback) {
  let divisionQuery = "SELECT * FROM Owner WHERE NOT EXISTS (SELECT Branch.branchID FROM Branch WHERE NOT EXISTS ( SELECT Branch.branchID FROM Pet WHERE Pet.branchID = Branch.branchID AND Pet.ownerID = Owner.custID));";
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

/**
AGGREGATION WITH GROUP BY
**/
app.get('/aggregationGroup', function(request, response) {

    getAvgWeight(function (results) {
      let allResults = "<link rel='stylesheet' href='home-style.css'><div class='login-form'><table><tr>";


      weightResult = results;

      let weightFields = ['species', 'average weight (kg)'];


      for (i = 0; i < weightFields.length; i++) {
        allResults += '<td>' + weightFields[i] + '</td>';
      }
      allResults += '</tr>'

      for (i = 0; i < weightResult.length; i++) { // looping over owners
        let tableResult = '<tr>';
        for (j = 0; j < weightFields.length; j++) {
          if (j == 1) {
            tableResult += "<td>" + weightResult[i][weightFields[j]].toFixed(2) + "</td>";
          } else {
            tableResult += "<td>" + weightResult[i][weightFields[j]] + "</td>";
          }
        }
        tableResult += '</tr>';
        allResults += tableResult;
      }
      allResults += "</table></div><input type='button' style='padding:15px 15px; margin:15px;' value='Go back!' onclick='history.back()'>";
      send(response, allResults);
    })
});

// Query for aggregation with group by
function getAvgWeight(callback) {
  let aggregationGroupQuery = "SELECT species, AVG(weight) AS 'average weight (kg)' FROM Pet GROUP BY species;";
  connection.query(aggregationGroupQuery, [], function(error, results) {
    return callback(results);
  });
}

/**
AGGREGATION WITH HAVING
**/
app.get('/aggregationHaving', function(request, response) {

    getPetCountAnimalLovers(function (results) {
      let allResults = "<link rel='stylesheet' href='home-style.css'><div class='login-form'><table><tr>";

      ownerResult = results;

      let ownerFields = ['custID', 'number of pets'];

      for (i = 0; i < ownerFields.length; i++) {
        allResults += '<td>' + ownerFields[i] + '</td>';
      }
      allResults += '</tr>'


      for (i = 0; i < ownerResult.length; i++) { // looping over owners
        let tableResult = '<tr>';
        for (j = 0; j < ownerFields.length; j++) {
          tableResult += "<td>" + ownerResult[i][ownerFields[j]] + "</td>";
        }
        tableResult += '</tr>';
        allResults += tableResult;
      }
      allResults += "</table></div><input type='button' style='padding:15px 15px; margin:15px;' value='Go back!' onclick='history.back()'>";
      send(response, allResults);
    })
});

// Query for aggregation with having
function getPetCountAnimalLovers(callback) {
  let aggregationGroupQueryQuery = "SELECT Owner.custID, COUNT(*) AS 'number of pets' FROM Pet, Owner WHERE Pet.ownerID = Owner.custID GROUP BY Owner.custID HAVING COUNT(*) > 1;";
  connection.query(aggregationGroupQueryQuery, [], function(error, results) {
    return callback(results);
  });
}

/**
NESTED AGGREGATION
**/
app.get('/nestedAggregation', function(request, response) {

    getYoungest(function (results) {
      let allResults = "<link rel='stylesheet' href='home-style.css'><div class='login-form'><table><tr>";


      ownerResult = results;

      let ownerFields = ['species', 'minimum age'];

      for (i = 0; i < ownerFields.length; i++) {
        allResults += '<td>' + ownerFields[i] + '</td>';
      }
      allResults += '</tr>'


      for (i = 0; i < ownerResult.length; i++) { // looping over owners
        let tableResult = '<tr>';
        for (j = 0; j < ownerFields.length; j++) {
          tableResult += "<td>" + ownerResult[i][ownerFields[j]] + "</td>";
        }
        tableResult += '</tr>';
        allResults += tableResult;
      }
      allResults += "</table></div><input type='button' style='padding:15px 15px; margin:15px;' value='Go back!' onclick='history.back()'>";
      send(response, allResults);
    })
});

// Query for nested aggregation
function getYoungest(callback) {
  let nestedAggregationQuery = "SELECT Temp.species AS species, Temp.minage AS 'minimum age' FROM (SELECT P.species, MIN(P.age) AS minage FROM Pet P GROUP BY P.species) Temp WHERE Temp.minage = (SELECT MIN(minage) FROM (SELECT P.species, MIN(P.age) AS minage FROM Pet P GROUP BY P.species) Temp2);";
  connection.query(nestedAggregationQuery, [], function(error, results) {
    return callback(results);
  });
}

// Home page for customer
app.get('/cust-home', function(request, response) {
  if (request.session.loggedin) {
    var email = request.session.email;
    var results = request.session.results;
    let petResult = results;

    let allResults = "<link rel='stylesheet' href='home-style.css'><div class='login-form'>";

    allResults += 'Welcome back, ' + petResult[0]['firstName'] + '!';

    let petFields = ['age', 'species'];

    for (i = 0; i < petResult.length; i++) { // looping over pets
      let tableResult = '<table class="ownerView">';
      allResults += '<h1>' + petResult[i]['name'] + '</h1>';
      for (j = 0; j < petFields.length; j++) {
        tableResult += "<tr><td>" + petFields[j] + "</td><td>" + petResult[i][petFields[j]] + "</td></tr>";
      }
      tableResult += '</table>';
      allResults += tableResult;
    }
    allResults += "</div><input type='button' style='padding:15px 15px; margin:15px;' value='Go back!' onclick='history.back()'>"
    response.send(allResults);
  } else {
    response.send('Please login to view this page!');
  }
  response.end();
});

app.listen(3000);
