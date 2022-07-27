
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


var margin = {top:0, right:50, bottom:0, left:50},
    width = 860 - margin.left - margin.right,
    height = 80 - margin.top - margin.bottom;

var svg = d3.select("#vis")
    .append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom);  
 
//////////slider //////////
// Time
var moving = false;
var currentValue = 0;
var targetValue = width;
var timer;

var minDate = new Date('2020-1-01'),
      maxDate = new Date('2022-08-01'),
      startDate = new Date("2022-2-1"),
      interval = maxDate.getFullYear() - minDate.getFullYear() + 1,
      startYear = minDate.getFullYear();
let dataMonths = [];

console.log(startDate);

for (let year = 0; year < interval; year++) {
  for (let month = 0; month < 12; month++) {
	  if (month <= maxDate.getMonth() || year < 2){
		  	var year2 = startYear + year;
		  	var month2 = month +1;
    		dataMonths.push(new Date(year2 +"-"+ month2 +"-"+ 1));
	  }
  }
}

console.log(dataMonths);

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
	    update(d); 
	})
	.on("drag", function (val) {
	    resetTimer();
	})
	.handle(d3.symbol().type(d3.symbolCircle).size(200)());
  
  var gTime =  svg.append("g")
    .attr('width', width)
    .attr('height', 100)
    .attr('transform', 'translate(30,30)');

  gTime.call(sliderTime);
 
  d3.select(".parameter-value text").attr("y", "-29");

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
	if(result.valueOf() > maxDate.valueOf()) {
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
</script>
