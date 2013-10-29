NewReader.Views.FeedsIndex = Backbone.View.extend({
  template: JST['feeds/index'],
  tagName: "ul",
  className: "feeds-index",
  events: {
    "click .add-button" : "add"
  },

  initialize: function () {
    var that = this;
    var renderCallback = that.render.bind(that);
    that.listenTo(that.collection, 'add', renderCallback);
    that.listenTo(that.collection, 'remove', renderCallback);
  },

  render: function () {
    var that = this;
    that.$el.html(that.template({
      feeds: that.collection
    }));
    return that;
  },

  add: function(event){
    var that = this;
    var newUrl = $('input[name=feed\\[url\\]]').val()
    that.collection.create({url: newUrl}, {wait:true});
  }
})


