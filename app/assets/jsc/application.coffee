//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

//= stub ./bookmarklet/load
//= stub ./bookmarklet/add

ready = ->
  $("img").unveil()

  # $('.products').isotope
  #   itemSelector: ".product"
  #   masonry:
  #     columnWidth: 209
  #     gutter: 5

$(document).ready(ready)
$(document).on('page:load', ready)
