import React, { Component } from 'react';
import { render } from 'react-dom';
import { TwitterPicker } from 'react-color';

export default class ColorApplet extends Component {
  constructor(props) {
    super(props);
    this.state = this.props;
  }

  handleChangeComplete(color) {
    console.log(color.hex)
    this.setState({color: color.hex});
  }

  render() {
    return h('div', null, [
      h('input', {type: 'hidden', name: 'activity[color]', value: this.state.color}, null),
      h(TwitterPicker, {color: this.state.color, onChangeComplete: this.handleChangeComplete.bind(this)}, null),
    ]);
  }
}
