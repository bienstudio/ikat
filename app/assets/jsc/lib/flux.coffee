# Ikat.
#   file: jsc/lib/flux.coffee

# Handles flux Ajax calls and events.

# This is a button
$(".wants-flux").bind "ajax:complete", (data, status, xhr) ->
  trigger = $(@).parent().children('span.collections-trigger')

  # Just added, so change to remove
  if $(@).hasClass "add"
    $(@).removeClass "add"
    $(@).addClass "remove"

    $(@).removeClass "btn-red"
    $(@).addClass "btn-green"

    trigger.removeClass "btn-red"
    trigger.addClass "btn-green"

    $(@).html "Remove"
  # Just removed, so change to add
  else
    $(@).removeClass "remove"
    $(@).addClass "add"

    $(@).removeClass "btn-green"
    $(@).addClass "btn-red"

    trigger.removeClass "btn-green"
    trigger.addClass "btn-red"

    $(@).html "Want"

# This is a checkbox
$(".collection-flux").on "click", ->
  $(@).closest("form").submit()
