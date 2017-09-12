RATING_CHANGED = 'RATING_CHANGED';

RatingApplet = React.createClass({
  getInitialState: function() {
    return {rating: this.props.rating};
  },

  componentDidMount: function() {
    bus$.onValue((function(action) {
      switch (action.type) {
        case RATING_CHANGED:
          this.setState({rating: action.rating});
          break;
      }
    }).bind(this));
  },

  render: function() {
    return(
      <Rating rating={this.state.rating} prevRating={this.props.rating} top={this.props.top} />
    )
  }
});


Rating = function(props) {
  var stars = [];
  for (var i = 1; i <= props.top; i++) {
    let star = props.rating < i ? '☆' : '★';
    let prevRating = (props.rating == props.prevRating) ? '' : ` (was ${props.prevRating}/${props.top})`;
    let title = `${props.rating}/${props.top}${prevRating}`;
    let key = parseInt(i);
    stars.push(
      <span onClick={()=>bus$.push({type: RATING_CHANGED, rating: key})} key={i} title={title}>{star}</span>
    );
  }

  return(
    <div>
      <p className="event-form-rating">{stars}</p>
      <input type="hidden" name="event[rating]" value={props.rating} />
    </div>
  );
}
