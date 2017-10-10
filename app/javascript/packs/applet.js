import { Component, h, render } from 'preact'
import Bus from './bus';

export default class Applet extends Component {
  constructor(props) {
    super(props);
    this.state = this.props.initialModel;
    this.bus$ = new Bus();
  }

  getChildContext() {
    return {bus$: this.bus$};
  }

  updateModel(model) {
    this.setState(model);
  }

  model() {
    return this.state;
  }

  componentDidMount() {
    this.bus$.onValue(this.props.applet.update.bind(this));
    if (this.props.applet.init) {
      this.props.applet.init(this);
    }
  }

  render() {
    return h(this.props.applet.view, {...this.state});
  }
}
