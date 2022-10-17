import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['toHide', 'toShow']

  initialize() {
    this.toHideTarget.setAttribute('data-action', 'click->dropdown#toggle')
  }

  toggle() {
    this.toShowTarget.classList.add('shadow-inset-center');
    this.toHideTarget.classList.add('fadeaway');
    setTimeout(function() {
      this.toHideTarget.classList.add('d-none')
      this.toShowTarget.classList.remove('d-none')
    }.bind(this), 200)
  }
}
