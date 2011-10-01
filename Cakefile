fs     = require 'fs'
{exec} = require 'child_process'

files = [
  'models/playset'
  'stores/playsets'
  'playsets/main-st'
  'playsets/boomtown'
  'views/index'
  'views/show'
  'views/splash'
  'views/instant_setup'
  'views/list'
  'app'
]

task 'build', 'Build single application file from source files', ->
  appContents = new Array remaining = files.length
  for file, index in files then do (file, index) ->
    fs.readFile "static/js/#{file}.coffee", 'utf8', (err, fileContents) ->
      throw err if err
      appContents[index] = fileContents
      process() if --remaining is 0
  process = ->
    fs.writeFile 'static/js/playsets.coffee', appContents.join('\n\n'), 'utf8', (err) ->
      throw err if err
      exec 'coffee --compile static/js/playsets.coffee', (err, stdout, stderr) ->
        throw err if err
        console.log stdout + stderr
        fs.unlink 'static/js/playsets.coffee', (err) ->
          throw err if err
          console.log 'Done.'

task 'minify', 'Minify the resulting application file after build', ->
  exec 'uglifyjs -o static/js/playsets.min.js static/js/playsets.js', (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr
