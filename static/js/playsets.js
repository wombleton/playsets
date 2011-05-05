(function($) {
  var previewTimeout;
  
  function updatePreview(form) {
    $.ajax({
      type: 'POST',
      data: $(form).serialize(),
      success: function(res) {
        $('#preview').html(res);
        $('input.save')[0].disabled = $('.errors').length > 0;
      },
      url: '/preview'
    });
  }
  
  $('.definition textarea, .condition input').live('keyup', function() {
    var form = $(this).parents('form');
    if (previewTimeout) {
      clearTimeout(previewTimeout);
      delete previewTimeout;
    }
    previewTimeout = setTimeout(function() {
      updatePreview(form);
    }, 500);
  });
  
  $(document).ready(function() {
    $('#search').submit(function() {
      window.location.href = '/moves/tagged/' + $('.tags', this).val().replace(/[^a-z0-9-_ ]/gi, '');
      return false;
    });
    $('.condition input').focus();
  });
}(jQuery))