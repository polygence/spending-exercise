# Polygence Coding Challenge

Welcome to the coding challenge portion of the Polygence Engineering interview! Thank you for taking the time to go through this exercise and show us what you can contribute to the team.

## Project overview

![](app.png)

We want you to create a simple application to track spendings.

A spending has the followings properties:

- when it happened
- how much did we spend
- in what currency
- for what/description

This simple web app allows the users to:

- Create a new spending
- List all the spendings
- List all the spendings ordered by amount, date
- List all the spendings filtered by currency

A spending JSON object looks something like this:

```json
{
  "description": "Mango",
  "amount": 1200,
  "spent_at": "2022-02-23T14:47:20.381Z",
  "currency": "USD"
}
```

### Technical requirements

- Use Git and share the project on GitHub
- The backend solution can be written in any programming language
  - We have created a scaffolded Python/Flask and a Node.js/Express version
  - But you can start from scratch in any language
- No need for any SQL database to store data, you can store the data in memory

### Acceptance criteria

```cucumber
Given there are no existing spendings
When I fill the description, currency and amount
And I click the "Save" button
Then I see my spending in the list
And the spending is persisted on the server
And the form is emptied

Given that I have not filled the description or the amount
When I click the "Save" button
Then I see an error indicating the missing field

Given there are existing spendings in the list
When I change the selected ordering
Then the list is reorder by the selection

Given there are existing spendings in the list
When I click on a currency filter button (HUF, USD, All)
Then the list is filtered by that selection
And shows only the matching spendings
```

### What We Look For

This is an opportunity for you to show us what your best code looks like. While we expect the code to work, we are also looking for:

- Clean, modular code
- Clear naming and conventions
- Unit tests
- Error handling

If there are any pre-existing patterns in the code that you don't like, feel free to change them!

### Not required, but nice to have

- Use a web framework (eg. Django)
- Persist data in an SQL based database

## Getting Started

### Install Docker

Visit this [page](https://docs.docker.com/get-docker/) and follow the instructions.

This project is running on Ruby on Rails 7 with MySQL 5.7.

Run the Ruby on Rails application:

```shell
cd rails && docker-compose up --build -d
```

Stop the Ruby on Rails application:

```shell
cd rails && docker-compose down
```

Check the containers` status:

```shell
docker ps
```

You should see something like this:

|CONTAINER ID|IMAGE|COMMAND|CREATED|STATUS|PORTS|NAMES|
|---|---|---|---|---|---|---|
|d53626fafa9b|rails_app|"bash entrypoint.bas…"|11 seconds ago|Up 9 seconds|0.0.0.0:5000->5000/tcp|rails-app-1
|66b3f1272c01|mysql:5.7|"docker-entrypoint.s…"|11 seconds ago|Up 10 seconds|33060/tcp, 0.0.0.0:3307->3306/tcp|rails-db-1

Prepare database(you need to run this only once):

```shell
cd rails && docker-compose run app rails db:create db:migrate db:seed
```

Run tests:

```shell
cd rails && docker-compose run app bundle exec rspec
```

### Run the JS/React Web Client

This project is best run using **Node 14.17.x**.

Install client dependencies:

```shell
cd web && npm i
```

Run the client tests:

```shell
cd web && npm test
```

Run the client (http://localhost:3000):

```shell
cd web && npm start
```
