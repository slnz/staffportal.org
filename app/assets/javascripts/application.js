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
	summer_note.summernote({
		height: 300,
		toolbar: [["table", ["table"]], ["style", ["style"]], ["fontsize", ["fontsize"]], ["color", ["color"]], ["style", ["bold", "italic", "underline", "clear"]], ["para", ["ul", "ol", "paragraph"]], ["height", ["height"]], ["help", ["help"]]]
	});

	$.each(summer_note, function(key, value) {
		$( value ).code($( value ).val());
	});

	summer_note.first().closest('form').submit(function() {
		$.each(summer_note, function(key, value) {
			$( value ).val($( value ).code()[0]);
		});
		return true;
	});

});
