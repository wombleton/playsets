$(document).ready ->
  $('#search').submit ->
    window.location.href = '/playsets/tagged/' + $('.tags', this).val().replace(/[^a-z0-9-_ ]/gi, '')
    false