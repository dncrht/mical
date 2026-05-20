import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['totalRow', 'combined', 'unique']

  update() {
    const checked = [...this.element.querySelectorAll('input[type="checkbox"]:checked')]
    const ids = checked.map(cb => cb.dataset.activityId)

    if (ids.length === 0) {
      this.totalRowTarget.classList.add('d-none')
      return
    }

    const tds = document.querySelectorAll('td[data-activity]')
    let combined = 0
    let unique = 0

    tds.forEach(td => {
      const tdIds = td.dataset.activity.split(',')
      const matchCount = ids.filter(id => tdIds.includes(id)).length
      combined += matchCount
      if (matchCount > 0) unique++
    })

    this.combinedTarget.textContent = combined
    this.uniqueTarget.textContent = unique
    this.totalRowTarget.classList.remove('d-none')
  }
}
