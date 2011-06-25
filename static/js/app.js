(function() {
  Ext.application({
    name: 'HelloExt',
    launch: function() {
      return Ext.create('Ext.panel.Panel', {
        html: 'hi',
        renderTo: 'header'
      });
    }
  });
}).call(this);
