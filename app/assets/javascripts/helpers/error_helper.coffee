Handlebars.registerHelper 'errorHelper', (property, options) ->
  value = Ember.Handlebars.getPath(this, property, options)
  new Handlebars.SafeString('<span class="help-inline">'+value+'</span>');
