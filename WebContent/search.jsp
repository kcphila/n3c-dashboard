<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!DOCTYPE html>
<html>

<style>
.section{
	margin-bottom:100px;
}

.section-description{
	margin-top: 30px;
	margin-bottom: 60px;
}

.analysis label i{
	color: #0b4865;
}
.overview label i{
	color: #4933b1; 
} 
.about label i{ 
	color: gray; 
}
.iconanalysis:before{
	color: #0b4865;
	font-family: "Font Awesome 5 Free";
	font-weight: 900;
	content: "\f200";
}
.iconoverview:before{
	color: #4933b1;
	font-family: "Font Awesome 5 Free";
	font-weight: 900;
	content: "\f1c0";
}
.iconabout:before{
	color: gray;
	font-family: "Font Awesome 5 Free";
	font-weight: 900;
	content: "\f05a";
}

#search_table_section .form-check label{ 
	font-size: 1.4rem; 
	color: #222;
}

.publication-panel-group .badge{
	font-size: 18px;
   	font-weight: 300;
   }
   
.title{
   	font-size: 1.3rem;
   	line-height: 1;
   	font-weight: 400;
   	color: #222;
}

/* autocomplete  ****************************************************/
.autocomplete-items {
  position: absolute;
  border: 1px solid #d4d4d4;
  border-bottom: none;
  border-top: none;
  z-index: 99;
  
  /*position the autocomplete items to be the same width as the container:*/
  
/*   top: 100%; */
/*   left: 0; */
  right: 0;
  color: black;
}
.autocomplete-items div {
  padding: 10px;
  cursor: pointer;
  background-color: #fff;
  border-bottom: 1px solid #d4d4d4;
}
.autocomplete-items div:hover {
  /*when hovering an item:*/
  background-color: #e9e9e9;
}

.autocomplete-active {
  background-color: DodgerBlue !important;
  color: #ffffff;
}
    
</style>

<jsp:include page="head.jsp">
	<jsp:param name="page" value="Search"/>
</jsp:include>

<body>
	<jsp:include page="navbar.jsp" flush="true"/>
	
	<div class="container content">
		<div class="row page-title">
			<div class="col-12">
				<h1>Dashboard Search</h1>
			</div>
		</div>
		<div class="section">
			<div class="row justify-content-center">
				<div class="col-12 col-sm-10">
					<div id="search_table_section">
						<div style="text-align:center; margin-bottom:30px;">
							<div class="form-check form-check-inline analysis">
	  							<input name="dash_type" class="form-check-input filter" type="checkbox" id="inlineCheckbox1" value="analysis">
	  							<label class="form-check-label" for="inlineCheckbox1"><i class="fas fa-chart-pie"></i>  Analysis</label>
							</div>
							<div class="form-check form-check-inline overview">
	  							<input name="dash_type" class="form-check-input filter" type="checkbox" id="inlineCheckbox2" value="overview">
	  							<label class="form-check-label" for="inlineCheckbox2"><i class="fas fa-database"></i>  Data Overview</label>
							</div>
							<div class="form-check form-check-inline about">
	 							<input name="dash_type" class="form-check-input filter" type="checkbox" id="inlineCheckbox3" value="about">
	  							<label class="form-check-label" for="inlineCheckbox3"><i class="fas fa-info-circle"></i>  N3C About</label>
							</div>
						</div>
						<div id="search-list" class="text-max mx-auto"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	

	<jsp:include page="footer.jsp" flush="true" />
	
</body>
<script>

function getUrlVars() {
    var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for(var i = 0; i < hashes.length; i++)
    {
        hash = hashes[i].split('=');
        vars.push(hash[0]);
        vars[hash[0]] = hash[1];
    }
    if (vars['search']){
    	return vars;
    } else{
    	return {search : ''};
    }
} 

$(document).ready( function () {
	$.getJSON("<util:applicationRoot/>/search/dashboard_feed.jsp", function(data){
		
		// search autocomplete /////////////////////////////////////////////////////////////////////
		<jsp:include page="search/term_feed.jsp" flush="true" />
		
		// from w3 schools autocomplete
		function autocomplete(inp, arr) {
			  /*the autocomplete function takes two arguments,
			  the text field element and an array of possible autocompleted values:*/
			  var currentFocus;
			  /*execute a function when someone writes in the text field:*/
			  inp.addEventListener("input", function(e) {
			      var a, b, i, val = this.value;
			      /*close any already open lists of autocompleted values*/
			      closeAllLists();
			      if (!val) { return false;}
			      currentFocus = -1;
			      /*create a DIV element that will contain the items (values):*/
			      a = document.createElement("DIV");
			      a.setAttribute("id", this.id + "autocomplete-list");
			      a.setAttribute("class", "autocomplete-items");
			      /*append the DIV element as a child of the autocomplete container:*/
			      this.parentNode.appendChild(a);
			      /*for each item in the array...*/
			      for (i = 0; i < arr.length; i++) {
			        /*check if the item starts with the same letters as the text field value:*/
			        if (arr[i].substr(0, val.length).toUpperCase() == val.toUpperCase()) {
			          /*create a DIV element for each matching element:*/
			          b = document.createElement("DIV");
			          /*make the matching letters bold:*/
			          b.innerHTML = "<strong>" + arr[i].substr(0, val.length) + "</strong>";
			          b.innerHTML += arr[i].substr(val.length);
			          /*insert a input field that will hold the current array item's value:*/
			          b.innerHTML += "<input type='hidden' value='" + arr[i] + "'>";
			          /*execute a function when someone clicks on the item value (DIV element):*/
			              b.addEventListener("click", function(e) {
			              /*insert the value for the autocomplete text field:*/
			              inp.value = this.getElementsByTagName("input")[0].value;
			              /*close the list of autocompleted values,
			              (or any other open lists of autocompleted values:*/
			              closeAllLists();
			          });
			          a.appendChild(b);
			        }
			      }
			  });
			  /*execute a function presses a key on the keyboard:*/
			  inp.addEventListener("keydown", function(e) {
			      var x = document.getElementById(this.id + "autocomplete-list");
			      if (x) x = x.getElementsByTagName("div");
			      if (e.keyCode == 40) {
			        /*If the arrow DOWN key is pressed,
			        increase the currentFocus variable:*/
			        currentFocus++;
			        /*and and make the current item more visible:*/
			        addActive(x);
			      } else if (e.keyCode == 38) { //up
			        /*If the arrow UP key is pressed,
			        decrease the currentFocus variable:*/
			        currentFocus--;
			        /*and and make the current item more visible:*/
			        addActive(x);
			      } else if (e.keyCode == 13) {
			        /*If the ENTER key is pressed, prevent the form from being submitted,*/
			        e.preventDefault();
			        if (currentFocus > -1) {
			          /*and simulate a click on the "active" item:*/
			          if (x) x[currentFocus].click();
			        }
			      }
			  });
			  function addActive(x) {
			    /*a function to classify an item as "active":*/
			    if (!x) return false;
			    /*start by removing the "active" class on all items:*/
			    removeActive(x);
			    if (currentFocus >= x.length) currentFocus = 0;
			    if (currentFocus < 0) currentFocus = (x.length - 1);
			    /*add class "autocomplete-active":*/
			    console.log(x[currentFocus]);
			    console.log(x);
			    console.log(currentFocus);
			    x[currentFocus].classList.add("autocomplete-active");
			  }
			  function removeActive(x) {
			    /*a function to remove the "active" class from all autocomplete items:*/
			    for (var i = 0; i < x.length; i++) {
			      x[i].classList.remove("autocomplete-active");
			    }
			  }
			  function closeAllLists(elmnt) {
			    /*close all autocomplete lists in the document,
			    except the one passed as an argument:*/
			    var x = document.getElementsByClassName("autocomplete-items");
			    for (var i = 0; i < x.length; i++) {
			      if (elmnt != x[i] && elmnt != inp) {
			      x[i].parentNode.removeChild(x[i]);
			    }
			  }
			}
			/*execute a function when someone clicks in the document:*/
			document.addEventListener("click", function (e) {
			    closeAllLists(e.target);
			});
		}


		
		var searchTerm =decodeURIComponent(getUrlVars()['search'].replaceAll('+',' '));
		var json = $.parseJSON(JSON.stringify(data));
	
		var col = [];
	
		for (i in json['headers']){
			col.push(json['headers'][i]['label']);
		}
	
	
		var table = document.createElement("table");
		table.className = 'table table-hover table-expand';
		table.style.width = '100%';
		table.style.textAlign = "left";
		table.id="search_table";
	
		var header= table.createTHead();
		var header_row = header.insertRow(0); 
	
		for (i in col) {
			var th = document.createElement("th");
			th.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;">' + col[i].toString() + '</span>';
			header_row.appendChild(th);
		}
	
		var divContainer = document.getElementById("search-list");
		divContainer.innerHTML = "";
		divContainer.appendChild(table);
	
		var data = json['rows'];
	
		var search_datatable = $('#search_table').DataTable( {
	    	data: data,
	    	search: {
	            search: searchTerm,
	        },
	       	paging: true,
	       	dom: 'lfr<"datatable_overflow"t>ip',
	       	language: {
	            searchPlaceholder: "title, keyword, description ..."
	        },
	    	pageLength: 5,
	    	drawCallback: function( settings ) {$("#search_table thead").remove(); } ,
	    	lengthMenu: [ 5, 10, 25, 50, 75, 100 ],
	    	order: [[2, 'asc']],
	     	columns: [
	     		{ data: 'dashboard_id', 
	     			orderable: false,
	     			className: 'noExport',
	     			render: function ( data, type, row ) {
	     				var id = row.dashboard_id;
	        			var title = row.dashboard_name;
	        			var desc = row.dashboard_short_desc;
	        			var url = row.dashboard_url;
	        			var image = row.image;
	        			var type = row.type;
	        			
	        			var list = type.split(",");
	        			var icons = '';
	        			
	        			for (i in list){
	        				var icon_code = ' <span class="icon' + list[i].trim() + '"></span>';
	        				icons = icons + icon_code;
	        			}
	        			
	        			var combo = 
	        				'<div class="row"><div class="col-4"><img src="<util:applicationRoot/>/dashboard_descriptions/displayDashboardThumbnail.jsp?did='
	        				+ id
	        				+'" class="card-img-top" alt="..."></div><div class="col-8"><p class="mb-3 title">'
	        				+ title 
	        				+ '</p> <p>'
	        				+ desc
	        				+ '</p><div>'
	        				+ icons 
	        				+ '<div class="float-right"><a href="<util:applicationRoot/>/'
	            				+ url
	            				+ '" >Explore&#8196;<i class="fas fa-angle-right"></i></a></div>'
	        				+'</div></div></div>';
	             		return combo; }
	     		},
	        	{ data: 'tags', visible: false },
	        	{ data: 'dashboard_name', visible: false },
	        	{ data: 'dashboard_url', visible: false },
	        	{ data: 'dashboard_short_desc', visible: false },
	        	{ data: 'image', visible: false },
	        	{ data: 'type', visible: false}
	    	]
		} );
	
		
	
	
		// table search logic - replaces history with newest search term
		search_datatable.on( 'search.dt', function () {
			var currentUrl = window.location.href;
	  		var url = new URL(currentUrl);
	  		var search = $('.dataTables_filter input').val();
	  		url.searchParams.set("search", search);
	  		var newUrl = url.href; 
	  		console.log(newUrl);
	  		history.replaceState(null, '', newUrl);
		} );
		
		search_datatable.on( 'draw.dt', function () {
			$('#search_table_filter label input').attr ('id', 'dashboard-search');
			autocomplete(document.getElementById("dashboard-search"), keywords);
			search_datatable.off( 'draw.dt' );
		} );
	
	});
	
	$.fn.dataTable.ext.search.push(
		function( settings, searchData, index, rowData, counter ) {
			var positions = $('#search_table_section input:checkbox[name="dash_type"]:checked').map(function() {
				return this.value;
			}).get();
		   
			var list = searchData[6].split(",");
			if (positions.length === 0) {
				return true;
			}
			for (i in list){
				if (positions.indexOf(list[i].trim()) !== -1) {
					return true;
				}
			}
			return false;

		}
	);
	  
	$('#search_table_section input:checkbox').on('change', function () {
		$('#search_table').DataTable().draw();
	});
});





</script>
</html>
