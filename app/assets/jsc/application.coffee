//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

# container = document.querySelector(".products")
# msnry = new Masonry(container,
#   columnWidth: 280
#   itemSelector: ".product"
# )

$(document).ready ->
  $("img").unveil()
