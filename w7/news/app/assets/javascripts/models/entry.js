NewsReader.Models.Entry = Backbone.Model.extend({
  urlRoot: function(){
    return "feeds/" + this.get('feed_id') + "/entries";
  },
});