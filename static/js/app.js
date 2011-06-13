(function() {
  $(document).ready(function() {
    $('#search').submit(function() {
      window.location.href = '/playsets/tagged/' + $('.tags', this).val().replace(/[^a-z0-9-_ ]/gi, '');
      return false;
    });
    return $('.header .txt').focus();
  });
}).call(this);
