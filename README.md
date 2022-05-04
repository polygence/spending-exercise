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
- The backend solution must be written in Django
  - We have written a brief description about how to start a project
  - But you can start however you like (e.g. using Docker or virtual environments)
- You can use the included database called SQLite so you don't need to set up a database

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

- Persist data in an SQL based database

## Getting Started

### Initialize the backend project

We have summarized the steps for you but you should follow [the official documentation][django-doc] that well describes
how to start working with Django.

- [Install the latest Python version][install-python]
- [Install Django][install-django]

  `$ python -m pip install Django`

- [Create a Django project][create-project]

  `$ django-admin startproject spendingexercise`

- [Start the application](start-application) and verify that it works

  `$ python manage.py runserver`

You should also install and use [the Django REST framework][drf-doc] since you are going to develop a RESTful API.

You should be ready to start working on the challenge now.

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

[django-doc]: https://docs.djangoproject.com/en/4.0/
[install-python]: https://docs.djangoproject.com/en/4.0/intro/install/#install-python
[install-django]: https://docs.djangoproject.com/en/4.0/topics/install/#installing-an-official-release-with-pip
[create-project]: https://docs.djangoproject.com/en/4.0/intro/tutorial01/#creating-a-project
[start-application]: https://docs.djangoproject.com/en/4.0/intro/tutorial01/#the-development-server
[drf-doc]: https://www.django-rest-framework.org/