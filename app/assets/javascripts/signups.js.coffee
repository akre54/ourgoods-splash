#= require modernizr/modernizr

$ ->
  # 3D Transforms
  return unless Modernizr.csstransforms3d

  # fix for absolute positioning giving no height. urgh.
  resizeColumn = -> $('.right-col').height $('.active').height()

  flipPage = ->
    $('.flip-container').toggleClass 'flipped'
    $('.front, .back').toggleClass 'active'
    resizeColumn()

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
    resizeColumn()

  resizeColumn()
