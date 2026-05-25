import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['prev', 'curr', 'next', 'link']

  connect() {
    this.years = JSON.parse(this.data.get('list'))
    this.curr = parseInt(this.currTarget.textContent)
    this.index = this.years.indexOf(this.curr)
    this.hideArrows()
  }

  prev() {
    this.index -= 1
    this.hideArrows()
  }

  next() {
    this.index += 1
    this.hideArrows()
  }

  hideArrows() {
    let selected = this.years[this.index]
    this.currTarget.textContent = selected
    this.linkTarget.setAttribute('href', `/${selected}`)

    if (this.curr == selected) {
      this.linkTarget.classList.add('d-none')
    } else {
      this.linkTarget.classList.remove('d-none')
    }

    if (this.index == 0) {
      this.prevTarget.classList.add('d-none')
    } else {
      this.prevTarget.classList.remove('d-none')
    }

    if (this.index == this.years.length - 1) {
      this.nextTarget.classList.add('d-none')
    } else {
      this.nextTarget.classList.remove('d-none')
    }
  }
}
