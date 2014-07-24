//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready ->
  $("img").unveil()

$('.products').isotope
  itemSelector: ".product"
  masonry:
    columnWidth: 300
    gutter: 10
