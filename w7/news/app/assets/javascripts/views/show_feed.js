NewsReader.Views.ShowFeed = Backbone.View.extend({
  initialize: function(){
     this.listenTo(this.model, "change", this.render);
  },
  template: JST['feeds/show'],
  events: {
    'click #refresh-button': 'refreshFeed'
  },
  
  refreshFeed: function(event){
    event.preventDefault();
    var that = this;
    this.model.fetch({success: function(){
      console.log("model fetched successfully")
      // that.render();
    }});
  },
  
  render: function(){
    console.log("refreshing view for: " + this.model.get('title'));
    var content = this.template({
      feed: this.model, entries: this.model.get('entries')
    });
    this.$el.html(content);
    return this;
  },
});