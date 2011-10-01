Ext.ns('FSC.views')
FSC.views.Show = Ext.extend(Ext.Carousel,
  constructor: (cfg = {}) ->
    record = cfg.record
    items = []
    splash = record.get('splash')
    splash_page = new FSC.views.Splash(splash) if splash
    instant = record.get('instant_setup')
    instant_setup = new FSC.views.InstantSetup(instant) if instant
    relationships = new FSC.views.List(record, 'relationships')
    needs = new FSC.views.List(record, 'needs')
    locations = new FSC.views.List(record, 'locations')
    objects = new FSC.views.List(record, 'objects')
    cfg = Ext.applyIf(cfg,
      items: _.compact([
        splash_page
        relationships
        needs
        locations
        objects
        instant_setup
      ])
      title: record.get('title')
    )
    FSC.views.Show.superclass.constructor.call(@, cfg)
)
