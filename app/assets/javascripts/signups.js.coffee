#= require modernizr/modernizr
#= require ./utils

$ ->
  # 3D Transforms
  return unless Modernizr.csstransforms3d

  # fix for absolute positioning giving no height. urgh.
  resizeColumn = ->
    $('.right-col').height $('.right-col h1').height() + $('.active').height()


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

  $(document).on 'ajax:complete', '#new_signup, .edit_signup', (ev, xhr) ->
    rightCol = $(xhr.responseText).find '.right-col'
    $('.right-col').replaceWith rightCol
    updateShownEvent()
    resizeColumn()

  $(window).on 'resize', utils.debounce resizeColumn, 200

  updateShownEvent()
  resizeColumn()


  handler = StripeCheckout.configure
    key: window.OG.stripe_key
    image: '/assets/ourgoods_logo.png'
    token: (token) ->
      # Use the token to create the charge with a server-side script.
      # You can access the token ID with `token.id`

      updateShownEvent()

      $('#signup_stripe_token').val token.id

      $('.edit_signup').submit()

  $(document).on 'click', '.open-payment', (e) ->
    eventPrice = +$('#signup_event_price').val()

    # Open Checkout with further options
    handler.open
      name: "OurGoods Idea Lab"
      email: $("#signup_email").val()
      description: "1 ticket ($#{eventPrice.toFixed(2)})"
      amount: eventPrice * 100

    e.preventDefault()

  # Close Checkout on page navigation
  $(window).on 'popstate', ->
    handler.close()
