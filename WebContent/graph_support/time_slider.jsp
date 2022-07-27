
 <style>
    
.tick{
	font-size: 10px;
}

.slider {
  cursor: pointer;
}
</style>

<div id="vis-button">
  
</div>
<div id="vis">
</div>
<script>

var formatDateIntoYear = d3.timeFormat("%Y");
var formatDate = d3.timeFormat("%m/%Y");
var parseDate = d3.timeParse("%m/%d/%y");
var current_date_value =  0;

var domName = '#vis';

var margin = {top:0, right:50, bottom:0, left:50},
    width = $(domName).width() - margin.left - margin.right,
    height = 80 - margin.top - margin.bottom;

	var svg = d3.select("#vis")
	    .append("svg")
	    .attr("id", "slider-svg")
	    .attr("width", width + margin.left + margin.right)
	    .attr("height", height + margin.top + margin.bottom);  
	 
	//////////slider //////////
	// Time
	var moving = false;
	var currentValue = 0;
	var targetValue = width;
	var timer;
	
	var minDate = new Date('Jan 01 2020'),
	      maxDate = new Date('Jul 01 2022'),
	      startDate = new Date("Feb 01 2022");
	var interval = maxDate.getFullYear() - minDate.getFullYear() + 1;
	var startYear = minDate.getFullYear();
	var dataMonths = [];
	
	
	var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

	for (let year = 0; year < interval; year++) {
	  for (let month = 0; month < 12; month++) {
		  if (month <= maxDate.getMonth() || year < 2){
			  	var year2 = startYear + year;
			  	console.log(monthNames[month] + ' 01 ' + year2);
				dataMonths.push(new Date(monthNames[month] + " 01 " + year2));
		  }
	  }
	}
	
	
	var sliderTime = d3
		.sliderBottom()
		.min(d3.min(dataMonths))
		.max(d3.max(dataMonths))
		.marks(dataMonths)
		.width(width)
		.displayValue(false)
		.tickFormat(function(d){
			if (d3.timeYear(d) < d) {
		        return d3.timeFormat('%b')(d);
		      } else {
		        return d3.timeFormat('%Y')(d);
		      }
		})
		.tickValues(dataMonths)
		.on('onchange',function(d) {
			current_date_value = sliderTime.value();
		    update(d); 
		})
		.on("drag", function (val) {
		    resetTimer();
		})
		.handle(d3.symbol().type(d3.symbolCircle).size(200)());
	  
	var gTime =  svg.append("g")
		.attr('width', width)
		.attr('height', 100)
		.attr('class', 'slider_stuff')
		.attr('transform', 'translate(30,30)');
	
	gTime.call(sliderTime);
	 
	d3.select(".parameter-value text").attr("y", "-29");
	d3.selectAll(".slider_stuff .tick text")
		.attr('transform', 'translate(-20,0)rotate(-65)')
		.attr("text-anchor", "end");
	
	var playButton = d3.select("#play-button");
	
	////////// plot //////////
	
	
	playButton
	    .on("click", function() {
	    	var button = d3.select(this);
	    	if (button.html() == '<i class="fas fa-pause-circle" aria-hidden="true"></i>') {
	      		moving = false;
	      		clearInterval(timer);
	      		resetTimer();
	      		// timer = 0;
	      		button.html('<i class="fas fa-play-circle"></i>');
	    	} else {
	      		moving = true;
	      		timer = setInterval(update2, 1000);
	      		button.html('<i class="fas fa-pause-circle"></i>');
	    	}
	  });
	
	//var stepnumber = monthDiff(startDate, endDate);
	function daysInMonth (month, year) {
	    return new Date(year, month, 0).getDate();
	}
	
	function update2() {
		var current_date = sliderTime.value();
		var stepday = daysInMonth(current_date.getMonth(), current_date.getYear());
		var result = current_date.setDate(current_date.getDate() + stepday);
		var maxDate2 = maxDate.setDate(maxDate.getDate() + 1);
		if(result.valueOf() > maxDate2.valueOf()) {
			resetTimer();
		}else{
			sliderTime.value(result.valueOf());
			update(result.valueOf());
		}
	}
	
	function update(h) {
	  $('#current_date').html(formatDate(h));
	  ${param.block}_constrain_table("subsequent_infection", formatDate(h));
	}
	
	function resetTimer() {
		moving = false;
		clearInterval(timer);
		playButton.html('<i class="fas fa-play-circle"></i>');
	}
	
	
	////////////////////////////// resize ///////////////////////////////////////////////////////////////////////////
	
	function drawgraphnew2(){
		var newWidth2 = $('#reinfection1').width();
		if (newWidth2 > 0) {
			d3.select(domName).select("svg").remove();
			width2 = newWidth2 - margin.left - margin.right;
			resize();
			update(current_date_value);
		}
	};
	window.onresize = drawgraphnew2;
	
	function resize() {
		var formatDateIntoYear = d3.timeFormat("%Y");
		var formatDate = d3.timeFormat("%m/%Y");
		var parseDate = d3.timeParse("%m/%d/%y");

		var domName = '#vis';

		var margin = {top:0, right:50, bottom:0, left:50},
		    width = $(domName).width() - margin.left - margin.right,
		    height = 80 - margin.top - margin.bottom;

			var svg = d3.select("#vis")
			    .append("svg")
			    .attr("id", "slider-svg")
			    .attr("width", width + margin.left + margin.right)
			    .attr("height", height + margin.top + margin.bottom);  
			 
			//////////slider //////////
			// Time
			var moving = false;
			var currentValue = 0;
			var targetValue = width;
			var timer;
			
			var minDate = new Date('Jan 01 2020'),
		      maxDate = new Date('Jul 01 2022'),
		      startDate = new Date("Feb 01 2022");
			var interval = maxDate.getFullYear() - minDate.getFullYear() + 1;
			var startYear = minDate.getFullYear();
			var dataMonths = [];
			
			
			var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
	
			for (let year = 0; year < interval; year++) {
			  for (let month = 0; month < 12; month++) {
				  if (month <= maxDate.getMonth() || year < 2){
					  	var year2 = startYear + year;
					  	console.log(monthNames[month] + ' 01 ' + year2);
						dataMonths.push(new Date(monthNames[month] + " 01 " + year2));
				  }
			  }
			}
			
			var sliderTime = d3
				.sliderBottom()
				.min(d3.min(dataMonths))
				.max(d3.max(dataMonths))
				.marks(dataMonths)
				.width(width)
				.displayValue(false)
				.tickFormat(function(d){
					if (d3.timeYear(d) < d) {
				        return d3.timeFormat('%b')(d);
				      } else {
				        return d3.timeFormat('%Y')(d);
				      }
					formatTick(d);
				})
				.tickValues(dataMonths)
				.on('onchange',function(d) {
					current_date_value = sliderTime.value();
				    update(d); 
				})
				.on("drag", function (val) {
				    resetTimer();
				})
				.handle(d3.symbol().type(d3.symbolCircle).size(200)());
		
			console.log(current_date_value);
			sliderTime.value(current_date_value.valueOf());
			  
			var gTime =  svg.append("g")
				.attr('width', width)
				.attr('height', 100)
				.attr('class', 'slider_stuff')
				.attr('transform', 'translate(30,30)');
			
			gTime.call(sliderTime);
			 
			d3.select(".parameter-value text").attr("y", "-29");
			d3.selectAll(".slider_stuff .tick text")
				.attr('transform', 'translate(-20,0)rotate(-65)')
				.attr("text-anchor", "end");
			
			var playButton = d3.select("#play-button");
			
			////////// plot //////////
			
			
			playButton
			    .on("click", function() {
			    	var button = d3.select(this);
			    	if (button.html() == '<i class="fas fa-pause-circle" aria-hidden="true"></i>') {
			      		moving = false;
			      		clearInterval(timer);
			      		resetTimer();
			      		// timer = 0;
			      		button.html('<i class="fas fa-play-circle"></i>');
			    	} else {
			      		moving = true;
			      		timer = setInterval(update2, 1000);
			      		button.html('<i class="fas fa-pause-circle"></i>');
			    	}
			  });
			
			//var stepnumber = monthDiff(startDate, endDate);
			function daysInMonth (month, year) {
			    return new Date(year, month, 0).getDate();
			}
			
			function update2() {
				var current_date = sliderTime.value();
				var stepday = daysInMonth(current_date.getMonth(), current_date.getYear());
				var result = current_date.setDate(current_date.getDate() + stepday);
				var maxDate2 = maxDate.setDate(maxDate.getDate() + 1);
				if(result.valueOf() > maxDate2.valueOf()) {
					resetTimer();
				}else{
					sliderTime.value(result.valueOf());
					update(result.valueOf());
				}
			}
			
			function update(h) {
			  $('#current_date').html(formatDate(h));
			  ${param.block}_constrain_table("subsequent_infection", formatDate(h));
			}
			
			function resetTimer() {
				moving = false;
				clearInterval(timer);
				playButton.html('<i class="fas fa-play-circle"></i>');
			}
			
			
	}


</script>
