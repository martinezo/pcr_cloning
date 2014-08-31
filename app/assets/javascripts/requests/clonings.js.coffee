# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  check_cloning_type()
  check_cloning_type_on_change()

  return

#For turbolinks: http://stackoverflow.com/questions/17600093/rails-javascript-not-loading-after-clicking-through-link-to-helper. Instead of $(document).ready
$(document).on "page:load", ->
  check_cloning_type()
  check_cloning_type_on_change()

check_cloning_type = ->
  if $("#requests_cloning_req_type_2").is(":checked")
    $("#seq_type").show()
  else
    $("#seq_type").hide()
  return

check_cloning_type_on_change = ->
  $("#requests_cloning_req_type_2,#requests_cloning_req_type_1").change ->
    check_cloning_type()
    return
