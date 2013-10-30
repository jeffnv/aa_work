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
    this.$el.append('<table></table>');
    this.collection.each(function(post){
      var $row = $('<tr></tr>')
        $row.append(
          '<td>' + 
          "<a href=\"#posts/" +  post.id + "\">"+ post.get('title')
          + '</a></td>' +   
          "<td><button data-id=" + post.id + "  class=\"delete-button\" type=\"button\">Delete</button>" + 
          '</td>');
      that.$el.find('table').append($row);
      }
    )

    return this;
  }
});