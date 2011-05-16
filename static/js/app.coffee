$(document).ready ->

  $('#new_playset').submit ->
    json = $(this).toObject '.', false
    $.ajax
      type: 'POST'
      url: '/playsets'
      data: JSON.stringify json
      success: ->
        return
      dataType: 'json'
    false
  
  $('#search').submit ->
    window.location.href = '/playsets/tagged/' + $('.tags', this).val().replace(/[^a-z0-9-_ ]/gi, '')
    false