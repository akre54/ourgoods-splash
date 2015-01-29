utils = window.utils = {}

utils.debounce = (func, wait) ->
  timeout = timestamp = null
  ->
    timestamp = new Date()
    later = ->
      last = new Date() - timestamp;
      if last < wait
        timeout = setTimeout later, wait - last
      else
        timeout = null
        func()
    timeout = setTimeout later, wait