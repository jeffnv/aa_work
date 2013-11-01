GistApp.Models.Favorite= Backbone.Model.extend({
  url: function(){
    return '/gists/' + this.get('gist_id') + '/favorite'
  }
});
