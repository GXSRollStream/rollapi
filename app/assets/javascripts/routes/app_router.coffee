Rollapi.Router = Ember.Router.extend
  location: 'hash'
  root: Ember.Route.extend
    index: Ember.Route.extend
      route: '/'
      redirectsTo: 'resources.create'

    resources: Ember.Route.extend
      route: 'resources'
      index: Ember.Route.extend
        route: '/'
        connectOutlets: (router) ->
           router.
             get('applicationController').
             connectOutlet 'resource', Rollapi.Resource.find()

      create: Ember.Route.extend
        route: '/new'
        connectOutlets: (router) ->
           resource = router.
             get('store').
             createRecord(Rollapi.Resource)

           router.
             get('applicationController').
             connectOutlet('resource', resource)
