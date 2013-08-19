# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#how-it-works, #lets-do-it").click -> $('.flip-container').toggleClass('flipped')