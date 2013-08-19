# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

  if Modernizr.transform
    $('#how-it-works').remove()
    $('.front, .back').css('position', 'relative')

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


  # fix for absolute positioning giving no height. urgh.
  resizeColumn = -> $('.right-col').height($('.front').height())

  resizeColumn()