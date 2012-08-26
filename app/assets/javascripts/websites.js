$(document).ready(function(){
	$("#create_website_form").validate();
	if($("#submission_errors").children().size() == 0){
		$("#submission_errors").remove();
	}
});
