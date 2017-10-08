import { h, render } from 'preact'

const PHOTO_DELETED = 'PHOTO_DELETED';

const Dropzone = function(props) {
  props.size += ' event-form-photo';

  return (
    h('div', {className: props.size},
      h('div', {className: "upload-dropzone js-upload-dropzone"}, [
        h('progress', {value: props.progress, max: 100}),
        h('small', null, 'Drop a photo here'),
        h('p', null, 'or'),
        h('button', {onClick: ()=>{$('.js-upload-photo').click()}, className: "btn btn-primary btn-xs form-control"}, 'Select a file'),
        h('input', {'data-url': props.url, className: "js-upload-photo hide", type: "file", name: "photo[image]"})
      ])
    )
  );
}

const Photo = function(props) {
  return (
    h('div', {className: "col-sm-3 event-form-photo"}, [
      h('a', {onClick: ()=>bus$.push({type: PHOTO_DELETED, url: props.deleteUrl}), role: "button"}, '✗'),
      h('a', {onClick: ()=>{$('.gallery').colorbox({rel: 'gallery', maxWidth: $(window).width(), maxHeight: $(window).height()});}, href: props.href, className: "gallery"},
        h('img', {src: props.src, className: "img-responsive"})
      )
    ])
  );
}

const Photos = function(props) {
  var size = (Object.keys(props.photos).length == 0) ? 'col-sm-12' : 'col-sm-3';
  var photos = props.photos.map(
    function(photo) {
      return h(Photo, {src: photo.src, href: photo.href, main: photo.main, deleteUrl: photo.deleteUrl, key: photo.id});
    }
  );

  return (
    h('div', {className: "row"}, [
      photos,
      h(Dropzone, {progress: props.progress, url: props.url, size: size})
    ])
  );
}

const PhotosApplet = {
  view: Photos,
  init: function(self) {
    $(document).bind('dragover', function(e) {
      var dropZone = $('.js-upload-dropzone');
      var timeout = window.dropZoneTimeout;
      if (timeout) {
        clearTimeout(timeout);
      }
      var found = false;
      var node = e.target;
      do {
        if (node === dropZone[0]) {
          found = true;
          break;
        }
        node = node.parentNode;
      } while (node != null);
      if (found) {
        dropZone.addClass('hover');
      } else {
        dropZone.removeClass('hover');
      }
      window.dropZoneTimeout = setTimeout(function() {
        window.dropZoneTimeout = null;
        dropZone.removeClass('hover');
      }, 100);
    });

    $('.js-upload-photo').fileupload({
      dropZone: $('.js-upload-dropzone'),
      progressall: function(event, data) {
        var progress = parseInt(data.loaded / data.total * 100, 10);
        self.updateModel({progress: progress});
      },
      done: function(event, data) {
        var photos = self.model().photos;
        photos.push(data.result);
        self.updateModel({photos: photos, progress: 0});
      }
    });
  },
  update: function(message) {
    switch (message.type) {
      case PHOTO_DELETED:
        $.ajax(
          message.url,
          {
            method: 'delete',
            success: function() {
              var photos = this.model().photos.filter(
                function(photo) {
                  return photo.deleteUrl != message.url
                }
              );
              this.updateModel({photos: photos});
            }.bind(this)
          }
        );
        break;
    }
  }
}

export default PhotosApplet;
