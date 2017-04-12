Rating = React.createClass({
  getInitialState: function() {
    return {rating: this.props.rating};
  },

  setRating: function(rating, e) {
    this.setState({rating: rating});
  },

  render: function() {
    var stars = [];
    for (var i = 1; i <= this.props.top; i++) {
      let star = this.state.rating < i ? '☆' : '★';
      let prevRating = (this.props.rating == this.state.rating) ? '' : ` (was ${this.props.rating}/${this.props.top})`;
      let title = `${this.state.rating}/${this.props.top}${prevRating}`
      stars.push(
        <span onClick={this.setRating.bind(this, i)} key={i} title={title}>{star}</span>
      );
    }

    return(
      <div>
        <p className="event-form-rating">{stars}</p>
        <input type="hidden" name="event[rating]" value={this.state.rating} />
      </div>
    );
  }
});
