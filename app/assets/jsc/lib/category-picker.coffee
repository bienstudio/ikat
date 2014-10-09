# Ikat.
#   file: jsc/lib/category-picker.coffee

# On click, add the class `.current` to the clicked `li`. In CSS, this will show
#   the direct descendants of that `li` (so `li > ul`). It will also show the
#   ascendants of that `li`.
# $(document).ready ->
#   selector = new CategorySelector($("ul.category-picker"))
#   # $("ul.category-picker li").on "click", ->
#   #   $("ul.category-picker li").removeClass "current"
#   #   $(@).addClass "current"
#
# class CategorySelector
#   constructor: (list) ->
#     @tree = CategorySelector.build_tree(list)
#
#   # Takes any `ul` as an argument.
#   @build_tree: (ul) ->
#     $(ul).children("li").map ->
#       console.log $(@)

console.log gon.categories

console.log JSON.stringify(gon.categories)
