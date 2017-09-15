RATING_CHANGED = 'RATING_CHANGED';

Rating = function(model) {
  var stars = [];
  for (var i = 1; i <= model.top; i++) {
    let star = model.rating < i ? '☆' : '★';
    let prevRating = (model.rating == model.prevRating) ? '' : ` (was ${model.prevRating}/${model.top})`;
    let title = `${model.rating}/${model.top}${prevRating}`;
    let key = parseInt(i);
    stars.push(
      <span onClick={()=>bus$.push({type: RATING_CHANGED, rating: key})} key={i} title={title}>{star}</span>
    );
  }

  return(
    <div>
      <p className="event-form-rating">{stars}</p>
      <input type="hidden" name="event[rating]" value={model.rating} />
    </div>
  );
}

RatingApplet = {
  view: Rating,
  update: function(message) {
    switch (message.type) {
      case RATING_CHANGED:
        this.updateModel({rating: message.rating});
        break;
    }
  }
}
