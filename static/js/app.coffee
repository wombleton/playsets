$(document).ready ->
  $('#new_playset').submit ->
    json = $(this).toObject '.', false
    $.ajax
      type: 'POST'
      url: '/playsets'
      contentType: 'application/json'
      data: JSON.stringify json
      headers:
        'Content-Type': 'application/json'
      failure: ->
        alert('did not work')
      success: ->
        debugger
      dataType: 'json'
    false
  $('#search').submit ->
    window.location.href = '/playsets/tagged/' + $('.tags', this).val().replace(/[^a-z0-9-_ ]/gi, '')
    false