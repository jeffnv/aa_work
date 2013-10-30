Journal.Views.PostShow = Backbone.View.extend({
  template: JST['posts/post_show'],
  events: {
  'dblclick .post-title': 'handleDblClick',
  'dblclick .post-body': 'handleDblClick',
  },
  
  handleDblClick: function(event){
    var $item = $(event.currentTarget);
    var class_name = $item.attr('class');
    var splitIdx = class_name.indexOf("shown") - 1;
    class_name =  "." + class_name.slice(0, splitIdx);
    
    $(class_name).toggleClass('shown not-shown')
    //get the item clicked
    //toggle its class to not-shown
  },
  
  render: function(){
    var renderedContent = this.template({post: this.model});
    this.$el.html(renderedContent);
    return this;
  }
});