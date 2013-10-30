Journal.Views.PostsIndex = Backbone.View.extend({
  initialize: function(options){
     this.listenTo(this.collection, "add remove change:title reset", this.render);
  },
  
  events: {
    'click .delete-button': 'deleteItem'
  },
  
  deleteItem: function(event){
    event.preventDefault();
    var id = $(event.target).data('id')
    Journal.posts.get(id).destroy();
  },
  
  render: function () {
    var that  = this;
    this.$el.html('<a href="#/posts/new">New Post</a>')
    this.$el.append('<ul></ul>');
    this.collection.each(function(post){
        that.$el.find('ul').append(
          '<li>' + 
          "<a href=\"#posts/" +  post.id + "\">"+ post.get('title')
          + '</a>' +   
          "<button data-id=" + post.id + "  class=\"delete-button\" type=\"button\">Delete</button>" + 
          '</li>');
      }
    )

    return this;
  }
});