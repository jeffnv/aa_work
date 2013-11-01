NewsReader.Models.Feed = Backbone.Model.extend({
  url: function(){
    return "feeds/" + this.id + "/entries"
  },
  parse: function(serverData){
    var entriesData = serverData.entries;
    serverData.entries = new NewsReader.Collections.Entries(entriesData);
    return serverData;
  },
});