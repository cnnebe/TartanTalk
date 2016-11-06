// Source: https://blog.heroku.com/real_time_rails_implementing_websockets_in_rails_5_with_action_cable 
//= require cable
//= require_self
//= require_tree .

this.App = {};

App.cable = ActionCable.createConsumer("/cable");  