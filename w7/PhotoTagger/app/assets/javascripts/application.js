// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require underscore
//= require_tree ./models
//= require_tree ./views
//= require_tree ../templates
//= require_tree ../../../vendor/assets/javascripts

(function(root) {
  var PT = root.PT = (root.PT || {});

  PT.initialize = function(userId, $rootEl){
    //fetch photos for current_user
    //build and render list view
    Photo.fetchByUserId(userId, function(){
      var photoListView = new PT.PhotoListView();
      var photoFormView = new PT.PhotoFormView();
      $rootEl.html(photoListView.render().$el);
      $rootEl.append(photoFormView.render().$el);
    });

  };

  var Photo = PT.Photo = function(obj) {
    this.attributes = _.extend({}, obj);
  };

  Photo._events = {};

  Photo.on = function(eventName, callback){
    Photo._events[eventName] = this._events[eventName] || [];
    Photo._events[eventName].push(callback);
  }

  Photo.trigger = function(eventName){
    var events = this._events[eventName];
    for(var i = 0; i < events.length; i++){
      events[i]();
    }
  }

  Photo.fetchByUserId = function(userId, callback) {
    $.ajax({
      url: "/api/users/" + userId + "/photos",
      type: "GET",
      success: function (photos) {
        var fetchedPhotos = [];
        //create an array of photo objects
        for(var i = 0; i < photos.length; i++){
          fetchedPhotos.push(new Photo(photos[i]));
        }
        Photo.cacheObj(fetchedPhotos);
        callback(fetchedPhotos);
      }
    });
  };

  Photo.all = [];

  Photo.cacheObj = function(arr) {
    if(Array.isArray(arr)){
      for(var i = 0; i< arr.length; i++){
        if(Photo.all.indexOf(arr[i]) === -1){
          Photo.all.push(arr[i]);
        }
      }
    }
    else{
      if(Photo.all.indexOf(arr[i]) === -1){
        Photo.all.unshift(arr);
      }

    }
  }

  Photo.prototype.get = function(key) {
    return this.attributes[key];
  }

  Photo.prototype.set = function(key, value) {
    this.get(key) = value;
  }

  Photo.prototype.save = function(callback) {
    var type, url;
    var that = this;
    if(this.attributes["id"]){
      type = "PUT";
      url ="/api/photos/" + this.attributes["id"] ;
    }
    else
    {
      type = "POST";
      url ="/api/photos";
    }
    $.ajax({
      url: url,
      type: type,
      data: {photo: this.attributes},
      success: function(createdObj) {
        _.extend(that.attributes, createdObj);
        Photo.cacheObj(that);
        callback();
        /****************************************
        Here we 'trigger' the event that we subscribed to
        on line 6 of photo_list_view.js
        *****************************************/
        PT.Photo.trigger('add');
      }
    });
  }

})(this);

