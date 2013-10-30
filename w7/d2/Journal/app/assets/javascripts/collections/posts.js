Journal.Collections.Posts = Backbone.Collection.extend({
  url: '/posts',
  model: Journal.Models.Post
})