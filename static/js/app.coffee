Ext.setup(
  tabletStartupScreen: 'fiasco.svg'
  phoneStartupScreen: 'fiasco.svg'
  icon: 'icon.png'
  glossOnIcon: true
  onReady: ->
    new FSC.views.Index(
      fullscreen: true
    )
)
