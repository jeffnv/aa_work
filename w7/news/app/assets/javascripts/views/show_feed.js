NewsReader.Views.ShowFeed = Backbone.View.extend({
  initialize: function(){
    this.listenTo(this.model, "sync change", this.render);
  },
  template: JST['feeds/show'],
  events: {
    'click #refresh-button': 'refreshFeed'
  },
  
  refreshFeed: function(event){
    event.preventDefault();
    
    this.model.fetch({success: function(){
    }});
  },
  
  render: function(){
    var content = this.template({
      feed: this.model, entries: this.model.get('entries')
    });
    this.$el.html(content);
    return this;
  },
});