window.NewReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var $rootEl = $('#content');
    var $sidebar = $('#sidebar')
    var feeds = new NewReader.Collections.Feeds()

    feeds.fetch({
      success: function() {
        console.log(feeds)
        new NewReader.Routers.FeedRouter(feeds, $rootEl, $sidebar);
        Backbone.history.start();
      },
      error: function() {
        console.log("Failed to fetch.");
      }
    })

  }
};

$(document).ready(function() {
  NewReader.initialize();
});
