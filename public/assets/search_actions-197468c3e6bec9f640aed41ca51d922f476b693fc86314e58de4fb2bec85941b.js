$(document).ready(function(e){
    $('.search-panel .dropdown-menu').click(function(e) {
    	alert("Does this work ?");
		e.preventDefault();
		var param = $(this).attr("href").replace("#","");
		var concept = $(this).text();
		$('.search-panel span#search_concept').text(concept);
		$('.input-group #search_param').val(param);
	});	

	$('#search_button').click(function(e) {
		e.preventDefault();
		alert("This works !");
		var formData = $('#search_form').serialize();
		$.ajax({
		    type: 'GET',
		    url: $('#search_form').attr('action'),
		    dataType: 'JSON',
		    data: formData,
		    success: function(data){
		    	alert("Success");
		    	alert(data.search_results);
		    }    	
		    error: function(){
		    	alert("Search not successful !");
		    }
		});
	});
});
