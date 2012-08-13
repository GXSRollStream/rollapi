Rollapi.ResourceController = Ember.ObjectController.extend
  groupClass: 'control-group'
  requestMethods: [
    Ember.Object.create({label: "Find", value: 'find'}),
    Ember.Object.create({label: "Search", value: 'search'})
    Ember.Object.create({label: "Create", value: 'create'})
    Ember.Object.create({label: "Update", value: 'update'})
  ],
  requestOwners: [
    Ember.Object.create({label: "Comapny", value: 'company'}),
    Ember.Object.create({label: "Conatct", value: 'contact'})
  ]

  formattedResult: (->
    vkbeautify.xml(@.get('response_body'))
  ).property('response_body')

  result: (->
    switch @.get('response_code')
      when 200 then 'Success'
      when 401 then 'Authentication Error'
      when 404 then 'Resource Not Found'
  ).property 'response_code'

  resultClass: (->
    switch @.get('response_code')
      when 200 then 'label-success'
      when 401, 404 then 'label-important'
  ).property 'response_code'

  needId: (->
    @.get('request_method') in ['find', 'update']
  ).property('request_method')

  needBody: (->
    @.get('request_method') in ['search', 'create', 'update']
  ).property('request_method')


  validateUser: ->
      @.set('validatedUser', true)

      unless @.validatePresence('user') 
        error = "Required"
      @.set("userError", error)

  validatePassword: ->
      @.set('validatedPassword', true)

      unless @.validatePresence('password') 
        error = "Required"
      @.set("passwordError", error)

  validateUrl: ->
      @.set('validatedUrl', true)

      unless @.validatePresence('url') 
        error = "Required"
      @.set("urlError", error)
  isNumber: (o) ->
    ! isNaN (o-0) && o != null
  validateRequestId: ->
    @.set('validatedRequestId', true)

    if @.get('needId') 
      if !@.validatePresence('request_id')
        error = "Required"
      else if !@.isNumber(@.get('request_id'))
        error = "Not a number"

    @.set("requestIdError", error)

  validateBody: ->
    @.set('validatedBody', true)

    if @.get('needBody') and !@.validatePresence('body')
      error = "Required"

    @.set("bodyError", error)

  anyErrors: ->
    errorFields = ['user', 'password', 'url', 'body', 'requestId']
    errorFields.find (item) => 
      @.validatePresence("#{item}Error")

  validatePresence: (prop) ->
    !!@.get(prop)

  isValid: ->
    @.validateUrl()
    @.validateUser()
    @.validatePassword()
    @.validateBody()
    @.validateRequestId()
    !@.anyErrors()

  params: ['url', 'user', 'password', 'request_id', 'request_owner', 'request_method', 'body'] 
  serializeForm: ->
    resource: @.getProperties(@.get('params'))
