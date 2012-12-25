# Mical

A small Rails 3 web application to keep track and share the activities you practice.

What can you do with mical?
- Use it as a log of activities for you and your friends.
- Log in to see activity details, save events, add activities or create more users.

You can see my own mical at http://mical.herokuapp.com/ as a demonstration.

## Installation

Check out the code and deploy in your server. Run bundler, it needs Rails 3.2.6

Don't forget to customize your database credentials in *config/database.yml*

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

As an anonymous guest, unprivileged user, you can browse through the years of the calendar.
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
