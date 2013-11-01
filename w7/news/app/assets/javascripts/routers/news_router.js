NewsReader.Routers.NewsRouter = Backbone.Router.extend({
  routes: {
    "": "feedsIndex",
    "feeds/:id": "showFeed",
  },
  
  feedsIndex: function(){
    var indexView = new NewsReader.Views.FeedsIndex({
      collection: NewsReader.feeds
    });
    this._swapView(indexView);
  },
  
  showFeed: function(id){
    var showFeedView = new NewsReader.Views.ShowFeed({
      model: NewsReader.feeds.get(id)
    });
    
    this._swapView(showFeedView);
  },
  
  _swapView: function(newView){
    if(this.currentView){
      this.currentView.close();
    }
    
    this.currentView = newView;
    $('#content').html(this.currentView.render().$el);
  },
});