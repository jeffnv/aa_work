Journal.Views.PostShow = Backbone.View.extend({
  render: function(){
    this.$el.html("<h3>" + this.model.get('title') + "</h3>");
    this.$el.append("<p>" + this.model.get('body') + "</p>");
    this.$el.append("<a href=#>All Posts</a>")
    this.$el.append('<br><a href="#/posts/'+ this.model.id +'/edit' +'">Edit</a>')
    return this;
  }
});