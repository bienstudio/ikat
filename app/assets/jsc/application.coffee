//= require jquery
//= require jquery_ujs
//= require_tree ./lib

ready = ->
  $("img").unveil()

  $(".collections-trigger").popover
    my: 'top'
    at: 'bottom'

$(document).ready(ready)
$(document).on('page:load', ready)
