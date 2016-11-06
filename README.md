## TartanTalk

This chat application allows users to chat anonymously or through an account with a professional or peer counselor representing CMU's Counseling and Psychological Services (CaPS).

The application has been developed for the Fall 2016 instance of 67-475: Innovation in Information Systems by Team #12. 

Initial Scaffolding, Chatroom Setup, Database Setup, and Action Cables Configuration taken from: 
https://blog.heroku.com/real_time_rails_implementing_websockets_in_rails_5_with_action_cable
 
Files modified link to the above source with the prefix "Adapted from" while those untouched from the source are prefixed with "Source.

### Running Locally

You'll need:

* Ruby 2.3.0
* Postgres
* Redis

Then, once you clone down this repo:

* `bundle install`
* `rake db:create; rake db:migrate`

And you're all set.


