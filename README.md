# Splash page for OurGoods events

## Adding events
`Event`s are ActiveRecord models. Anything in the future is considered "active"
and will be shown on the events signup page.

To create a new event, open rails console on Heroku:

```ruby
evt = Event.last.dup
# update any date / time / location / description info
evt.event_begin_time = DateTime.parse "February 22, 2014 4:30PM EST"
evt.event_finish_time = DateTime.parse "February 22, 2014 8:30PM EST"
evt.save
```