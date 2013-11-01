NewsReader.Collections.Feeds = Backbone.Collection.extend({
  url: '/feeds',
  model: NewsReader.Models.Feed
});