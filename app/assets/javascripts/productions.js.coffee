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

effect = "drop"
dtime = 2
p_pattern = ""
city_array = new Array()

$ ->
  init()

  $('#position-search').click -> 
    append_div_to()

  $('#get-position').keyup (e) ->
    append_div_to() if e.which is 13

  display_map()  

  go_to_others_toggle(p_pattern)
  $("#production-new-next,#back-to-positions").click -> positions_and_pattern_toggle(effect, dtime)
  $("#go-to-others,#back-to-pattern").click -> 
    pattern_and_others_toggle(effect, dtime)
    go_to_others_toggle(p_pattern)

  $('.pattern-image-show').bind 'mouseover', (e) => 
    $(e.currentTarget).find('.pattern-image-show-image').css("border-color", "magenta")
  $('.pattern-image-show').bind 'mouseout', (e) => 
    $(e.currentTarget).find('.pattern-image-show-image').css("border-color", "#eee")
  $('.pattern-image-show').bind 'click', (e) => 
    p_pattern = $(e.currentTarget).find('.pattern-image-show-pattern').text()
    generate_others(p_pattern)
    pattern_and_others_toggle(effect, dtime)

  $('.others-each-size, .others-each-material, .others-each-color').bind 'click', (e) =>
    target = $(e.currentTarget)
    target.parent().children().find('.selected').removeClass('selected')
    target.children().addClass('selected')

  $('#decide-to-create').click ->
    prepare_data()
    $('#new_production').submit()

init = ->
  $('#production-select-pattern').hide()
  $('#production-select-others').hide()

append_div_to = ->
  city = $('#get-position').val()
  unless city in city_array
    myGeo = new BMap.Geocoder()
    myGeo.getPoint city, 
      (point) -> 
        city_array.push({city:city, lat:point.lat, lng:point.lng})
        circle = new BMap.Circle point, 40000
        circle = set_circle(circle)
        map.addOverlay(circle)
      city  
    $('.display-position').append("<div>#{city}</div>")
  $('#get-position').val('')  
    
display_map = ->
  window.map = new BMap.Map("map-display")
  point = new BMap.Point(104.3,32.6)
  map.centerAndZoom(point,5)
  map.enableScrollWheelZoom(true)

set_circle = (circle) ->
  circle.setStrokeOpacity(1)
  circle.setStrokeWeight(1)
  circle.setStrokeColor("magenta")
  circle.setFillColor("magenta")
  circle.setFillOpacity(1)  
  circle

get_circle_radius = (zoom) ->
  Math.pow(2, 7-zoom)*Math.pow(10, 4)

positions_and_pattern_toggle = (effect, dtime) ->
  $('.get-positions').toggle(dtime)
  $('#production-select-pattern').toggle(dtime)

pattern_and_others_toggle = (effect, dtime) ->
  $('#production-select-pattern').toggle(dtime)
  $('#production-select-others').toggle(dtime)

generate_others = (p_pattern) ->
  $('#production-others-pattern').empty()
  $('#production-others-pattern').text(p_pattern)

go_to_others_toggle = (p_pattern) ->
  if p_pattern == ""
    $("#go-to-others").hide()
  else
    $("#go-to-others").show()

prepare_data = ->
  $('#production_p_pattern').val(p_pattern)
  $('#production_p_material').val($('.others-each-material>.selected').text())
  $('#production_p_color').val($('.others-each-color>.selected').text())
  $('#production_p_size').val($('.others-each-size>.selected').text())
  for e,i in city_array
    positiondiv = position("latitude", i, e.lat) + position("longitude", i, e.lng)
    $('.production-dots').append(positiondiv)