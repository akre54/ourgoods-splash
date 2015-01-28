# Splash page for OurGoods events

## Adding events
`Event`s are ActiveRecord models. Anything in the future is considered "active"
and will be shown on the events signup page.

To create a new event, open rails console on Heroku:

```ruby
evt = Event.last.dup
# update any date / time / location / description info
evt.event_begin_time = Time.zone.parse "Jan 20, 2015 6:00PM"
evt.event_finish_time = Time.zone.parse "Jan 20, 2015 8:00PM"
# Update the venue and address, if needed
evt.venue = "Gibney Dance"
evt.address = "280 Broadway"
# If any notes about the event (such as for a specific group only)
evt.note = "For Brooklyn Art Council Grantees only"
# If the event has a cost associated, add a price
# evt.price = 10.00
# Finally, save
evt.save
```
