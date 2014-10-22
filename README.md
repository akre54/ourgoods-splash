# Splash page for OurGoods events

## Adding events
`Event`s are ActiveRecord models. Anything in the future is considered "active"
and will be shown on the events signup page.

To create a new event, open rails console on Heroku:

```ruby
evt = Event.last.dup
# update any date / time / location / description info
evt.event_begin_time = Time.zone.parse "Dec 17, 2014 7:00PM"
evt.event_finish_time = Time.zone.parse "Dec 17, 2014 9:00PM"
# Update the venue and address, if needed
evt.venue = "Brooklyn Arts Council"
evt.address = "55 Washington Street"
# If any notes about the event (such as for a specific group only)
evt.note = "For Brooklyn Arts Council grantees only."
evt.save
```
