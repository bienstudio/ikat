$(".collections-trigger").on("click", (e) ->
  product = $(@).parent().parent().parent()
  product.addClass("active")

  list = $(@).parent().children('ul.collections')

  if list.hasClass("active")
    list.removeClass("active")
  else
    list.addClass("active")
)

$(".product").on "mouseenter", ->
  $(@).addClass "active"

# When the mouse leaves the product container, deactivate
$(".product").on "mouseleave", ->
  el = $(@)

  setTimeout (->
    el.closest('.product').removeClass("active")
    el.find('ul.collections').removeClass("active")
  ), 1
