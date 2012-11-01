$(document).ready(function() {
  if ( controller == "accounts" ) {
    $('tr.expandable').click(function() {
      $(this).toggleClass('closed');
      $(this).next().show().find('td div.bd').slideToggle(200, function () { if (!$(this).is(':visible')) $(this).closest('tr').hide(); });
    });
  }
});
