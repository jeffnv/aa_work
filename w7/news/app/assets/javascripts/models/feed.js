NewsReader.Models.Feed = Backbone.Model.extend({
  parse: function(serverData){
    var entriesData = serverData.entries;
    serverData.entries = new NewsReader.Collections.Entries(entriesData);
    return serverData;
  },
});