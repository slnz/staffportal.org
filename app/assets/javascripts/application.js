//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require cocoon
//= require jquery-ui/autocomplete
//= require s3_direct_upload
//= require chosen-jquery
//= require gmaps-auto-complete
//= require nprogress
//= require nprogress-turbolinks
//= require highcharts
//= require highcharts/highcharts-more
//= require bootstrap
//= require bootstrap-datepicker
//= require summernote
//= require simple-slider.min
//= require accounts
//= require gma
//= require reviews
//= require documents
//= require turbolinks
//= require_self
this.chosenify = function(entry) {
  return entry.chosen({
    allow_single_deselect: true
  });
};

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
			$( value ).val($( value ).code());
		});
		return true;
	});

	chosenify($(".chosen"));

	$('.datepicker').datepicker();

	$('[rel=tooltip]').tooltip();

	NProgress.configure({
	  showSpinner: false,
	  ease: 'ease',
	  speed: 500
	});
});
