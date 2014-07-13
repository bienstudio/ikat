//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

# When the dropdown is triggered, add active to both the dropdown menu and the product container
$("span.collections-trigger").on("click", (e) ->
  product = $(@).parent().parent().parent()
  product.addClass("active")

  list = $(@).parent().children().last()

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

# $(".product ul").on "click", ->
#   $(@).parent().off("mouseleave")
#   $(@).closest("span.contributors").off("mouseleave")

# $(".product ul").on "click", ->
#   $(@).closest("span.collections").mouseenter()

# $(".product input[type='checkbox']").on 'click', ->
#   console.log $(@).closest(".product")
#   console.log $(@).closest("span.collections")
#
#   $(@).closest(".product").addClass("active")
#   $(@).closest('span.collections').addClass("active")
