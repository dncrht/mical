PHOTO_DELETED = 'PHOTO_DELETED';

Dropzone = function(props) {
  props.size += ' event-form-photo';

  return (
    <div className={props.size}>
      <div className="upload-dropzone js-upload-dropzone">
        <progress value="0" max="100"></progress>
        <small>Drop a
        photo here</small>
        <p>or</p>
        <button className="btn btn-primary btn-xs form-control">Select a file</button>
        <input data-url={props.url} className="js-upload-photo hide" type="file" name="photo[image]" />
      </div>
    </div>
  );
}

Photo = function(props) {
  return (
    <div className="col-sm-3 event-form-photo">
      <a onClick={()=>bus$.push({type: PHOTO_DELETED, url: props.deleteUrl})} role="button">✗</a>
      <a href={props.href} className="gallery">
        <img src={props.src} className="img-responsive" />
      </a>
    </div>
  );
}

PhotosApplet = React.createClass({
  getInitialState: function() {
    return {photos: this.props.photos};
  },

  componentDidMount: function() {
    this.attachGallery();

    bus$.onValue((function(action) {
      switch (action.type) {
        case PHOTO_DELETED:
          $.ajax(
            action.url,
            {
              method: 'delete',
              success: function(props) {
                this.setState({photos: _.omit(this.state.photos, props.id)});
              }.bind(this)
            }
          );
          break;
      }
    }).bind(this));

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
        $('progress').val(progress);
      },
      done: function(event, data) {
        $('progress').val(0);
        var props = data.result;
        var photos = this.state.photos;
        photos[props.id] = props.attributes;
        this.setState({photos: photos});
        this.attachGallery();
      }.bind(this)
    });
  },

  attachGallery: function() {
    $('.gallery').colorbox({
      rel: 'gallery',
      maxWidth: $(window).width(),
      maxHeight: $(window).height()
    });
  },

  render: function() {
    var size = (Object.keys(this.state.photos).length == 0) ? 'col-sm-12' : 'col-sm-3';
    var photos = _.map(this.state.photos,
      function(photo, id) {
        return <Photo src={photo.src} href={photo.href} main={photo.main} deleteUrl={photo.deleteUrl} key={id} />;
      }.bind(this)
    );

    return (
      <div className="row">
        {photos}
        <Dropzone url={this.props.url} size={size} />
      </div>
    );
  }
});
