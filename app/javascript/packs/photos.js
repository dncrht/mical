import Dropzone from 'react-dropzone';
import request from 'superagent';

const PHOTO_DELETED = 'PHOTO_DELETED';
const PHOTO_DROPPED = 'PHOTO_DROPPED';

const PhotoUpload = function(props, context) {
  props.size += ' event-form-photo';

  return (
    h('div', {className: props.size},
      h(Dropzone, {className: "upload-dropzone", activeClassName: "upload-dropzone-active", disablePreview: true, onDrop: (files)=>context.bus$.push({type: PHOTO_DROPPED, files: files}), multiple: true, accept: 'image/*'}, [
        h('progress', {value: isNaN(props.progress) ? 0 : props.progress, max: 100}),
        h('small', null, 'Drop a photo here'),
        h('p', null, 'or'),
        h('button', {className: "btn btn-primary btn-sm form-control"}, 'Select a file')
      ])
    )
  );
}

const Photo = function(props, context) {
  return (
    h('div', {className: "col-sm-3 event-form-photo"}, [
      h('a', {onClick: ()=>context.bus$.push({type: PHOTO_DELETED, url: props.deleteUrl}), role: 'button'}, '✗'),
      h('a', {onClick: ()=>{$('.gallery').colorbox({rel: 'gallery', maxWidth: $(window).width(), maxHeight: $(window).height()});}, href: props.href, className: "gallery"},
        h('img', {src: props.src, className: "img-fluid"})
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
      h(PhotoUpload, {progress: props.progress, url: props.url, size: size})
    ])
  );
}

const PhotosApplet = {
  view: Photos,
  update: function(message) {
    switch (message.type) {
      case PHOTO_DELETED:
        request.delete(message.url).set('X-CSRF-Token', $.rails.csrfToken()).end(function() {
          var photos = this.model().photos.filter(
            function(photo) {
              return photo.deleteUrl != message.url
            }
          );
          this.updateModel({photos: photos});
        }.bind(this));
        break;
      case PHOTO_DROPPED:
        for (var file of message.files) {
          request
            .post(this.model().url)
            .set('X-CSRF-Token', $.rails.csrfToken())
            .on('progress', function(e) {
              this.updateModel({progress: e.percent});
            }.bind(this))
            .field('photo[image]', file)
            .end(function(err, response) {
              if (err) {
                console.error(err);
              }

              var photos = this.model().photos;
              photos.push(JSON.parse(response.text));
              this.updateModel({photos: photos, progress: 0});
            }.bind(this));
        }
        break;
    }
  }
}

export default PhotosApplet;
