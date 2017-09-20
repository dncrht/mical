Applet = function(applet, init) {
  return(React.createElement(
    React.createClass({
      updateModel: function(model) {
        this.setState(model);
      },

      getInitialState: function() {
        return this.props;
      },

      componentDidMount: function() {
        bus$.onValue(applet.update.bind(this));
      },

      render: function() {
        return React.createElement(applet.view, {...this.state});
      }
    }),
    init
  ));
};
