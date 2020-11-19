Pet Motel Application

Description
This full-stack web application is built for staff and customers of a Pet Motel. Here, we store data about the motel branches' occupancy and availability, and capture profiles of pets, owners, and staff carers.

The user journey starts with the user selecting if they are a `Staff` or `Customer` at the pet motel. They will then be prompted to log in, their credentials are validated against profiles we have in our database.

Upon signing in, customers will have the ability to view all their pets and their profiles. Staffs will have the option to add or remove a customer, edit an existing customer's profile, show all pets and owners, and check room inhabitants. We also added in special filtering functionalities so staff could pull up their most loyal customers (owners with a pet in every branch of the pet motel!), find the average weight of species, find the number of pets owned by pet lovers (number of pets owned by owners who have >1 pet), and find the youngest age of every species (we have to take good care of the little ones)!

Technologies Used
- Node.js for server-side development
- Express for HTTP requests
- HTML + CSS for front-end
- MySQL for database

Instructions
1. Clone this project with `git clone https://github.com/charmaine/PetMotel.git`
2. [Download and set up MySQL](https://dev.mysql.com/doc/mysql-osx-excerpt/5.7/en/osx-installation-pkg.html)
3. Create a blank database in the MySQL shell to serve as the destination for your data with `CREATE DATABASE motel;`
4. `cd` into this project folder (wherever your cloned the repo)
5. Run `mysql -u [username] -p motel < motel.sql` to import the database (`motel.sql` is included in this repo)
6. Run `npm install` to install Node dependencies
7. Replace `host`, `user`, and `password` in `app.js` with your MySQL database credentials
7. Run `node app.js` to start application
8. Your app will be running at `http://localhost:3000/` by default

Created By
- Karen Lau
- Charmaine Lee
- Abbi Yuniarto
