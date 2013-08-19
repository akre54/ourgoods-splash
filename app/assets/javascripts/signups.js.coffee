#= require modernizr/modernizr

$ ->

  unless Modernizr.csstransforms3d
    $('#how-it-works, #lets-do-it').remove()
    $('.front, .back').css('position', 'relative')
    return

  # fix for absolute positioning giving no height. urgh.
  resizeColumn = -> $('.right-col').height $('.front').height()

  $(document).on 'click', "#how-it-works, #lets-do-it", -> $('.flip-container').toggleClass('flipped')

  $(document).on 'click', 'button.close', ->
    $this = $(this)
    $parent = if $this.hasClass('alert') then $this else $this.parent()
    $parent.remove()
    resizeColumn()

  updateColumn = (html) ->
    rightCol = $(html).find('.right-col')
    $('.right-col').replaceWith(rightCol)
    resizeColumn()

  $('#new_signup').on 'ajax:success', (ev, data) -> updateColumn data
  $('#new_signup').on 'ajax:error', (ev, xhr) -> updateColumn xhr.responseText

  resizeColumn()