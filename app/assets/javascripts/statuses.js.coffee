# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('select#select_grade').change ->
    val = $(this).val()
    window.location = '/students?grade_id=' + val
    return
  return
