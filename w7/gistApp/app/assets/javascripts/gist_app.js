window.GistApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    //set up collection
    GistApp.gists = new GistApp.Collections.Gists();
    GistApp.gists.fetch({success: function(){
      GistApp.router = new GistApp.Routers.GistRouter();
      Backbone.history.start();
    }});

  }
};
