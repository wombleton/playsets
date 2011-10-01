Ext.ns('FSC.data')

FSC.data.ItemStore = Ext.extend(Ext.data.ArrayStore,
  constructor: (cfg = {}) ->
    cfg = Ext.applyIf(cfg,
      model: 'Item'
    )
    FSC.data.ItemStore.superclass.constructor.call(@, cfg)
  getGroupString: (record) ->
    record.get('group')
  sorters: [
    {
      property: 'text'
    }
  ]
)
