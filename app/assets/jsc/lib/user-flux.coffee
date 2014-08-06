# Ikat.
#   file: jsc/lib/user-flux.coffee

$(document).ready ->
  $('.user-flux').bind "ajax:complete", (data, status, xhr) ->
    trigger = $(@)

    # Just unfollowed
    if trigger.hasClass("unfollow")
      trigger.switchClass("unfollow", "follow")
      trigger.switchClass("btn-red", "btn-green")
      trigger.html("Follow")

    # Just followed
    else
      trigger.switchClass("follow", "unfollow")
      trigger.switchClass("btn-green", "btn-red")
      trigger.html("Unfollow")
