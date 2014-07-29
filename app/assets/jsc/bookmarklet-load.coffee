//= require jquery
//= require ./lib/vendor/purl

# # images = document.getElementsByTagName("img")
# images = $('img')
#
# # for image in images
# #   unless image.clientWidth > 100 && image.clientHeight > 100
# #     index = images.indexOf(images)
# #
# #     images.splice(index, 1)
#
# images_url = []
#
# for image in images
#   if $(image).attr('data-src')
#     url = $(image).attr('data-src')
#   else
#     url = $(image).attr('src')
#
#   if $.url(url).attr('host') == ""
#     url = "#{$.url().attr('base')}#{url}"
#
#   images_url.push(url)

iframe_url = "http://ikat.dev/bookmarklet/#{escape(document.URL)}"

console.log iframe_url

$("body").append("<iframe class='ikat' src='#{iframe_url}'></iframe>")
