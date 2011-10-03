Ext.ns('FSC.views')

FSC.views.List = Ext.extend(Ext.Panel,
  constructor: (record, property, title = property) ->
    cfg =
      iconCls: property
      items:
        grouped: true
        itemTpl: '<div class="playset-item"><div class="dice-roll dice-roll-{index}"></div><div class="item-text">{text}</div></div>'
        singleSelect: true
        store: @createStore(record, property)
        xtype: 'list'
      layout: 'fit'
      title: _(title).capitalize()
    FSC.views.List.superclass.constructor.call(@, cfg)
  createStore: (record, property) ->
    store = new FSC.data.ItemStore()
    _.each(record.get(property), (val, i) ->
      group = "#{i + 1} #{val.name}"

      _.each(val.values, (v, i) ->
        store.add(
          group: group
          index: i + 1
          text: v
        )
      )
    )
    store
)
