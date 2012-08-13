//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require handlebars
//= require ember
//= require ember-data
//= require_self
//= require rollapi
//= require vkbeautify

Rollapi = Ember.Application.create({
  rootElement: '.container'
});

//= require_tree .
