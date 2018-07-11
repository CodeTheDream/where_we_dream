# @mapBuilder = (url) ->
#   view_width = $(".body").width()
#
#   d3.csv('/population.csv', (err, data) ->
#
#     config = {
#       'state':'state_or_territory',
#       'value':'population_estimate_for_july_1_2013_number'
#     }
#
#     # This clears the map, useful when window resizes.
#     $("#canvas-svg").replaceWith("<div id='canvas-svg'></div>");
#
#     svg = d3.select('#canvas-svg').attr('style', 'width:' + width ).append('svg')
#       .attr('width', width)
#       .attr('height', height);
#
#     height = ->
#       if view_width >= W_MAX
#         H_MAX
#       else
#         view_width * H_MAX / W_MAX
#
#     scale = (height) ->
#       if height >= H_MAX
#         1
#       else
#         height / H_MAX
#
#     valueFormat = (d) ->
#       if d > 1000000000
#         Math.round(d / 1000000000 * 10) / 10 + "B";
#       else if d > 1000000
#         Math.round(d / 1000000 * 10) / 10 + "M";
#       else if d > 1000
#         Math.round(d / 1000 * 10) / 10 + "K";
#       else
#         d
#
#     code = (id) -> id_code[id]
#
#     inState = (id) ->
#       try
#         in_state = wwd_data[code(id)].in_state_css
#       catch e
#         in_state = null
#       finally
#         return in_state
#
#     statePath = (id) ->
#       try
#         db_id = wwd_data[code(id)].id;
#       catch e
#         db_id = null
#       if db_id
#         return url + "/" + db_id
#
#     H_MAX = 500
#     W_MAX = H_MAX*1.8
#     height = height()
#     width = ( if view_width >= W_MAX then W_MAX + "px" else "100%" )
#     SCALE = scale(height)
#     MAP_STATE = config.state
#     MAP_VALUE = config.value
#     path = d3.geo.path()
#     valueById = d3.map()
#
#     d3.tsv('/us-state-names.tsv', (error, names) ->
#
#       name_id = {}
#       id_name = {}
#       id_code = {}
#
#       names.forEach (element, index) ->
#         name_id[element.name] = element.id;
#         id_name[element.id] = element.name;
#         id_code[element.id] = element.code;
#
#       data.forEach( (d) ->
#         id = name_id[d[MAP_STATE]]
#         valueById.set(id, +d[MAP_VALUE])
#       )
#
#       d3.json('/us.json', (error, us) ->
#
#         svg.append('g')
#             .attr('class', 'states-choropleth')
#           .selectAll('path')
#             .data(topojson.feature(us, us.objects.states).features)
#           .enter().append('path')
#             .attr('transform', "scale(#{SCALE})")
#             .attr('data-href', (d) -> statePath(d.id))
#             .attr('class', (d) -> return inState(d.id))
#             .attr('d', path)
#             .on('mousemove', (d) ->
#                 html = ''
#
#                 html += "<div class=\"tooltip_kv\">"
#                 html += "<span class=\"tooltip_key\">"
#                 html += id_name[d.id]
#                 html += "</span>"
#                 html += "<span class=\"tooltip_value\">"
#                 html += (if valueById.get(d.id) then valueFormat(valueById.get(d.id)) else '')
#                 html += ""
#                 html += "</span>"
#                 html += "</div>"
#
#                 $("#tooltip-container").html(html);
#                 $(@).attr("fill-opacity", "0.8");
#                 $("#tooltip-container").show();
#
#                 coordinates = d3.mouse(@)
#
#                 map_width = $('.states-choropleth')[0].getBoundingClientRect().width
#
#                 if d3.event.layerX < map_width / 2
#                   d3.select("#tooltip-container")
#                     .style("top", (d3.event.layerY + 15) + "px")
#                     .style("left", (d3.event.layerX + 15) + "px")
#                 else
#                   tooltip_width = $("#tooltip-container").width()
#                   d3.select("#tooltip-container")
#                     .style("top", (d3.event.layerY + 15) + "px")
#                     .style("left", (d3.event.layerX - tooltip_width - 30) + "px")
#             )
#             .on("mouseout", ->
#               $(@).attr("fill-opacity", "1.0")
#               $("#tooltip-container").hide();
#             )
#
#         svg.append("path")
#             .datum(topojson.mesh(us, us.objects.states, (a, b) -> a != b))
#             .attr("class", "states")
#             .attr("transform", "scale(" + SCALE + ")")
#             .attr("d", path);
#
#         clickableDataHrefs();
#
#       )
#     )
#   )
