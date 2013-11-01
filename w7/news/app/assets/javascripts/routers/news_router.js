NewsReader.Routers.NewsRouter = Backbone.Router.extend({
  routes: {
    "": "feedsIndex"
  },
  
  feedsIndex: function(){
    var indexView = new NewsReader.Views.FeedsIndex();
    this._swapView(indexView);
  },
  
  _swapView: function(newView){
    if(this.currentView){
      this.currentView.close();
    }
    
    this.currentView = newView;
    $('#content').html(this.currentView.render().$el);
  },
});