(function() {
  $(document).ready(function() {
    return $('#search').submit(function() {
      window.location.href = '/playsets/tagged/' + $('.tags', this).val().replace(/[^a-z0-9-_ ]/gi, '');
      return false;
    });
  });
}).call(this);
