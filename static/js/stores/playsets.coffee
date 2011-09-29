new Ext.data.Store(
  getGroupString: (record) ->
    record.get('title')[0].toUpperCase()
  model: 'Playset'
  sorters: [
    {
      property: 'title'
    }
  ]
  sortOnLoad: true
  storeId: 'playsets'
)
