# Iterative Crowdsourcing Comprehension Challenge Game

[![TravisCI](https://img.shields.io/travis/Xiaohong-Deng/mooqita-icccg/master.svg?label=travis-ci)][3]
[![Maintainability](https://api.codeclimate.com/v1/badges/98c92695841525444efa/maintainability)][4]
[![Test Coverage](https://api.codeclimate.com/v1/badges/98c92695841525444efa/test_coverage)][5]
[![Waffle.io - Columns and their card count](https://badge.waffle.io/Xiaohong-Deng/mooqita-icccg.svg?columns=all)][6]

This is a Rails implementation of the ICCG game based on the paper [Paritosh, P., & Marcus, G. (2016). Toward a comprehension challenge, using crowdsourcing as a tool. AI Magazine, 37(1), 23-31.][0]


## Project Setup with Physical Machine (Recommended)
Note the ruby and node.js versions in this project are locked to 2.4.1 and 8.10.0. If you choose to use `gemset` with `rvm` or `rbenv` the gemset name is locked to **iccg**. You are welcomed to try the versions you want at your own risk.

### Set Up Rails Environment

If you haven't already, please set up your Ruby on Rails development environment. Here is a good reference link [Setup Ruby on Rails][7]

Note to install `postgresql`. This is the database this project uses in development and production environment.

### Install Gems

To avoid polluting your default gemset you can either `bundle install --path vendor` or use `gemset` functionality that `rvm` or `rbenv` provides. Add `vendor/ruby` to `.gitignore` if you choose the former. You can choose other directories inside your project root path to install required gems if you like.

### Set Up Database

```
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:seed
```
If gems are installed to system default path `bundle exec` can be omitted.

### Install Redis, Yarn and Javascript Dependencies

```
brew install redis
brew install yarn
bundle exec rails yarn:install
```

For Mac user remember `brew services start redis`

If `rails yarn:install` complains about node version, one way is to do the following

```
brew install nvm
nvm install VERSION_NUMBER
```
nvm is node.js version manager that allows you to install multiple versions of node.js

### Run Tests

```
bundle exec rspec
bundle exec cucumber
bundle exec teaspoon
```

If you install ruby gems inside the project directory you might want to skip the folder such that `simplecov` does not generate a large report file. You need to add `add_filter "FOLDER_OR_FILE_TO_IGNORE"` to the block in `./.simplecov`. We have done it for you if you choose `vendor` as the gem install directory.
 
### Run Project Locally in Development Environment

```
bundle exec rails s
```

then go to `localhost:3000` in your web browser.
 
## Project Setup with Virtual Machine

To ease up the start of the development process, you can use the the project's virtual development environment based on Vagrant.

### First Run Usage

0. Install in your computer the software listed the requirements section.
1. Clone the repository into your machine.
2. Run `vagrant up` and wait for the machine to be built.
3. When the machine is ready, run `vagrant ssh` to log into it.
4. Move into the project directory with `cd /vagrant`.
5. Install the project gems with `bundle install`.
6. Install the required Node modules with `rake yarn:install`.
7. Build the database structure with `rails db:schema:load`.
8. Load seed data with `rails db:seed`.

Now check that everything works with `rails s` and opening http://localhost:3000 in your browser.

### Software Requirements

* [Vagrant][1]
* [Virtualbox][2] and the extension pack.


## Project Development

The _trunk development_ style is used on this repo, so follow the next steps to
work on new features and fixes:

* If using the virtual development environment:
  - Start the project's box with 'vagrant up'.
  - Log into the box with `vagrant ssh`.
  - Move into the project directory with `cd /vagrant`.
* Ensure dependencies are up to date:
  - `bundle install`
  - `rake yarn:install`
* Run pending migrations and load seed data:
  - `rails db:migrate`
  - `rails db:seed`
* Create a new branch from the **master** branch.
* Try to work on atomic commits related to the feature.
* Try to add TDD and/or BDD tests for your code.
* On finish, send a push request targeting the **master** branch for review.

## Testing

This project relies on RSpec, Cucumber, Jasmine and Capybara.

### Test Coverage Report
[Teaspoon][9] is a JavaScript test runner with various perks. It can generate javascript coverage report. [SimpleCov][10] generates ruby coverage report automatically after running RSpec and Cucumber. Generated reports go into `./coverage`

## Deployment

### Manually Deploy to Heroku
First set up Heroku account and [Heroku CLI][8]. Then in terminal, login, add SSH keys, and create your app.
```
heroku login
heroku keys:add
heroku create PROJECT_NAME
heroku addons:add redistogo
```
Before pushing to heroku, set up your consumer configuration. First run `heroku config:set RAILS_HOST=YOUR_APP_URL`. In `./config/environments/production.rb` do the following
```ruby
config.action_cable.url = "wss://#{ENV['RAILS_HOST']}/cable"
config.web_socket_server_url = "wss://#{ENV['RAILS_HOST']}/cable"
config.action_cable.allowed_request_origins = [
'127.0.0.1',
/(http|https):\/\/#{ENV['RAILS_HOST']}.*/
]
```
Then push to heroku and initialize the database.
```
git push heroku master
heroku run rails db:migrate
heroku run rails db:seed
```
Try to visit `PROJECT_NAME.herokuapp.com` to see if everything works.
### Automatic Deployment through CI Services
Please refer to the documentation from the service provider of your choice.

---
[0]: https://www.aaai.org/ojs/index.php/aimagazine/article/view/2649
[1]: https://www.vagrantup.com/downloads.html
[2]: https://www.virtualbox.org/wiki/Downloads
[3]: https://travis-ci.org/Xiaohong-Deng/mooqita-icccg
[4]: https://codeclimate.com/github/Xiaohong-Deng/mooqita-icccg/maintainability
[5]: https://codeclimate.com/github/Xiaohong-Deng/mooqita-icccg/test_coverage
[6]: https://waffle.io/Xiaohong-Deng/mooqita-icccg
[7]: https://gorails.com/setup/ubuntu/16.04
[8]: https://devcenter.heroku.com/articles/heroku-cli
[9]: https://github.com/jejacks0n/teaspoon
[10]: https://github.com/colszowka/simplecov
