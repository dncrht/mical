export default class Bus {
  constructor() {
    this.subscribers = [];
  }

  push(action) {
    this.subscribers.map(function(callback) {callback(action)});
  }

  onValue(callback) {
    this.subscribers.push(callback);
  }
}
