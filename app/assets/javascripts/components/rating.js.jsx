Rating = React.createClass({
  getInitialState: function() {
    return {rating: this.props.rating};
  },

  setRating: function(rating, e) {
    this.setState({rating: rating});
  },

  render: function() {
    var stars = _.map([1, 2, 3, 4, 5],
      function(i) {
        let star = this.state.rating < i ? '☆' : '★';
        let prevRating = (this.props.rating == this.state.rating) ? '' : ` (was ${this.props.rating}/5)`;
        let title = `${this.state.rating}/5${prevRating}`
        return <span onClick={this.setRating.bind(this, i)} key={i} title={title}>{star}</span>;
      }.bind(this)
    );

    return(
      <div>
        <p className="event-form-rating">{stars}</p>
        <input type="hidden" name="event[rating]" value={this.state.rating} />
      </div>
    );
  }
});
