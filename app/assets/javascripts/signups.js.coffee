#= require modernizr/modernizr

$ ->
  return unless Modernizr.csstransforms3d

  # fix for absolute positioning giving no height. urgh.
  resizeColumn = -> $('.right-col').height Math.max $('.front').height(), $('.back').height()

  $(document).on 'click', "#how-it-works, #lets-do-it", ->
    $('.flip-container').toggleClass('flipped')
    resizeColumn()

  $(document).on 'click', 'button.close', ->
    $this = $(this)
    $parent = if $this.hasClass('alert') then $this else $this.parent()
    $parent.remove()
    resizeColumn()

  $(document).on 'ajax:complete', '#new_signup', (ev, xhr) ->
    rightCol = $(xhr.responseText).find('.right-col')
    $('.right-col').replaceWith(rightCol)
    resizeColumn()

  resizeColumn()