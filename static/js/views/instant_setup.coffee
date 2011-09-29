Ext.ns('FSC.views')
FSC.views.InstantSetup = Ext.extend(Ext.Panel,
  constructor: (html) ->
    FSC.views.InstantSetup.superclass.constructor.call(@,
      cls: 'instant-setup'
      html: html
    )
)
