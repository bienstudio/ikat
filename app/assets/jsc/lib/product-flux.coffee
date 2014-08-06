# Ikat.
#   file: jsc/lib/product-flux.coffee

# Handles flux Ajax calls and events.

$(document).ready ->

  # This is a button
  $(".wants-flux").bind "ajax:complete", (data, status, xhr) ->
    trigger = $(@).parent().children('span.collections-trigger')

    # Just added, so change to remove
    if $(@).hasClass "add"
      $(@).switchClass "add", "remove"
      $(@).switchClass "btn-red", "btn-green"

      trigger.switchClass "btn-red", "btn-green"

      $(@).html "Remove"

    # Just removed, so change to add
    else
      $(@).switchClass "remove", "add"
      $(@).switchClass "btn-green", "btn-red"

      trigger.switchClass "btn-green", "btn-red"

      $(@).html "Want"

  # This is a checkbox
  $(".collection-flux").on "click", ->
    $(@).closest("form").submit()
