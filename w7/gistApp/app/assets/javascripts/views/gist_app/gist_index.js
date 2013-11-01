GistApp.Views.GistIndex = Backbone.View.extend({
  initialize: function(){
    this.listenTo(this.collection, "add remove change", this.render);
  },
  template: JST['gist_app/index'],
  events: {
    "click .favorite-button" : "favoriteGist",
    "click .unfavorite-button" : "unfavoriteGist"
  },
  favoriteGist: function(event){
    var gistId = parseInt($(event.currentTarget).data('id'));
    var gist = GistApp.gists.get(gistId);
    gist.favorite.save({gist_id: gistId}, {
      success: function(){this.render();}.bind(this)
    });
  },
  unfavoriteGist: function(event){
    var that = this;
    var gistId = parseInt($(event.currentTarget).data('id'));
    var gist = GistApp.gists.get(gistId);
    gist.favorite.destroy(
      {
        success: function(model, response){
          gist.favorite.id = undefined;
          that.render();
        }
      }
    );
  },
  render: function(){
    // this.$el.html(this.template({gists: this.collection}));
    var that =  this;
    this.$el.html(this.template());
    this.collection.each(function(gist){
      var detailTemplate = JST['gist_app/show']({gist: gist});
      that.$el.find('.gist-list').append(detailTemplate);
    });
    return this;
  }
});
