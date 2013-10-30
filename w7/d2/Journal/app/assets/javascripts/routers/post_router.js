Journal.PostRouter = Backbone.Router.extend({
  routes: {
    "": "showAllPosts",
    "posts/:id/edit": "showEditForm",
    "posts/new": "showNewForm",
    "posts/:id": "showPost"
  },
  
  showAllPosts: function(){
    var postIndexView = new Journal.Views.PostsIndex({
      collection:Journal.posts
    });
    $('div.sidebar').html(postIndexView.render().$el);
  },
  
  showPost: function(id){
    var postShowView = new Journal.Views.PostShow({
      model: Journal.posts.get(id)
    });
    $('div.content').html(postShowView.render().$el);
  },
  
  showEditForm: function(id){
    var postEditView = new Journal.Views.PostForm({
      model: Journal.posts.get(id)
    });
    $('div.content').html(postEditView.render().$el);
  },
  
  showNewForm: function(){
    var postEditView = new Journal.Views.PostForm({
      model: new Journal.Models.Post(),
      collection: Journal.posts
    });
    $('div.content').html(postEditView.render().$el);
  }
  
});

