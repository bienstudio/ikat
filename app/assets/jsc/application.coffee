//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$("span.collections").on "click", ->
  if $(@).hasClass("active")
    $(@).removeClass("active")
  else
    $(@).addClass("active")

$("span.collections").on "mouseleave", ->
  $(@).removeClass("active")
