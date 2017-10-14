import { TwitterPicker } from 'react-color';

const COLOR_CHANGED = 'COLOR_CHANGED';

const Color = function(model, context) {
  return h('div', null, [
    h('input', {type: 'hidden', name: 'activity[color]', value: model.color}, null),
    h(TwitterPicker, {color: model.color, onChangeComplete: (color)=>context.bus$.push({type: COLOR_CHANGED, color: color.hex})}, null),
  ]);
};

const ColorApplet = {
  view: Color,
  update: function(message) {
    switch (message.type) {
      case COLOR_CHANGED:
        this.updateModel({color: message.color});
        break;
    }
  }
}

export default ColorApplet;
