//= require jquery
//= require jquery_ujs
//= require highcharts
//= require highcharts/highcharts-more
//= require bootstrap
//= require summernote
//= require accounts
//= require_self

$(function() {
	var summer_note;
	summer_note = $('.summernote');
	return summer_note.summernote({
		height: 300,
		toolbar: [["table", ["table"]], ["style", ["style"]], ["fontsize", ["fontsize"]], ["color", ["color"]], ["style", ["bold", "italic", "underline", "clear"]], ["para", ["ul", "ol", "paragraph"]], ["height", ["height"]], ["help", ["help"]]]
	});


	summer_note.code(summer_note.val());

	summer_note.closest('form').submit(function() {
		summer_note.val(summer_note.code()[0]);
		return true;
	});

});
