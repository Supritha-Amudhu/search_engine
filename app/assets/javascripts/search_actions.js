$(document).ready(function(e){

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
		    	search.focusSearchTab();		    	
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
	focusSearchTab: function() {
		var search_field = $("#search_form #ticketSearchField").val();
    	if (search_field != "none")
    		$("#tickets_tab a").click();
    	else {
    		search_field = $("#search_form #userSearchField").val();
    		if (search_field != "none")
    			$("#users_tab a").click();
    		else {
				search_field = $("#search_form #organizationSearchField").val();
				if (search_field != "none")
					$("#organizations_tab a").click();
			}
    	}
	}
};