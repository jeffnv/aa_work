Journal.Views.PostForm = Backbone.View.extend({
  template: JST["posts/post_form"],
  
  events: {
    "submit form": "submitForm"
  },
  
  submitForm: function(event){
    event.preventDefault();
    var that = this;
    var isNew = this.model.isNew();
    var payload = $(event.currentTarget).serializeJSON();
    that.model.set(payload.post);      
    that.model.save({},{
      success: function(event){
        if(isNew){
          Journal.posts.add(that.model);
        }
        Backbone.history.navigate("#posts/" + that.model.id, { trigger: true });
      },
      error: function(post, response){
        var $errors = $('#errors');
        $errors.empty();
        response.responseJSON.forEach(function(errorMessage){
          $errors.append("<p>" + errorMessage + "</p>");
        })
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