Ext.ns('FSC.views')
FSC.views.Show = Ext.extend(Ext.TabPanel,
  constructor: (cfg = {}) ->
    record = cfg.record
    items = []
    instant_setup = new FSC.views.InstantSetup(record)
    relationships = new FSC.views.List(record, 'relationships', 'people')
    needs = new FSC.views.List(record, 'needs')
    locations = new FSC.views.List(record, 'locations', 'places')
    objects = new FSC.views.List(record, 'objects', 'stuff')
    cfg = Ext.applyIf(cfg,
      items: [
        needs
        relationships
        locations
        objects
        instant_setup
      ]
      tabBarDock: 'bottom'
      title: record.get('title')
    )
    FSC.views.Show.superclass.constructor.call(@, cfg)
)
