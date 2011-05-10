$('#new_playset').live 'submit', ->
  elements = $(this).serializeArray()
  debugger
  false

$('#search').submit ->
  window.location.href = '/playsets/tagged/' + $('.tags', this).val().replace(/[^a-z0-9-_ ]/gi, '')
  false