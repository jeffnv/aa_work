GistApp.Models.Gist= Backbone.Model.extend({
  urlRoot: '/gists',
  parse: function(serverData){
    //delete favorites stuff,
    var favData = serverData.favorites[0];
    delete serverData.favorites;

    var gistFiles = serverData.gist_files;
    delete serverData.gist_files;

    this.favorite = new GistApp.Models.Favorite(favData);
    var gistFilesArray = [];
    gistFiles.forEach(function(gistFile){
      gistFilesArray.push(new GistApp.Models.GistFile(gistFile));
    });

    this.gistFiles = new GistApp.Collections.GistFiles(gistFilesArray);

    return serverData;
  },

  toJSON: function(){
    var json = _.extend({}, this.attributes);
    return json;
  }
});
