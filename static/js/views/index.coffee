Ext.ns('FSC.views')

FSC.views.Index = Ext.extend(Ext.TabPanel,
  constructor: (cfg = {}) ->
    cfg = Ext.applyIf(cfg,
      activeItem: 0
      items:
        cls: 'playset-index'
        grouped: true
        indexBar: true
        itemTpl: '{title}'
        listeners:
          itemtap: (view, index) ->
            record = @store.getAt(index)

            panel = new FSC.views.Show(
              record: record
            )
            @add(panel)
            @setActiveItem(panel)
          scope: @
        store: 'playsets'
        title: 'Playsets'
        xtype: 'list'
      layout: 'card'
      store: Ext.StoreMgr.get('playsets')
    )
    FSC.views.Index.superclass.constructor.call(@, cfg)
    Ext.StoreMgr.get('playsets').sort()
    @on('cardswitch', (container, newCard, oldCard, index) ->
      if index is 0
        @remove(oldCard, true)
    , @)
  grouped: true
  indexBar: true
)
