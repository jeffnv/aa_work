NewsReader.Views.FeedsIndex = Backbone.View.extend({
  template: JST['feeds/index'],
  render: function(){
    var content = this.template({feeds: NewsReader.feeds});
    this.$el.html(content);
    return this;
  },
});