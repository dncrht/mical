import { h, render } from 'preact'

const RATING_CHANGED = 'RATING_CHANGED';

const Rating = function(model, context) {
  var stars = [];
  for (var i = 1; i <= model.top; i++) {
    let star = model.rating < i ? '☆' : '★';
    let prevRating = (model.rating == model.prevRating) ? '' : ` (was ${model.prevRating}/${model.top})`;
    let title = `${model.rating}/${model.top}${prevRating}`;
    let key = parseInt(i);
    stars.push(
      h('span', {onClick: ()=>context.bus$.push({type: RATING_CHANGED, rating: key}), key: i, title: title}, star)
    );
  }

  return(
    h('div', null, [
      h('p', {className: "event-form-rating"}, stars),
      h('input', {type: "hidden", name: "event[rating]", value: model.rating}, null)
    ])
  );
}

const RatingApplet = {
  view: Rating,
  update: function(message) {
    switch (message.type) {
      case RATING_CHANGED:
        this.updateModel({rating: message.rating});
        break;
    }
  }
}

export default RatingApplet;
