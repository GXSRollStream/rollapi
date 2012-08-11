Rollapi.ResourceView = Ember.View.extend
  templateName: 'resource'
  submitSearch: ->
    if @.get('controller').isValid()
      @.get('controller.target.store').commit()
