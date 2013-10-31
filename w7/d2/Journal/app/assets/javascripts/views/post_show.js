Journal.Views.PostShow = Backbone.View.extend({
  initialize: function(){
    this.listenTo(this.model, "change", this.render);
  },
  
  template: JST['posts/post_show'],
  events: {
  'dblclick .post-title': 'switchVisibility',
  'dblclick .post-body': 'switchVisibility',
  'blur .post-title': 'saveEditToDB',
  'blur .post-body': 'saveEditToDB',
  'submit form': 'submitNullifyer'
  },
  
  switchVisibility: function(event){
    var $item = $(event.currentTarget);
    var class_name = $item.attr('class');
    var splitIdx = class_name.indexOf("shown") - 1;
    class_name =  "." + class_name.slice(0, splitIdx);
    var $els = $(class_name);
    $els.toggleClass('shown not-shown');
    $('input'+class_name).focus();
  },
  
  saveEditToDB: function(event){
    event.preventDefault();
    var payload = $(event.currentTarget).serializeJSON();
    this.switchVisibility(event);
    this.model.set(payload.post); 
    this.model.save();  
  },
  
  submitNullifyer: function(event){
    event.preventDefault();
    this.saveEditToDB(event);
  },
  
  render: function(){
    var renderedContent = this.template({post: this.model});
    this.$el.html(renderedContent);
    return this;
  }
});