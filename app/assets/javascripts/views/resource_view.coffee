Rollapi.ResourceView = Ember.View.extend
  templateName: 'resource'
  request: (event) ->
    controller = event.view.get('controller')
    controller.set('newResponse', false)
    
  search: (event) ->
    controller = event.view.get('controller')
    if controller.isValid()
      $.ajax
        url: '/search'
        data: controller.serializeForm()
        dataType: 'json'
        type: 'post'
        success: (response) ->
          controller.set('newResponse', true)
          controller.get('content').setProperties(response)
