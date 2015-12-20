# ECE-NodeJs
This project was developed for the class Asynchronous Server Technologies. It consists in a simple dashboard app where users can login, insert and retrieve their personal metrics.

## Table of contents
* [Quick start](#quick-start)
* [Examples](#examples)
* [Documentation](#documentation)
* [Creators](#creators)
* [Copyright and license](#copyright-and-license)

## Quick start
To use the app locally, download github repository and install on personal machine. Verify that all dependencies to node-modules are met (package.json), install missing components.
* [Populate database](#populate-database)
* [Run the app](#run-the-app)
### Populate database
To have initial data in your database, run the following script:
```
coffee bin/populatedb
```
### Run the app
You can either:
1. Execute the start script
```
bin/start.sh
```
2. Using Node Js console, at root of project type in following command:
```
coffee src/app.coffee
```
### SASS daemon
A css file has already been generated from the .scss SASS file. However, if you want to enable the deamon, you can use the following in your console :
```
npm run watch-css
```
## Examples
* [Sign up](#sign-up)
* [Sign in](#sign-in)
* [Visualise metrics](#visualise-metrics)
* [Create metrics](#create-metrics)
* [Sign Out](#sign-out)
### Sign Up
To access the application, browse to app's url. Enter your credentials and account information to create a new user account.
### Sign In
If you possess an account to access Metrics Manager, you may log in using your credentials.
You'll then be redirected to your dashboard home page.
### Visualise personal metrics
Once logged in and on home page, click on button show metrics to display your metrics inside a graph as well as in a table. Keep in mind that a user can only access his metrics and none of other users.
### Create new metrics
Once logged in and on home page, click on button add metric to access the metrics creation form. Enter the details (timestamp + value) of the new metric that will be added to your batch.
### Sign Out
At any moment, you may sign out of your account to exit your dashboard and redirected to login page.

## Documentation
A number of different tehnologies were used on this project. Below are useful links that provide access to their documentation:

- [Node-JS](https://nodejs.org/en/) - Javascript runtime evnrionment for server side development
- [Coffee-script documentation](http://coffeescript.org/) - Language that compiles into Javascript, improves developer productivity
- [JQuery documentation](http://code.jquery.com) - JavaScript library
- [Jade documentation](http://jade-lang.com/) - Write clean HTML
- [Sass documentation](http://sass-lang.com/documentation/file.SASS_REFERENCE.html) - Write clean CSS
- [D3.JS documentation](http://d3js.org/) - Data Driven Documents, used for metrics' graphs
- [Bootstrap documentation](http://getbootstrap.com/) - Front-end web development framework
- [LevelDB documentation](https://github.com/google/leveldb) -LevelDB is a fast key-value storage library written at Google that provides an ordered mapping from string keys to string values. Used for Storage.

## Creators
**Nicolas Griere**
* nicolas.griere@edu.ece.fr

**Olivier Hamoud Le Guellec**
* olivier.hamoud-le-guellec@edu.ece.fr

## Copyright and license
Code Released under ISC license
