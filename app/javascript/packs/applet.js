import { Component, h, render } from 'preact'

export default class Applet extends Component {
  constructor(props) {
    super(props);
    this.state = this.props.initialModel;
  }

  updateModel(model) {
    this.setState(model);
  }

  model() {
    return this.state;
  }

  componentDidMount() {
    bus$.onValue(this.props.applet.update.bind(this));
    if (this.props.applet.init) {
      this.props.applet.init(this);
    }
  }

  render() {
    return h(this.props.applet.view, {...this.state});
  }
}
