# Mical

A small Rails web application to keep track and share the activities you practice.

What can you do with mical?
- Use it as a log of activities for you and your friends.
- Attach pictures to help you remember the day.
- Log in to see activity details, save events, add activities or create more users.

You can see my own mical at http://mical.herokuapp.com/ as a demonstration.

## Installation

Check out the code and deploy in your server. Run bundler:
```bash
git clone git://github.com/dncrht/mical.git
cd mical
bundle
```

Don't forget to customize your database credentials in *config/database.yml*

To prevent nobody could tamper the session cookie, generate a new token with *rake secret* and:
- change the token in *config/initializers/secret_token.rb* and deploy
or
- set a secret_token in your environment as ENV['SECRET_TOKEN']. If you deploy in Heroku, the command is *heroku config:add SECRET_TOKEN=_output_of_rake_secret_*

Run migrations to create the database structure:
```bash
rake db:migrate
```

The application needs at least one admin user. Run the seeds to create this special user:
```bash
rake db:seed
```

Now you can login with user *admin@domain.tld* and password *admin*. Change the email or the password according to your needs.
But by any means, do not leave the default password if you run the application on a publicly accessible server.

## Usage

An *event* is an activity that took place a certain day, and it has a little description associated.
An *activity* is identified by a name and a color code.

As an anonymous guest (unprivileged user) you can browse through the years of the calendar.
If you want to add events, or read descriptions, you have to be a registered user.

Registered users have different permissions, split into two categories:
- Calendar permissions
  - Can add/edit/delete events: the user can add, modify and delete events
  - Can see a legend besides the calendar: the user can see a legend comprising all the activities and its color codes
  - Can see description hovering over a day: the user can see the events' description
  - Can download events as CSV: the user can download the current year events as a CSV file clicking on the link

- Administration permissions
  - Can manage activities on admin: the user can manage the activities list
  - Can manage users on admin: the user can create more users

Keep in mind that it must be at least one admin, but admin users can downgrade themselves.

### API

There's an API available to upload images programmatically. Example:

```bash
curl -X POST -F "event_id=ID" -F "image=@LOCAL_FILE_NAME" -u user:password http://mical.herokuapp.com/api/photos
```
