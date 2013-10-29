NewReader.Views.EntryShow = Backbone.View.extend({
  template: JST['entries/show'],

  render: function () {
    this.$el.html(this.template({ entry: this.model }));

    return this;
  }
})