Journal.Views.PostForm = Backbone.View.extend({
  template: JST["posts/post_form"],
  
  events: {
    "submit form": "submitForm"
  },
  
  submitForm: function(event){
    event.preventDefault();
    
    var payload = $(event.currentTarget).serializeJSON();
    this.model.set(payload.post);      
    this.model.save({},{
      success: function(event){
        Backbone.history.navigate("/", { trigger: true });
      },
      error: function(data){
        alert("You done goofed.");
      }
    });
  },

  
  render: function(){
    
    var payload = $(event.currentTarget).serializeJSON();
    
    var rC = this.template({
    post: this.model
    });
    this.$el.html(rC);
    return this
  }
    
  
});