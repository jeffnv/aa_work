(function(root) {
  var PT = root.PT = (root.PT || {});

  var PhotoFormView = PT.PhotoFormView = function(){
    this.$el = $('<div></div>');
    this.$el.on('submit', this.submit )
  };

  PhotoFormView.prototype.render = function(){
    var renderedContent = JST["photo_form"]({});
    this.$el.html(renderedContent);
    return this;
  }

  PhotoFormView.prototype.submit = function(event){
    event.preventDefault();
    console.log("currtarget")
    console.log(event.currentTarget);
    console.log("target");
    console.log(event.target);
    var formData = $(event.target).serializeJSON();
    console.log("formdata");
    console.log(formData.photo);

    var photo = new PT.Photo(formData.photo);
    photo.save(function(){});
  }

})(this);