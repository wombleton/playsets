FSC.views.Splash = Ext.extend(Ext.Panel,
  constructor: (img) ->
    FSC.views.Splash.superclass.constructor.call(@,
      cls: 'splash-page'
      html: """
        <img class="background" src="/images/#{img}">
        <img class="swipe" src="/images/swipe.png">
      """
    )
)
