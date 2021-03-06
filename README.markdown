# Diversion

Divert your ActionMailer messages to a specified email address without having
to change your delivery method.

## WHY?

When testing an application it is desirable that your configured application
environment be as close as possible to one used in production. This plugin
allows minimal modification to the environment, while allowing testing that
doesn't deliver undesired emails.

## Example

    # in config/initializers/action_mailer.rb
    # Divert emails to a common mailbox
    ActionMailer::Base.divert_to = "diverted@example.com" if ENV['RAILS_ENV'] == 'development'
    ...

## Installation

    $ script/plugin install git://github.com/sbfaulkner/diversion.git

## TODO

- tests!

## Legal

**Author:** S. Brent Faulkner <brentf@unwwwired.net>  
**License:** Copyright &copy; 2008-2009 unwwwired.net, released under the MIT license
