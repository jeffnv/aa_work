GistApp.Collections.Gists = Backbone.Collection.extend({

  model: GistApp.Models.Gist,
  url: "/gists"

});
