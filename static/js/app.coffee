Ext.setup(
  tabletStartupScreen: 'tablet_startup.png'
  phoneStartupScreen: 'tablet_startup.png'
  icon: 'icon.png'
  glossOnIcon: true
  onReady: ->
    new FSC.views.Index(
      fullscreen: true
    )
)
