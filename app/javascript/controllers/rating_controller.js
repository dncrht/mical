import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['star', 'value']

  rate(e) {
    let rating = e.currentTarget.dataset.number
    this.valueTarget.value = rating

    this.starTargets.forEach(function(el, i) {
      el.innerHTML = rating <= i ? '☆' : '★'
    })
  }
}
