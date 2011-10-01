Ext.ns('FSC.views')

FSC.views.List = Ext.extend(Ext.Panel,
  constructor: (record, property) ->
    cfg =
      cls: 'playset-list'
      html: @unroll(record, property)
      scroll: 'vertical'
    FSC.views.List.superclass.constructor.call(@, cfg)
  unroll: (record, property) ->
    items = _.map(record.get(property), (val, i) ->
      vals = ["<h2>#{i + 1} #{val.name}</h2>", '<ul class="list">']
      _.each(val.values, (v, i) ->
        vals.push("<li><div class=\"dice_#{i + 1}\"></div><div class=\"message\">#{v}</div></li>")
      )
      vals.push('</ul>')
      vals.join('')
    )
    "<h1>#{_(property).capitalize()}</h1>#{items.join('')}"
)
