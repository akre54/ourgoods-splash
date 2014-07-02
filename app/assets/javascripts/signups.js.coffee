#= require modernizr/modernizr

$ ->
  # 3D Transforms
  return unless Modernizr.csstransforms3d

  # fix for absolute positioning giving no height. urgh.
  resizeColumn = ->
    $('.right-col').height $('.right-col header').height() + $('.active').height()

  debounce = (func, wait) ->
    timeout = timestamp = null

    later = ->
      last = new Date() - timestamp;
      if last < wait
        timeout = setTimeout later, wait - last
      else
        timeout = null
        func()

  updateShownEvent = ->
    idx = $('[name="signup[event_id]"]:checked').parent().index()
    $('.venue-address').hide()
    $('.venue-address').eq(idx).show()

  flipPage = ->
    $('.flip-container').toggleClass 'flipped'
    $('.front, .back').toggleClass 'active'
    resizeColumn()

  $('[name="signup[event_id]"]').parent().on 'click', updateShownEvent

  $(document).on 'keydown', (e) ->
    return unless e.which is 13
    return unless $('.front.active').length
    flipPage()
    false

  $(document).on 'click', '.page-toggle', flipPage

  $(document).on 'click', 'button.close', ->
    $this = $(this)
    $parent = if $this.hasClass('alert') then $this else $this.parent()
    $parent.remove()
    resizeColumn()

  $(document).on 'ajax:complete', '#new_signup', (ev, xhr) ->
    rightCol = $(xhr.responseText).find '.right-col'
    $('.right-col').replaceWith rightCol
    updateShownEvent()
    resizeColumn()

  $(window).on 'resize', debounce resizeColumn, 200

  updateShownEvent()
  resizeColumn()
