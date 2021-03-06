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

position = (type, count, value) ->
  "<div class='hidden control-group string optional production_dots_#{type}'>
    <div class='controls'>
      <input type='text' size='50' name='production[dots_attributes][#{count}][#{type}]' id='production_dots_attributes_#{count}_#{type}' class='string optional' value='#{value}'>
    </div>
  </div>"

effect = "drop"
dtime = 2
p_pattern = ""
city_array = new Array()
overlays = new Array()
polygon = undefined

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
    target.parent().children().find('span.selected').prev().remove()
    target.parent().children().find('span.selected').removeClass('selected')
    target.children('span').before('<i class="icon-ok"></i>')
    target.children('span').addClass('selected')

  $('#decide-to-create').click ->
    prepare_data()
    $('#new_production').submit()

init = ->
  $('#production-select-pattern').hide()
  $('#production-select-others').hide()

append_div_to = ->
  city = $('#get-position').val()
  unless city in (c.city for c in city_array)
    myGeo = new BMap.Geocoder()
    myGeo.getPoint city, 
      (point) -> 
        city_array.push({city:city, lat:point.lat, lng:point.lng})
        if city_array.length is 1
          circle = new BMap.Circle point, 40000
          circle = set_circle(circle)
          map.addOverlay(circle)
        else  
          plotlines()
        $('.display-position').append("<div>#{city}</div>")
      city  
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

plotlines = ->
  map.clearOverlays()
  n = city_array.length
  for i in [0..(n-2)]
    for j in [(i+1)..(n-1)]
      points = (new BMap.Point(c.lng, c.lat) for c in [city_array[i], city_array[j]]  )
      polyline = new BMap.Polyline points, {strokeColor:"blue", strokeWeight:6, strokeOpacity:0.5}
      map.addOverlay(polyline)

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
    pixel = map.pointToPixel(new BMap.Point(e.lng, e.lat))
    positiondiv = position("x", i, pixel.x) + position("y", i, pixel.y) + position("city_name", i, e.city)
    $('.production-dots').append(positiondiv)