Rollapi.ResourceFieldFocusOut = Ember.Mixin.create
  field: null
  focusOut: (event) ->
    controller = @.get('parentView.controller')
    controller["validate#{Em.String.classify(@.get('field'))}"]()
