NewReader.Routers.FeedRouter = Backbone.Router.extend({
  initialize: function(feeds, $rootEl, $sidebar){
    this.feeds = feeds;
    this.$rootEl = $rootEl;
    this.$sidebar = $sidebar
  },

  routes: {
    "": "index",
    "feeds/:id": "show",
    "feeds/:feed_id/entries/:id": "entry"
  },

  index: function() {
    this.installSidebar();
    this.$rootEl.html("");
  },

  show: function(id) {
    var feedShowView = new NewReader.Views.FeedShow({
      model: this.feeds.get(id)
    });

    this.installSidebar();
    this.$rootEl.html(feedShowView.render().$el);
  },

  entry: function(feed_id, id) {
    var entry = this.feeds.get(feed_id).get('entries').get(id);
    var entryShowView = new NewReader.Views.EntryShow({
      model: entry
    })

    this.installSidebar();
    this.$rootEl.html(entryShowView.render().$el)
  },

  installSidebar: function() {
    var feedsIndexView = new NewReader.Views.FeedsIndex({
      collection: this.feeds
    });

    this.$sidebar.html(feedsIndexView.render().$el);
  }

})