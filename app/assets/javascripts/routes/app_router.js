Rollapi.Router = Ember.Router.extend({
  location: 'hash',

  root: Ember.Route.extend({
    index: Ember.Route.extend({
      route: '/',
      redirectsTo: 'resources.new'

      // You'll likely want to connect a view here.
      // connectOutlets: function(router) {
      //   router.get('applicationController').connectOutlet(App.MainView);
      // }

      // Layout your routes here...
    })
  }),
  resources: Ember.Route.extend({
    route: 'resources',
    new: Ember.Route.extend({
      route: '/new',

       connectOutlets: function(router) {
         var transaction = router.get('store').transaction();
         var resource = transaction.createRecord(Rollapi.Resource);

         router.
           get('applicationController').
           connectOutlet('resource', resource )

         router.get('resourceController').set('transaction', transaction);
        },
        submitSearch: function(router, event) {
          console.log(event.view.get('context.url'))
          router.get('resourceController.transaction').commit();
        }
    })
  })
});

