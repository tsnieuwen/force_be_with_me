# Force Be With Me

This API consumes an external Star Wars character API and exposes two sortable and filterable endpoints. The endpoints also return paginated results. This app is deployed to Heroku and was built using Ruby on Rails.

## Table of Contents

- [Author](#author)
- [Getting Started](#getting-started)
- [Running Test Suite](#running-tests-suite)
- [Endpoints](#endpoints)
- [Models and Schema](#models-and-schema)
- [Deployment](#deployment)
- [Built With](#built-with)
- [Versioning](#versioning)

## Author

- **Tommy Nieuwenhuis** -
  [Tommy's GitHub](https://github.com/tsnieuwen)
  [Tommy's LinkedIn](https://www.linkedin.com/in/thomasnieuwenhuis/)

## Getting Started


### Prerequisites
- To run this application locally you will need `Ruby 2.5.3` and Rails `6.1.3.2`

### Cloning and Setup

- If you wish to install this repo locally, please fork and clone the following repo:

    `git clone <git@github.com:<your github handle>/force_be_with_me.git>`

- Install the gem packages by running `bundle install`
- Create and seed the database by running `rails db{:create, :migrate, :seed}`

## Running Test Suite
- RSpec was utilized for testing this application and code coverage was confirmed using SimpleCov. Models, facades, services, and requests were all happy and sad path tested. If a sad path unit test is not present, it is because the user would be prevented from an invalid input due to model validations and controller flow.
- To see the tests, run `bundle exec rspec`

## Endpoints

### Get `https://force-be-with-me.herokuapp.com/api/v1/characters`
- This endpoints returns character records from the database. It is sorted as well as paginated. Default sorting is ascending alphabetically by character name, and default pagination is page 1, twenty records per page. More on that below:

#### Valid Query Parameters
- name
- taller_than
  - if an invalid entry (non-number), defaults to the minimum height in the character table
- shorter_than
  - if an invalid entry (non-number), defaults to the maximum height in the character table
- heavier_than
  - if an invalid entry (non-number), defaults to the minimum mass in the character table
- lighter_than
  - if an invalid entry (non-number), defaults to the maximum mass in the character table
- hair_color
- skin_color
- eye_color
- birth_year
- gender
- sort_by
 - if invalid entry (entry not a character attribute/column), defaults to `name`
- sort_order
  - if invalid entry (not `ASC` or `DESC`), defaults to `ASC`
- per_page
  - defaults to 20 records per page
- page
  - defaults to page 1
