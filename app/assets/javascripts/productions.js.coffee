# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# production_new = ->
#   aproduction = 
#     p_type : $(":input[name='production[p_type]']").val()
#     make_at : $(":input[name='production[make_at]']").val()
#     p_pattern : $(":input[name='production[p_pattern]']").val()
#     p_material : $(":input[name='production[p_material]']").val()
#     p_color : $(":input[name='production[p_color]']").val()
#     p_size : $(":input[name='production[p_size]']").val()

#   $.ajax(
#     type: "POST"
#     url: "/productions"
#     data: {production: aproduction}
#     dataType: 'json'
#     )

# @production_new = production_new

window.get_position = ->
  city = $('#get-position').val()
  [latitude, longitude] = city.split(" ")
  count = $('.production-dots>.production_dots_latitude').length + 1
  positiondiv = position("latitude",count,latitude) + position("longitude",count,longitude)
  $('.production-dots').append(positiondiv)

position = (type, count, value) ->
  "<div class='control-group string optional production_dots_#{type}'>
    <label for='production_dots_attributes_0_latitude' class='string optional control-label'>#{type}</label>
    <div class='controls'>
      <input type='text' size='50' name='production[dots_attributes][#{count}][#{type}]' id='production_dots_attributes_#{count}_#{type}' class='string optional' value='#{value}'>
    </div>
  </div>"

