NewReader.Models.Feed = Backbone.Model.extend({
  parse: function(response) {
    response["entries"] = new NewReader.Collections.Entries(response["entries"], {
      url: "/feeds/" + response["id"] + "/entries"
    })

    return response;
  }
});