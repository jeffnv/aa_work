NewReader.Collections.Entries = Backbone.Collection.extend({
  model: NewReader.Models.Entry,
  comparator: function(entry) {
    return entry.get("published_at")
  }
})