# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('#select-grade, #select-year, #select-enrollment-year').change ->
    grade_id = $("#select-grade").val()
    year = $("#select-year").val()
    enrollment_year = $("#select-enrollment-year").val()
    window.location = '/students?grade_id=' + grade_id + '&year=' + year + '&enrollment_year=' + enrollment_year
    return
  return
