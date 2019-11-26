# README

This project is from the microverse curriculum using The Odin Project
[https://www.theodinproject.com/courses/ruby-on-rails/lessons/final-project]
The goal is to create first full application facebook clone.


## Setup & Use
To run the project first clone the repo:

```
git clone https://github.com/dev1980/facebook-clone.git

```
Then cd to the project folder:
```
cd facebook-clone
```

Upadte gems from the Gemfile:
```
bundle update
```

Then migrate the database:
```
rails db:migrate
```
If there are any errors for the Gemfile, then please install as said in the error messages.

Navigate through the project tables from the console:
```
rails console
```
If wanted, seed the database.
```
rails db:seed
```

To run all the tests:
```
rails db:migrate RAILS_ENV=test
rails spec
```

## Requirements
Ruby version 2.6.x
Rails version 6.0.1
Bundler version 2.0.2

Authors: [Brham Dev Mahato](https://github.com/dev1980),  [Miguel Prada](https://github.com/mapra99)