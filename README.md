# Address Book
Use Rails 5 API to create an address book RESTful API

## Description
This project is a test for [STRV](https://www.strv.com/). It consist in developing an Address Book API using a database to store users and organizations and use [Firebase](https://firebase.com) to store contacts.  
This project was made using Rails 5.0.2 API, with PostgreSQL database.

The AddressBook app consists of three parts - creating organization, registering it’s users and managing organization’s contacts.  
To create an organization, you will need to login as an admin user (see [db/seeds.rb](db/seeds.rb) file for admin credentials).  
To manage contacts, you will need to register/login as a user under an organization.

### Hosting  
This project is hosted on Heroku, on https://murmuring-everglades-81257.herokuapp.com/ web address.

### Login/Authorization Examples
Below are some cURL examples to login and to use the token with the api:

To log in user, you can use:
```
curl -H "Content-Type: application/json" -X POST -d '{"email":"admin@address_book.info","password":"PaSSw0rD!!1!!"}' https://murmuring-everglades-81257.herokuapp.com/users/login
```

This should return an `auth_token`. This token must be passed as header to the API, as you can see in the example below:
```
curl -H "Content-Type: application/json" -H "Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0OTI4MDE3MzB9.-txQ4rGYbT5sh_zyzJmcP8Hrj9VzPfQ5urj35pYF5XU" https://murmuring-everglades-81257.herokuapp.com/organizations
```

### Documentation
This API was documented using [apipie-rails](https://github.com/Apipie/apipie-rails) gem.  
You can find the documentation for this API methods in https://murmuring-everglades-81257.herokuapp.com/docs
