# Splash page for OurGoods events

## Adding events
`Event`s are ActiveRecord models. Anything in the future is considered "active"
and will be shown on the events signup page.

To create a new event, open rails console on Heroku:

```ruby
evt = Event.last.dup
# update any date / time / location / description info
evt.event_begin_time = DateTime.parse "April 20, 2014 7:15PM EDT"
evt.event_finish_time = DateTime.parse "April 20, 2014 7:15PM EDT"
evt.save
```
