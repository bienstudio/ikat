//= require jquery

current_url = document.URL.replace("http://","").replace("http:// www.","").replace("https://", "").replace("https:// www.", "").replace("www.","")
iframe_url  = "http://ikat.dev/bookmarklet/#{current_url}"

$("body").append("<iframe class='ikat' src='#{iframe_url}' style='background: #0a0a0a; border: none; position: fixed; bottom: 0; left: 0; width: 100%; height: 300px; margin-top: 300px; z-index: 9999; box-shadow: 0px -3px 10px 0px rgba(10, 10, 10, 0.75)'></iframe>")

$(document).keyup (e) ->
  if e.keyCode == 27
    closeBookmarklet()

@.closeBookmarklet = ->
  $("iframe.ikat").remove()
