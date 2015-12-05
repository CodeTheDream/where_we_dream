function mapBuilder(url) {

  var view_width = $("#body").width();

  d3.csv("/population.csv", function(err, data) {

    var config = {"state":"state_or_territory","value":"population_estimate_for_july_1_2013_number"}

    var H_MAX = 500,
        W_MAX = H_MAX*1.8,
        height = height(),
        width = ( view_width >= W_MAX ? W_MAX+"px" : "100%" ),
        SCALE = scale(height),
        MAP_STATE = config.state,
        MAP_VALUE = config.value,
        path = d3.geo.path(),
        valueById = d3.map();
    // This clears the map, useful when window resizes.
    $("#canvas-svg").replaceWith("<div id='canvas-svg'></div>");

    var svg = d3.select("#canvas-svg").attr("style", "width:" + width ).append("svg")
        .attr("width", width)
        .attr("height", height);

    function height(){
      if (view_width >= W_MAX) {
        return H_MAX;
      } else {
        return view_width*H_MAX/W_MAX;
      }
    };

    function scale(height){
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

    function code(id) {
      return id_code[id]
    };

    function inState(id) {
      try {
        var in_state = wwd_data.responseJSON[code(id)].in_state_css;
      } catch (e) {
        var in_state = null;
      } finally {
        return in_state;
      };
    };

    function statePath(id) {
      try {
        var db_id = wwd_data.responseJSON[code(id)].id;
      } catch (e) {
        var db_id = null;
      };
      if (db_id) {
        return url + "/" + db_id;
      };
    };

    d3.tsv("/us-state-names.tsv", function(error, names) {

      name_id = {};
      id_name = {};
      id_code = {};

      for (var i = 0; i < names.length; i++) {
        name_id[names[i].name] = names[i].id;
        id_name[names[i].id] = names[i].name;
        id_code[names[i].id] = names[i].code;
      }

      data.forEach(function(d) {
        var id = name_id[d[MAP_STATE]];
        valueById.set(id, +d[MAP_VALUE]);
      });

      d3.json("/us.json", function(error, us) {

        svg.append("g")
            .attr("class", "states-choropleth")
          .selectAll("path")
            .data(topojson.feature(us, us.objects.states).features)
          .enter().append("path")
            .attr("transform", "scale(" + SCALE + ")")
            .attr("data-href", function(d){ return statePath(d.id) })
            .attr("class", function(d){ return inState(d.id) })
            .attr("d", path)
            .on("mousemove", function(d) {
                var html = "";

                html += "<div class=\"tooltip_kv\">";
                html += "<span class=\"tooltip_key\">";
                html += id_name[d.id];
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

        clickableDataHrefs();

      });
    });
  });
};
