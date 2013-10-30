Journal.Views.PostForm = Backbone.View.extend({
  template: JST["posts/post_form"],
  render: function(){
    var rC = this.template({
      post: this.model
    });
    this.$el.html(rC);
    return this
  }
    
  
});