window.Journal = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  
  initialize: function() {
    Journal.posts = new Journal.Collections.Posts();
    Journal.posts.fetch({
      success:function(){
        new Journal.PostRouter();
        Backbone.history.start();
        
        var postIndexView = new Journal.Views.PostsIndex({
          collection:Journal.posts
        });
        $('div.sidebar').html(postIndexView.render().$el);
      }
    });
  }
};

$(document).ready(function(){
  Journal.initialize();
});
