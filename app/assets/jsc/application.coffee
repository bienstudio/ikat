//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require_tree ./lib
//= require turbolinks

ready = ->
  $("img").unveil()

  # $('.products').isotope
  #   itemSelector: ".product"
  #   masonry:
  #     columnWidth: 209
  #     gutter: 5

$(document).ready(ready)
$(document).on('page:load', ready)
