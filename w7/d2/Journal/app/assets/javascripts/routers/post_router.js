Journal.PostRouter = Backbone.Router.extend({
  routes: {
    "": "showAllPosts",
    "posts/:id/edit": "showEditForm",
    "posts/:id": "showPost"
  },
  
  showAllPosts: function(){
    var postIndexView = new Journal.Views.PostsIndex({collection:Journal.posts});
    $('div').html(postIndexView.render().$el);
  },
  
  showPost: function(id){
    var postShowView = new Journal.Views.PostShow({model: Journal.posts.get(id)});
    $('div').html(postShowView.render().$el);
  },
  
  showEditForm: function(id){
    var postEditView = new Journal.Views.PostForm({model: Journal.posts.get(id)});
    $('div').html(postEditView.render().$el);
  }
});

