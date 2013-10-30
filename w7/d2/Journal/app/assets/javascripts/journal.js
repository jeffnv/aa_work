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
      }
    });
  }
};

$(document).ready(function(){
  Journal.initialize();
});
