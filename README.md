# README

* Try rails gem
  * https://github.com/heartcombo/simple_form
  * https://github.com/collectiveidea/delayed_job_active_record
  * https://github.com/collectiveidea/delayed_job

## Things you may want to cover:

* Ruby version
  * 2.6.0

* Rails version
  * 6.0.2.1

* Gems - useful for dev
  * gem 'pry-rails', :group => :development
  * gem 'bullet', group: 'development'

* Gems - tried this time
  * gem 'simple_form'
  * gem 'delayed_job_active_record'
  * gem "daemons"

* jQuery
  * yarn add jquery
    * test_rails_delayedjob_mailer_simpleform/app/javascript/packs/application.js

      ```bash
      import "jquery/src/jquery"
      ...
      ```

* bootstrap
  * yarn add bootstrap popper.js (don't add popper v2, bootstrap default requires v1.16) , (no need to import popper.js manually, bootstrap will do it automatically)
    * app/javascript/packs/application.js
    * app/assets/stylesheets/application.css

## Rails setup

* generate Book
  * `bin/rails g scaffold Book name:string author:string`

* delayed jobs
  * `rails g delayed_job:active_record`
  * `rake db:migrate`
  * `config/application.rb`

    ```
    config.active_job.queue_adapter = :delayed_job
    ```

## Delayed_Job

### To run jobs by daemon

* Gem for delayed_job daemon

  ```
  gem "daemons"
  ```

* Start delayed_job daemon
  * Ref. https://github.com/collectiveidea/delayed_job/blob/master/lib/delayed/worker.rb
  * Ref. https://github.com/collectiveidea/delayed_job#running-jobs

    ```
    RAILS_ENV=production script/delayed_job start
    ```

* Difference between daemons' command
  * rails jobs:work == bin/delayed_job start
  * rails jobs:work
    * just like `rails server` running at foreground
    * stop by command `CTRL + c`
  * bin/delayed_job start
    * just like puma daemon (gem "daemon"), running at background
    * stop by command `bin/delayed_job stop`

## Simple Form - works with bootstrap

* After bundle install simple_form, do the following command 

  ```
  $ bin/rails generate simple_form:install --bootstrap
  [Simple Form] Simple Form is not configured in the application and will use the default values. Use `rails generate simple_form:install` to generate the Simple Form configuration.
  Running via Spring preloader in process 10079
        create  config/initializers/simple_form.rb
        create  config/initializers/simple_form_bootstrap.rb
         exist  config/locales
        create  config/locales/simple_form.en.yml
        create  lib/templates/erb/scaffold/_form.html.erb
  ===============================================================================
    Be sure to have a copy of the Bootstrap stylesheet available on your
    application, you can get it on http://getbootstrap.com/.
    For usage examples and documentation, see:
      http://simple-form-bootstrap.plataformatec.com.br/
  ===============================================================================
  ```

## Action-mailer works with action-job (using delayed_job as backend)

### config - mailer (from / to) , credential

* command
  * `EDITOR=vim bundle exec rails credentials:edit`

    ```
    development:
      db:
        user: user
        pass: pass
      email:
        from: from@gmail.com
        to: to@gmail.com
      host: dev.localhost.localdomain

    production:
      db:
        user: user
        pass: pass
      email:
        from: from@gmail.com
        to: to@gmail.com
      host: prod.localhost.localdomain

    ```

* config
  * `book_mailer.rb`

    ```
    default from: <%= "#{Rails.application.credentials[Rails.env.to_sym][:email][:from]}" %>
    ```

  * `config/application.rb`

    ```
    config.action_mailer.default_url_options = { host: "#{Rails.application.credentials[Rails.env.to_sym][:host]}" }
    ```

## Changes - simple_form & action-mailer with action-job & delayed_job

* https://github.com/charlietag/test_rails_delayedjob_mailer_simpleform/compare/v0.0.0...master

## Try rails custom rake task

* Reference
  * https://guides.rubyonrails.org/command_line.html#custom-rake-tasks

* Generate task

  ```
  $ bin/rails g task ShowMyName display
  Running via Spring preloader in process 26702
        create  lib/tasks/show_my_name.rake
  ```

* Edit task
  * `lib/tasks/show_my_name.rake`

    ```
    namespace :show_my_name do
      desc "Display hostname"
      task display: :environment do
        puts "URL for action mailer: " + Rails.application.config.action_mailer.default_url_options[:host]
        puts "HOSTNAME: "+ %x{hostname}
      end
    end
    ```

* Execute task
  * `RAILS_ENV=production bin/rails show_my_name:display`

    ```
    $ RAILS_ENV=production bl show_my_name:display
    URL for action mailer: prod.localhost.localdomain
    HOSTNAME: dev.localhost.localdomain
    ```

## Changes - rake tasks
  * https://github.com/charlietag/test_rails_delayedjob_mailer_simpleform/commit/ea42ff419defd780f896033d9f5428a21a0ac907

