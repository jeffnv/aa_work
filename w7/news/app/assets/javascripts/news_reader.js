window.NewsReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    NewsReader.feeds = new NewsReader.Collections.Feeds();
    NewsReader.feeds.fetch({
      success: function(){
        NewsReader.router = new NewsReader.Routers.NewsRouter();
        Backbone.history.start();        
      },
    })

    
  }
};


