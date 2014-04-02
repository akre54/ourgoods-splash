#= require modernizr/modernizr

$ ->
  setupRadioButtons = ->
    $('.event-info').hide()
    setActive = (info) -> $('.active-event').children().first().replaceWith(info.show())
    findActive = (target) -> target.parent().next('.event-info').clone()

    setActive findActive $('input[type="radio"]:checked')
    $('input[type="radio"]').on 'click', (e) ->
      setActive findActive $(e.target)

  setupRadioButtons()

  # 3D Transforms
  return unless Modernizr.csstransforms3d

  # fix for absolute positioning giving no height. urgh.
  resizeColumn = -> $('.right-col').height $('.active').height()

  $(document).on 'click', "#how-it-works, #lets-do-it", ->
    $('.flip-container').toggleClass('flipped')
    $('.front, .back').toggleClass('active')
    resizeColumn()

  $(document).on 'click', 'button.close', ->
    $this = $(this)
    $parent = if $this.hasClass('alert') then $this else $this.parent()
    $parent.remove()
    resizeColumn()

  $(document).on 'ajax:complete', '#new_signup', (ev, xhr) ->
    rightCol = $(xhr.responseText).find('.right-col')
    $('.right-col').replaceWith(rightCol)
    setupRadioButtons()
    resizeColumn()

  resizeColumn()