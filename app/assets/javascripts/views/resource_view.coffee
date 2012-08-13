Rollapi.ResourceView = Ember.View.extend
  templateName: 'resource'
  validateUrl: (event) ->
    @controller.validate('url')

  search: (event) ->
    controller = event.view.get('controller')

    if controller.isValid()
      $.ajax
        url: '/search'
        data: controller.serializeForm()
        dataType: 'json'
        type: 'post'
        success: (response) ->
          controller.get('content').setProperties(response)
