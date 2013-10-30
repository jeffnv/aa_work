Journal.Views.PostsIndex = Backbone.View.extend({
  template: JST['posts/post_index'],
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
    var rc = this.template({posts: this.collection})
    this.$el.html(rc);
    return this;
  }
});