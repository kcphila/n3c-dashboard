<script>

function localHeatMap(data, properties) {

	var min_height = (properties.min_height === undefined ? 200 : properties.min_height);

	if ((properties.ordered != undefined) && (properties.ordered == 1)) {
		data.sort(function(a, b) {
			// console.log(a);
			return parseFloat(b.count) - parseFloat(a.count);
		});
	}

	var margin = { top: 20, right: 20, bottom: 20, left: 150 },
		width = 1200 - margin.left - margin.right,
		height = width - margin.top - margin.bottom;

	var myObserver = new ResizeObserver(entries => {
		entries.forEach(entry => {
			var newWidth = Math.floor(entry.contentRect.width);
			if (newWidth > 0) {
				d3.select("#" + properties.domName).select("svg").remove();
				width = newWidth - margin.left - margin.right;
				height = width;
				if (height < min_height) {
					height = min_height;
				};
				draw();
			}
		});
	});

	myObserver.observe(d3.select("#" + properties.domName).node());
	draw();

	function draw() {
		console.log(data);
		
		var n = data.length;
		
		  // Precompute the orders.
		  var orders = {
		    variable: d3.range(n).sort(function(a, b) { return d3.ascending(data[a].variable, data[b].variable); }),
		    value: d3.range(n).sort(function(a, b) { return data[b].value - data[a].value; }),
		    group: d3.range(n).sort(function(a, b) { return data[b].group - data[a].group; })
		  };


		// append the svg object to the body of the page
		var svg = d3.select("#" + properties.domName)
			.append("svg")
			.attr("width", width + margin.left + margin.right)
			.attr("height", height + margin.top + margin.bottom)
			.append("g")
			.attr("transform", "translate(" + margin.left + "," + margin.top + ")");

		// Labels of row and columns -> unique identifier of the column called 'group' and 'variable'
		var myGroups = d3.map(data, function(d) { return d.group; }).keys()
		var myVars = d3.map(data, function(d) { return d.variable; }).keys()

		// Build X scales and axis:
		var x = d3.scaleBand()
			.range([0, width - margin.left - margin.right])
			.domain(myGroups)
			.padding(0.05);
		svg.append("g")
			.style("font-size", 12)
			.attr("transform", "translate(0," + height + ")")
			.call(d3.axisBottom(x).tickSize(0))
			.select(".domain").remove()

		// Build Y scales and axis:
		var y = d3.scaleBand()
			.range([height - margin.top - margin.bottom, 0])
			.domain(myVars)
			.padding(0.05);
		svg.append("g")
			.style("font-size", 12)
			.call(d3.axisLeft(y).tickSize(0))
			.select(".domain").remove()

		// Build color scale
		var myColor = d3.scaleLinear()
			.range(["white", "blue"])
			.domain([0,10000])

		// create a tooltip
		var tooltip = d3.select("#my_dataviz")
			.append("div")
			.style("opacity", 0)
			.attr("class", "tooltip")
			.style("background-color", "white")
			.style("border", "solid")
			.style("border-width", "2px")
			.style("border-radius", "5px")
			.style("padding", "5px")

		// Three function that change the tooltip when user hover / move / leave a cell
		var mouseover = function(d) {
			tooltip
				.style("opacity", 1)
			d3.select(this)
				.style("stroke", "black")
				.style("opacity", 1)
		}
		var mousemove = function(d) {
			tooltip
				.html("The exact value of<br>this cell is: " + d.value)
				.style("left", (d3.mouse(this)[0] + 70) + "px")
				.style("top", (d3.mouse(this)[1]) + "px")
		}
		var mouseleave = function(d) {
			tooltip
				.style("opacity", 0)
			d3.select(this)
				.style("stroke", "none")
				.style("opacity", 0.8)
		}

		// add the squares
		svg.selectAll()
			.data(data, function(d) { return d.group + ':' + d.variable; })
			.enter()
			.append("rect")
			.attr("x", function(d) { return x(d.group) })
			.attr("y", function(d) { return y(d.variable) })
			.attr("rx", 4)
			.attr("ry", 4)
			.attr("width", x.bandwidth())
			.attr("height", y.bandwidth())
			.style("fill", function(d) { return myColor(d.value) })
			.style("stroke-width", 4)
			.style("stroke", "none")
			.style("opacity", 0.8)
			.on("mouseover", mouseover)
			.on("mousemove", mousemove)
			.on("mouseleave", mouseleave)
	}
}
</script>
