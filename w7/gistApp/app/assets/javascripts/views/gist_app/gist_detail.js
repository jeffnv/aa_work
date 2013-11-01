GistApp.Views.GistDetail = Backbone.View.extend({
  tagName: 'li',
  template: JST['gist_app/show'],
  render: function(){
    this.$el.html(this.template({gist: this.model}));
    return this;
  }
});
