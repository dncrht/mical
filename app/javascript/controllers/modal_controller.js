import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  initialize() {
    this.element.setAttribute('data-action', 'click->modal#show')
  }

  show(e) {
    e.preventDefault()
    e.stopPropagation()
    this.url = this.element.getAttribute('href')
    fetch(this.url, {
      headers: {Accept: 'text/vnd.turbo-stream.html'}
    })
    .then(response => {
      if (!response.ok) {
        throw new Error
      }
      return response.text()
    })
    .then(html => {
      Turbo.renderStreamMessage(html)
      document.getElementById('modal').showModal()
    })
    .catch(error => {
      // NO-OP
    })
  }
}
