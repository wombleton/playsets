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
      vals = ["<h1>#{_(property).capitalize()}</h1>", "<h2>#{i + 1} #{val.name}</h2>", '<ul>']
      _.each(val.values, (v, i) ->
        vals.push("<li><img src=\"/images/dice-#{i + 1}.png\"> #{v}</li>")
      )
      vals.push('</ul>')
      vals.join('')
    )
    items.join('')
)
