function mapBuilder() {

  d3.csv("/population.csv", function(err, data) {

    var config = {"state":"state_or_territory","value":"population_estimate_for_july_1_2013_number"}

    var H_MAX = 500,
        W_MAX = 900,
        width = "100%",
        height = convertHeight(),
        SCALE = convertScale(height),
        MAP_STATE = config.state,
        MAP_VALUE = config.value,
        tuition_data = $.getJSON('/states/data.json');

    function convertHeight(){
      var width = $("#body").width();
      if (width >= W_MAX) {
        return H_MAX;
      } else {
        return width*H_MAX/W_MAX;
      }
    };

    function convertScale(height){
      if (height >= H_MAX ) {
        return 1
      } else {
        return height/H_MAX;
      }
    };

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

    var valueById = d3.map();

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

      d3.json("/us.json", function(error, us) {

        svg.append("g")
            .attr("class", "states-choropleth")
          .selectAll("path")
            .data(topojson.feature(us, us.objects.states).features)
          .enter().append("path")
            .attr("transform", "scale(" + SCALE + ")")
            .attr("class", function(d) {
              var map_id = d.id;
              for (var i = 0; i < names.length; i++) {
                var state_id = names[i].id;
                if (state_id == map_id) {
                  try {
                    var state_name = names[i].code;
                    var in_state = tuition_data.responseJSON[state_name];
                  } catch (e) {
                    var in_state = null;
                  };
                };
              };
              if (in_state == true) {
                return "in-state";
              } else if (in_state == false) {
                return "out-of-state";
              } else {
                return "nothing";
              };
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

      });
    });
  });
};
