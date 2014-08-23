//= require jquery
//= require ../lib/vendor/jquery.dependent-selects.js

$(document).ready ->

  # Make a struct of empty values.
  data =
    authenticity_token: null
    product:
      name: null
      price: null
      currency: null
      url: null
      image_url: null
      category: null
    list: null

  # Chain the selects for the categories.
  $('.dependent').dependentSelects()

  # Create a new Pusher client and subscribe to the correct channel.
  pusher = new Pusher("#{gon.pusher_key}")
  channel = pusher.subscribe(gon.pusher_channel)

  image_count = 0

  # On recieving an image...
  channel.bind 'event', (data) ->

    # If it's an image, add the image
    if data.image
      # Add the image to the bookmarklet queue.
      add_image(data.image)

      # Add to the counter.
      image_count = image_count + 1

    # It's a finished message.
    else
      if image_count == 0
        $('.no-images').show()

    # Remove the loader, if it exists.
    $('.loader').remove()

  # On the click of an image...


  step = (num) ->
    if num == 1
      $('[data-step="0"]').hide() # make it so that every step but `num` is hidden
      $('[data-step="1"]').show() # make it so `num` is shown
      $('.directions').html('2. Fill in the product information')

  $('[data-finish]').on 'click', ->
    unless $(@).hasClass("disabled")
      $(@).html('Saving...')

      data.access_token = $('#access_token').val()
      data.product.name = $('#product_name').val()
      data.product.price = $('#product_price').val()
      data.product.currency = $('#product_currency').val()
      data.product.url = $('#product_url').val()
      data.product.category = $('[name="product[category]"').val()
      data.list = $(@).attr('data-list')
      data.authenticity_token = $('[name="authenticity_token"]').val()

      submit(data, $(@))

  submit = (params, list_button) ->
    $.ajax(
      url: '/api/v1/products/add.json',
      data: params,
      type: 'POST'
    ).done((data) ->
      $('.success').html("<a href='#{data.product.permalink}' target='_blank'>Go see this product on Ikat</a>")
      $('.success').show()

      list_button.removeClass('btn-red')
      list_button.addClass('btn-green')

      if list_button.html() == "Want"
        list_button.html('Wanted')
      else
        list_button.html("Added")

      list_button.addClass('disabled')

      return
    ).fail((data) ->
      console.log data

      $('.failure').show()

      list_button.html("Failed!")

      return
    )

  # Take a Pusher message, adds to the queue.
  add_image = (img) ->
    $('ul.images').append("<li><img src='#{img}' /></li>")

    $('img').on 'click', ->
      img = $(@)

      data.product.image_url = img.attr('src')

      $(".form figure img").attr("src", img.attr('src'))

      step(1)

  $("span.close").on "click", ->
    parent.closeBookmarklet()
