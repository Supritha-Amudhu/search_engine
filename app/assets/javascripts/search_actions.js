$(document).ready(function(e){
    $('#menu_types').click(function(e) {
    	// alert("Does this work ?");
		e.preventDefault();
		var param = $(this).attr("href").replace("#","");
		var concept = $(this).text();
		$('.search-panel span#search_concept').text(concept);
		$('.input-group #search_param').val(param);
	});	

	$('#search_button').click(function(e) {
		e.preventDefault();
		var formData = $('#search_form').serialize();
		$.ajax({
		    type: 'GET',
		    url: $('#search_form').attr('action'),
		    dataType: 'text',
		    contentType: "application/json",
		    data: formData,
		    success: function(data){
		    	// alert("Success !! \n" + data);
		    	$('#search_results_container').html(data);
		    	// $('#search_results_container').html("<%= render :partial => 'search_results', :locals => { :search_results => data} %>");
		    },    	
		    error: function(error){
		    	alert("Search not successful ! \n" + error.responseText);
		    }
		});
	});
});