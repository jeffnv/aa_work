Journal.Views.PostShow = Backbone.View.extend({
  render: function(){
    this.$el.html("<h3>" + this.model.get('title') + "</h3>");
    this.$el.append("<h3>" + this.model.get('body') + "</h3>");
    this.$el.append("<a href=#>All Posts</a>")
    return this;
  }
});