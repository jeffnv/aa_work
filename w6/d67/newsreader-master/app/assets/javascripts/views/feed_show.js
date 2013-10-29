NewReader.Views.FeedShow = Backbone.View.extend({
  template: JST['feeds/show'],
  className: "feed-show",
  events: {
    "click .refresh-entries" : "refresh"
  },

  render: function () {
    var that = this;
    that.$el.html(that.template({feed: that.model}));

    return that;
  },

  refresh: function () {
    var that = this;
    var renderCallback = that.render.bind(that)
    that.model.get("entries").fetch({
      success: renderCallback,
      error: function(){
        console.log("Could not refresh view for some reason");
      }
    })
  }

});