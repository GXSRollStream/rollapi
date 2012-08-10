Rollapi.ResourceController = Ember.ObjectController.extend({
  targetTypes: [
    Ember.Object.create({label: "GET", value: 'get'}),
    Ember.Object.create({label: "POST", value: 'post'})
  ],
  targetKinds: [
    Ember.Object.create({label: "Comapny", value: 'company'}),
    Ember.Object.create({label: "Conatct", value: 'contact'})
  ]
});
