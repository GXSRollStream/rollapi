Rollapi.Resource = DS.Model.extend({
  body: DS.attr('string'),
  url: DS.attr('string'),
  user: DS.attr('string'),
  response: DS.attr('string'),
  apiKey: DS.attr('string'),
  password: DS.attr('string'),
  targetType: DS.attr('string'),
  targetId: DS.attr('string'),
  targetKind: DS.attr('string')
});
