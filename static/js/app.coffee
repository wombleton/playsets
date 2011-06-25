Ext.application
  name: 'HelloExt'
  launch: ->
    Ext.create 'Ext.panel.Panel',
      html: 'hi'
      renderTo: 'header'