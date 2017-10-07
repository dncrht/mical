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
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-tooltip
//= require jquery.ui.widget
//= require jquery.iframe-transport
//= require jquery.fileupload
//= require jquery.colorbox-min
//= require preact
//= require components
//= require farbtastic
//= require mical

_ = {
  map: function(hash, lambda) {
    return Object.keys(hash).map(function(key) {
      return lambda(hash[key], key);
    });
  },

  omit: function(hash, unwanted) {
    var tmp = {};
    Object.keys(hash).map(function(key) {
      if (key !== unwanted) {
        tmp[key] = hash[key];
      }
    });
    return tmp;
  }
}

// TODO: 1 bus per Applet to avoid mixed messages
bus$ = function() {
  var subscribers = [];
  return {
    push: function(action) {
      subscribers.map(function(callback) {callback(action)});
    },

    onValue: function(callback) {
      subscribers.push(callback);
    }
  };
}();
