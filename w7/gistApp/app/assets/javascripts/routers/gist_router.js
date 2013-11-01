GistApp.Routers.GistRouter = Backbone.Router.extend({
  routes: {
    "":"showIndex",
    "gists/new":"newGist",
    "gists/:id":"showGist"
  },
  newGist: function(){
    var gistView = new GistApp.Views.GistNew();
    this.switchView(gistView);
  },
  showIndex: function(){
    var indexView = new GistApp.Views.GistIndex({ collection: GistApp.gists });
    this.switchView(indexView);
  },
  showGist: function(id){
    var model = GistApp.gists.get(id);
    var gistView = new GistApp.Views.GistDetail({model: model});
    this.switchView(gistView);
  },
  switchView: function(view){
    if (this._currentView)
      this._currentView.close();

      this._currentView = view;
      $('.content').html(view.render().$el);
  }
});
