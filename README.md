# README

## Overview

This project is a web-based, volunteer engagement, crowd-sourcing platform for the non-profit We The Protesters. That's a lot of buzz words! Think of it as Amazon's Mechanical Turk, but for fulfilling the mission of Black Lives Matter (how about a couple more buzz words?).

Users can view a list of Tasks that are relevant to their location, relevant to their skills, and relevant to pushing the movement forward.

### Projects

Projects are the heart of a question and response type. The first Project we had was called "Use of Force Policy". It's a Project to collect the Use of Force policies from the 100 largest cities in America. Projects cannot be created by non-engineers. A class inside `app/models/projects` must be created by an engineer. A corresponding Response class must also be created in `app/models/responses`. Corresponding views ought to be created in the `views` directory as well. Look at the Use of Force Policy Project for an example. The base Project and Response classes take care of rigging things up fairly automagically.

### Cities

Non-engineers do have control over City creation. If you're logged in as an admin, you should be able to view existing Cities, and create new ones.

### Domains

Domains are critical. You cannot have user-facing Tasks without a Domain. This is another model that can be managed by non-engineers. If you're logged in as an admin, you should see "Domains" available in the navbar.

Domains express the intersection of Projects and Cities. They answer the question, "For which cities do I want an answer to this project?".

Common Domains, like the "100 Largest Cities by Population" should already exist. If the domain you're interested in already exists, it's just a matter of applying it to the appropriate Project. Note that a Project _can_ have multiple domains.

If a Domain doesn't exist yet, you can create it in admin. All you'll have to do is add the Cities to that Domain by checking the checkboxes.

### Tasks

Tasks are managed entirely by the application. For all the Cities in all the Domains associated with a Project, a Task will be created automatically by the system. A Task represents something that can be responded to.

### Responses

Every Response is associated with a Task and a User. Some Projects specify that they require multiple answers per Task. Note that this "multiple answer" feature is the primary reason answers are stored as Responses and not directly on the Task.

## Tooling

This project is a fairly vanilla Ruby on Rails project. If you're not familiar with Ruby on Rails, we recommend reading one of the excellent introductory books.

If you are familiar with Ruby on Rails, we suggest looking at `config/routes.rb` for an overview of the non-standard way in which we're interacting with our Resources.

We're currently running:

 - Ruby 2.3.1
 - Rails 5.0.0
 - Postgres
 
Layouts and styling tooling includes:

 - Bootstrap
 - Sass
 - Haml (terser templating language)
 - SimpleForm

Authentication is handled through:

 - Devise

One of the most important gems we're using handles geocoding and location-based database queries:

- Geokit

Our testing tools include:

 - RSpec
 - FactoryGirl

## Deployment

Please talk to a project administrator to learn more about deployments. Short story is that we're running on Heroku.

## Contributing

We're building a crowd-sourcing platform to effect meaningful change in our communities. Obviously we're doing it with open-source software. We need your help!

If you'd like to contribute, please assign yourself to an Issue, create a branch, and then submit a pull request.
