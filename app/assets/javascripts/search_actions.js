$(document).ready(function(e){
	// Assign drop down values for search parameter
    $('.search-panel .dropdown-menu').find('a').click(function(e) {
		e.preventDefault();
		var param = $(this).attr("href").replace("#","");
		var concept = $(this).text();
		$('.search-panel span#search_concept').text(concept);
		$('.input-group #search_param').val(param);
	});

    // Ajax call to update search results
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
		    	$('#search_results_container').html(data);
		    	search.addRowClickListener();
		    	search.focusSearchTab($("#search_form #search_param").val());		    	
		    },    	
		    error: function(error){
		    	$('#search_error').html("<div class='alert alert-danger'>"+ "Error during search. Please enter another search term." +"</div>");
		    }
		});
	});
});


var search = {
	// Populate modal to view search result details
	addRowClickListener: function() {
		$('#search_results_container table tbody tr.info-detail-src').unbind();
		$('#search_results_container table tbody tr.info-detail-src').click(function(e){
			var modalBody = $(this).next().find(".info-detail-target").html();
			$("#searchDetailsModal .modal-body").html(modalBody);
			$("#searchDetailsModal").modal();
		});
	},

	// Highlights the current tab on focus - for Users, Organizations or Tickets.
	// It focuses on Tickets if search parameter 'All' is selected
	focusSearchTab: function(search_param) {
		if (search_param == "all")
    		$("#tickets_tab a").click();
    	else
    		$("#"+search_param+"_tab a").click();
	}
};