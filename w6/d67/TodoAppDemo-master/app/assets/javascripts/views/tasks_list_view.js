// app/assets/javascript/views/tasks_list_view.js
TD.Views.TasksListView = Backbone.View.extend({
  initialize: function () {
    var that = this;
    
    var renderCallback = that.render.bind(that);
    that.collection.on("add", renderCallback);
    that.collection.on("change", renderCallback);
    that.collection.on("remove", renderCallback);
  },
  
  render: function () {
    var that = this;
    
    var renderedContent = JST["tasks/list"]({
      tasks: that.collection
    });

    that.$el.html(renderedContent);
    return that;
  }
});
