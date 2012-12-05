# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('#item-form').dialog(
    autoOpen:false
    height:500
    width:350
    modal:false
  )

$ ->
  $('#new-item-btn').button()
    .click ->
      $('#item-form').dialog("open")

$ ->
  $('#store-form').dialog(
    autoOpen:false
    height:250
    width:350
    modal:false
  )

$ ->
  $('#new-store-btn').button()
    .click ->
      $('#store-form').dialog("open")