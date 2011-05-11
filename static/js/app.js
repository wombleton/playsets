(function() {
  $(document).ready(function() {
    $('#new_playset').submit(function() {
      var json;
      json = $(this).toObject('.', false);
      $.ajax({
        type: 'POST',
        url: '/playsets',
        data: JSON.stringify(json),
        success: function() {
          return alert('!');
        },
        dataType: 'json'
      });
      return false;
    });
    return $('#search').submit(function() {
      window.location.href = '/playsets/tagged/' + $('.tags', this).val().replace(/[^a-z0-9-_ ]/gi, '');
      return false;
    });
  });
}).call(this);
