$(document).ready(function(e){
    $('.search-panel .dropdown-menu').find('a').click(function(e) {
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
		    },    	
		    error: function(error){
		    	alert("Search not successful ! \n" + error.responseText);
		    }
		});
	});
});