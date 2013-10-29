(function(root){
  var PT = root.PT = root.PT || {};

  PhotoListView = PT.PhotoListView = function(){
    this.$el = $('<div></div>');
    PT.Photo.on('add', this.render.bind(this))
  }

  PhotoListView.prototype.render = function(){
    var photos = PT.Photo.all;

    var ul = $("<ul></ul>");
    for(var i = 0; i < photos.length; i++)
    {
      ul.prepend(
        $("<li></li>").text(photos[i].get("title"))
      )
    }

    this.$el.html(ul);
    return this;
  }


})(this)