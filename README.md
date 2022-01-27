# Blind Barber API

This ruby on rails app serves as the API integration into the Blind Barber iOS app.

## Requirements

- ruby 3.1.0p0
- Rails 7.0.1
- bundler 2.3.3
- postgres

## Quick Start

1. Create Postgres Database `rake db:create`

2. Migrate to the latest `rake db:migrate`

3. Start the rails server `rails s`

## Development Setup

1. Install and update `homebrew`.

   ```bash
   ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
   brew update
   ```

   [Check this](https://gist.github.com/myobie/1860902) if you're running Mountain Lion.

2. Install `ruby` using [rbenv](https://github.com/sstephenson/rbenv), [rvm](https://rvm.io/), or your preferred method to install Ruby 2.5.

3. Install `postgres`.

   ```bash
   brew install postgresql
   ```

   Tuning can result in big performance benefits, especially when loading new copies of production data. Here is [a short guide](http://big-elephants.com/2012-12/tuning-postgres-on-macos/) to consider using for optimizing your configuration.

   If you'd like `postgres` to run at startup, see the details in `brew info postgres`.

4. Install application dependencies.

   ```bash
   gem install bundler
   bundle install
   ```

5. Once everything is set up you can start your server with `rails server`, or simply `rails s`. See the next section for available options for your local server.
