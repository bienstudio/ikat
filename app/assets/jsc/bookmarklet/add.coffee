//= require jquery
//= require ../lib/vendor/jquery.dependent-selects.js

$(document).ready ->
  $('.dependent').dependentSelects()

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

$('ul.images li').on 'click', ->
  selected = $(@)

  img = $(selected.children('img')[0])

  data.product.image_url = img.attr('src')

  $(".form figure img").attr("src", img.attr('src'))

  step(1)

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

    submit(data)

submit = (params) ->
  $.ajax(
    url: '/api/v1/products/add.json',
    data: params,
    type: 'POST'
  ).done((data) ->
    $('.success').html("<a href='#{data.product.permalink}' target='_blank'>Go see this product on Ikat</a>")
    $('.success').show()

    $('[data-finish]').removeClass('btn-red')
    $('[data-finish]').addClass('btn-green')
    $('[data-finish]').html('Wanted')

    $('a.btn').addClass('disabled')

    return
  ).fail((data) ->
    console.log data

    $('.failure').show()

    return
  )
