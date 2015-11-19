function mapBuilder4() {
  id_map = {
    1: 2,
    2: 3,
    3: 6,
    5: 8,
    6: 9,
    8: 11,
    9: 12,
    10: 13,
    12: 16,
    13: 17,
    15: 19,
    16: 20,
    17: 21,
    18: 22,
    19: 23,
    20: 24,
    21: 25,
    22: 26,
    23: 27,
    24: 28,
    25: 29,
    26: 30,
    27: 31,
    28: 32,
    29: 33,
    30: 34,
    31: 35,
    32: 36,
    33: 37,
    34: 38,
    35: 39,
    36: 40,
    37: 41,
    38: 42,
    39: 44,
    40: 45,
    41: 46,
    42: 47,
    44: 49,
    45: 50,
    46: 51,
    47: 53,
    48: 54,
    49: 55,
    50: 56
  }

  r_id_map = {
    2: 1, // Alaska
    3: 2,
    6: 3,
    8: 5,
    9: 6,
    11: 8, // Colorado
    12: 9,
    13: 10,
    16: 12,
    17: 13,
    19: 15,
    20: 16,
    21: 17,
    22: 18,
    23: 19,
    24: 20,
    25: 21,
    26: 22,
    27: 23,
    28: 24,
    29: 25,
    30: 26,
    31: 27,
    32: 28,
    33: 29,
    34: 30,
    35: 31,
    36: 32,
    37: 33,
    38: 34,
    39: 35,
    40: 36,
    41: 37,
    42: 38,
    44: 39,
    45: 40,
    46: 41,
    47: 42,
    49: 44,
    50: 45,
    51: 46,
    53: 47,
    54: 48,
    55: 49,
    56: 50
  }

  d3.csv("/population.csv", function(err, data) {

    var config = {"color1":"#d3e5ff","color2":"#08306B","stateDataColumn":"state_or_territory","valueDataColumn":"population_estimate_for_july_1_2013_number"}

    var H_MAX = 500,
        W_MAX = 900,
        width = "100%",
        height = convertHeight(),
        SCALE = convertScale(height),
        COLOR_COUNTS = 10,
        COLOR_FIRST = config.color1,
        COLOR_LAST = config.color2;

    var tuition_data = $.getJSON('/states/data.json');

    function convertHeight(){
      var width = $("#body").width();
      if (width >= W_MAX) {
        return H_MAX;
      } else {
        return width*H_MAX/W_MAX;
      }
    };

    function convertScale(height){
      if (height >= 500 ) {
        return 1
      } else {
        return height/H_MAX;
      }
    };

    function Interpolate(start, end, steps, count) {
        var s = start,
            e = end,
            final = s + (((e - s) / steps) * count);
        return Math.floor(final);
    }

    function Color(_r, _g, _b) {
        var r, g, b;
        var setColors = function(_r, _g, _b) {
            r = _r;
            g = _g;
            b = _b;
        };

        setColors(_r, _g, _b);
        this.getColors = function() {
            var colors = {
                r: r,
                g: g,
                b: b
            };
            return colors;
        };
    }

    function hexToRgb(hex) {
        var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
        return result ? {
            r: parseInt(result[1], 16),
            g: parseInt(result[2], 16),
            b: parseInt(result[3], 16)
        } : null;
    }

    function valueFormat(d) {
      if (d > 1000000000) {
        return Math.round(d / 1000000000 * 10) / 10 + "B";
      } else if (d > 1000000) {
        return Math.round(d / 1000000 * 10) / 10 + "M";
      } else if (d > 1000) {
        return Math.round(d / 1000 * 10) / 10 + "K";
      } else {
        return d;
      }
    }

    var rgb = hexToRgb(COLOR_FIRST);

    var COLOR_START = new Color(rgb.r, rgb.g, rgb.b);

    rgb = hexToRgb(COLOR_LAST);
    var COLOR_END = new Color(rgb.r, rgb.g, rgb.b);

    var MAP_STATE = config.stateDataColumn;
    var MAP_VALUE = config.valueDataColumn;

    var valueById = d3.map();

    var startColors = COLOR_START.getColors(),
        endColors = COLOR_END.getColors();

    var colors = [];

    for (var i = 0; i < COLOR_COUNTS; i++) {
      var r = Interpolate(startColors.r, endColors.r, COLOR_COUNTS, i);
      var g = Interpolate(startColors.g, endColors.g, COLOR_COUNTS, i);
      var b = Interpolate(startColors.b, endColors.b, COLOR_COUNTS, i);
      colors.push(new Color(r, g, b));
    }

    var quantize = d3.scale.quantize()
        .domain([0, 1.0])
        .range(d3.range(COLOR_COUNTS).map(function(i) { return i }));

    var path = d3.geo.path();

    var svg = d3.select("#canvas-svg").append("svg")
        .attr("width", width)
        .attr("height", height);

    d3.tsv("/us-state-names.tsv", function(error, names) {

      name_id_map = {};
      id_name_map = {};

      for (var i = 0; i < names.length; i++) {
        name_id_map[names[i].name] = names[i].id;
        id_name_map[names[i].id] = names[i].name;
      }

      data.forEach(function(d) {
        var id = name_id_map[d[MAP_STATE]];
        valueById.set(id, +d[MAP_VALUE]);
      });

      quantize.domain([d3.min(data, function(d){ return +d[MAP_VALUE] }),
        d3.max(data, function(d){ return +d[MAP_VALUE] })]);

      d3.json("/us.json", function(error, us) {

        // console.log(names)
        // console.log(names[0].id)
        // console.log(us)
        // console.log(data)

        svg.append("g")
            .attr("class", "states-choropleth")
          .selectAll("path")
            .data(topojson.feature(us, us.objects.states).features)
          .enter().append("path")
            .attr("transform", "scale(" + SCALE + ")")
            .attr("class", function(d) {
              // console.log(names)
              // console.log(d)
              // console.log(name_id_map)
              // console.log(id_name_map)
              // console.log(d.id) // id of data map thing
              // console.log(valueById.get(d.id));
              for (var i = 0; i < names.length; i++) {
                // console.log(names[i].id)
                // console.log(names)
                // console.log(typeof(names[i].id))
                var state_id = names[i].id;
                // var state_id = id_map[names[i].id];
                // var state_id = r_id_map[names[i].id];
                var map_id = d.id;
                // var map_id = id_map[d.id];
                // var map_id = r_id_map[d.id];
                if (state_id == map_id) {
                  try {
                    // console.log("made it")
                    var in_state = tuition_data.responseJSON[names[i].code];
                  } catch (e) {
                    var in_state = null;
                  }
                }
              }
              if (in_state == true) {
                return "in-state";
              } else if (in_state == false) {
                return "out-of-state";
              } else {
                return "nothing";
              }
            })
            .attr("d", path)
            .on("mousemove", function(d) {
                var html = "";

                html += "<div class=\"tooltip_kv\">";
                html += "<span class=\"tooltip_key\">";
                html += id_name_map[d.id];
                html += "</span>";
                html += "<span class=\"tooltip_value\">";
                html += (valueById.get(d.id) ? valueFormat(valueById.get(d.id)) : "");
                html += "";
                html += "</span>";
                html += "</div>";

                $("#tooltip-container").html(html);
                $(this).attr("fill-opacity", "0.8");
                $("#tooltip-container").show();

                var coordinates = d3.mouse(this);

                var map_width = $('.states-choropleth')[0].getBoundingClientRect().width;

                if (d3.event.layerX < map_width / 2) {
                  d3.select("#tooltip-container")
                    .style("top", (d3.event.layerY + 15) + "px")
                    .style("left", (d3.event.layerX + 15) + "px");
                } else {
                  var tooltip_width = $("#tooltip-container").width();
                  d3.select("#tooltip-container")
                    .style("top", (d3.event.layerY + 15) + "px")
                    .style("left", (d3.event.layerX - tooltip_width - 30) + "px");
                }
            })
            .on("mouseout", function() {
                    $(this).attr("fill-opacity", "1.0");
                    $("#tooltip-container").hide();
                });

        svg.append("path")
            .datum(topojson.mesh(us, us.objects.states, function(a, b) { return a !== b; }))
            .attr("class", "states")
            .attr("transform", "scale(" + SCALE + ")")
            .attr("d", path);

        // d3.json("/states/data.json", function(error, us){
        //   svg.append("g").attr("class", function(d) {
        //     if (us[valueById.get(d.code)] == true)
        //       return "in-state"
        //     } else if (states[valueById.get(d.code)] == true) {
        //       return "out-of-state"
        //     };
        //   });
        // });

      });
    });
  });
}
