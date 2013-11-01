GistApp.Views.GistNew = Backbone.View.extend({
  initialize: function(){
    this._errors = [];
    this._formIndex = 0;
  },
  template: JST['forms/gist'],
  render: function(){
    this.$el.html(this.template({
      errors: this._errors,
      tags: GistApp.TAGS
    }));
    return this;
  },
  createGist: function(event){
    event.preventDefault();
    var payload = $(event.target).serializeJSON();
    var newGist = new GistApp.Models.Gist(payload);
    newGist.save({},{
      success: function(gist){
        GistApp.gists.add(gist);
        Backbone.history.navigate("/", {trigger: true});
      },
      error: function(gist, errors){
        this._errors = errors;
        this.render();
      }
    });
  },
  addGistFile: function(event){
    event.preventDefault();
    this.$el.find('.gist-files').append(JST['forms/gist_part']({index: this._formIndex++}));
  },
  events: {
    "submit .gist-submit":"createGist",
    "click .add-gist-file":"addGistFile"
  }
});
