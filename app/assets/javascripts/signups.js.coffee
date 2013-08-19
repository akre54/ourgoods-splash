# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#how-it-works, #lets-do-it").click -> $('.flip-container').toggleClass('flipped')

  updateColumn = (html) ->
    rightCol = $(html).find('.right-col')
    $('.right-col').replaceWith(rightCol)

  $('#new_signup').on 'ajax:success', (ev, data) -> updateColumn data
  $('#new_signup').on 'ajax:error', (ev, xhr) -> updateColumn xhr.responseText
