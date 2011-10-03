Ext.ns('FSC.views')
FSC.views.InstantSetup = Ext.extend(Ext.Panel,
  constructor: (record) ->
    cfg =
      cls: 'instant-setup'
      iconCls: 'instant'
      items: [
        {
          label: 'Players'
          labelAlign: 'top'
          maxValue: 5
          minValue: 3
          value: 3
          xtype: 'sliderfield'
        }
      ]
      title: 'Setup'
    FSC.views.InstantSetup.superclass.constructor.call(@, cfg)
)
