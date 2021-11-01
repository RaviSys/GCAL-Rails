# Google Calendar Integration With Rails 6

## Introduction

This is a demo application where you can find the Google Calendar integrated with Rails 6 application. You will see how to create events in a rails app and send it to your google calendar. 

You will also find that how to allow users to signin using google in your rails application. 

You will find following items in this demo rails application:

* Bootstrap 4.3, JQuery, Popper.js integrated using webpacker
* Devise implemented where user can signin in using their gmail accounts
* Google Calendar API for integrating with rails

## Development Setup

Prerequisites:

- PostgreSQL
- Bundler
- Node(>= 11.x)
- Yarn
- Ruby(2.7.2)
- Rails(>=6)

```sh
bundle install
yarn install
```
Now you need to setup the database. And you need to run following commands but before running them you need to change the values of username and password of your pg inside 
```sh
config/database.yml
```
Once changed, run following commands:

```sh
rails db:create
rails data:migrate
```

Now you are all set. Run following command on your terminal:

```sh
rails server 
```
To render css and js assets faster open another tab and run following command:

```sh
./bin/webpack-dev-server
```

open browser at: [http://localhost:3000](http://localhost:3000).

For more helpful and time saving work samples visit us at: [https://ai-academy.herokuapp.com](https://ai-academy.herokuapp.com/).
