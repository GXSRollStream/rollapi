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
  fields: [ 'url', 'user', 'password'] 
  result: (->
    switch @.get('responseCode')
      when '200' then 'Success'
      when '401' then 'Authentication Error'
  ).property 'responseCode'
  resultClass: (->
    switch @.get('responseCode')
      when '200' then 'label-success'
      when '401' then 'label-important'
  ).property 'responseCode'
  anyErrors: ->
    @.get('fields').find (item) => 
      @.validatePresence("#{item}Error")

  validateRequired: ->
    @.get('fields').forEach (item) => 
      unless @.validatePresence(item) 
        error = "Required"
      @.set("#{item}Error", error)

  validatePresence: (prop) ->
    !Em.none(@.get(prop))

  isValid: ->
    @.validateRequired()
    !@.anyErrors()