(function() {
  $('#new_playset').live('submit', function() {
    var elements;
    elements = $(this).serializeArray();
    debugger;
    return false;
  });
  $('#search').submit(function() {
    window.location.href = '/playsets/tagged/' + $('.tags', this).val().replace(/[^a-z0-9-_ ]/gi, '');
    return false;
  });
}).call(this);
