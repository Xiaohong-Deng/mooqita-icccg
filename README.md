# Iterative Crowdsourcing Comprehension Challenge Game

This is a Rails implementation of the ICCG game based on the paper [Paritosh, P., & Marcus, G. (2016). Toward a comprehension challenge, using crowdsourcing as a tool. AI Magazine, 37(1), 23-31.][0]


## Project Set Up

To ease up the start of the development process, you can use the the project's
virtual development environment based on Vagrant.

### First Run Usage

0- Install in your computer the software listed the requirements section.
1- Clone the repository into your machine.
2- Run `vagrant up` and wait for the machine to be built.
3- When the machine is ready, run `vagrant ssh` to log into it.
4- Move into the project directory with `cd /vagrant`.
5- Install the project gems with `bundle install`.
6- Build the database structure with `rails db:schema:load`.

Now check that everything works with `rails s` and opening http://localhost:3000
in your browser.

### Software Requirements

* [Vagrant][1]
* [Virtualbox][2] and the extension pack.


## Project Development

The [gitflow][3] style is used on this repo, so follow the next steps to work on
new features and fixes:

* If using the virtual development environment:
  - Start the project's box with 'vagrant up'.
  - Log into the box with `vagrant ssh`.
  - Move into the project directory with `cd /vagrant`.
* Create a new branch from the _development_ branch.
* Try to work on atomic commits related to the feature.
* Try to add TDD and/or BDD tests for your code.
* On finish, send a push request targeting the _development_ branch for review.


## Testing

This project relies on Rspec and Capybara. You can run the projects tests with
the `rake spec` command.

---
[0]: https://www.aaai.org/ojs/index.php/aimagazine/article/view/2649
[1]: https://www.vagrantup.com/downloads.html
[2]: https://www.virtualbox.org/wiki/Downloads
[3]: https://datasift.github.io/gitflow/IntroducingGitFlow.html
