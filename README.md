[![TravisCI](https://img.shields.io/travis/Xiaohong-Deng/mooqita-icccg/master.svg?label=travis-ci)](https://travis-ci.org/Xiaohong-Deng/mooqita-icccg)
[![Maintainability](https://api.codeclimate.com/v1/badges/98c92695841525444efa/maintainability)](https://codeclimate.com/github/Xiaohong-Deng/mooqita-icccg/maintainability)
<a href="https://codeclimate.com/github/Xiaohong-Deng/mooqita-icccg/test_coverage"><img src="https://api.codeclimate.com/v1/badges/98c92695841525444efa/test_coverage" /></a>

# Iterative Crowdsourcing Comprehension Challenge Game

This is a Rails implementation of the ICCG game based on the paper [Paritosh, P., & Marcus, G. (2016). Toward a comprehension challenge, using crowdsourcing as a tool. AI Magazine, 37(1), 23-31.][0]


## Project Set Up with Physical Machine (Recommended)
Note the ruby and node.js versions in this project are locked to 2.4.1 and 6.12.1. If you choose to use `gemset` with `rvm` or `rbenv` the gemset name is locked to **iccg**. You are welcomed to try the versions you want at your own risk.

### Set Up Rails Environment

If you haven't already, please set up your Ruby on Rails development environment. Here is a good reference link [https://gorails.com/setup/ubuntu/16.04](https://gorails.com/setup/ubuntu/16.04)

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
```

If you install ruby gems inside the project directory you might want to skip the folder such that `simplecov` does not generate a large report file. What you need to do is add `add_filter "FOLDER_OR_FILE_TO_IGNORE"` to the block in `./.simplecov`. We have already done it for you if you choose `vendor` as the gem install directory.
 
### Run Project Locally in Development Environment

```
bundle exec rails s
```

then go to `localhost:3000` in your web browser.
 
## Project Set Up with Virtual Machine

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

This project relies on Rspec, Cucumber and Capybara. Javascript unit testing has not been provided yet.

---
[0]: https://www.aaai.org/ojs/index.php/aimagazine/article/view/2649
[1]: https://www.vagrantup.com/downloads.html
[2]: https://www.virtualbox.org/wiki/Downloads
