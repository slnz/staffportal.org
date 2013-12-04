//= require active_admin/base
//= require chosen-jquery

this.chosenify = function(entry) {
  return entry.chosen({
    allow_single_deselect: true
  });
};

$(function() {
  chosenify($(".chosen"));
  return $("form.formtastic .inputs .has_many").click(function() {
    return $(".chosen").chosen({
      allow_single_deselect: true
    });
  });
});
