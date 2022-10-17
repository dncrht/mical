import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['area', 'file', 'form']

  openDialog() {
    this.fileTarget.click();
  }

  perform() {
    this.formTarget.requestSubmit();
  }

  dragleave(e) {
    this.areaTarget.style = 'border-color: #ccc';
  }

  dragover(e) {
    this.areaTarget.style = 'border-color: #0d6efd';
    e.dataTransfer.dropEffect = 'link';
    e.preventDefault(); // must be disabled for drop() to work
  }

  drop(e) {
    this.fileTarget.files = e.dataTransfer.files;
    this.areaTarget.style = 'border-color: #ccc';
    this.perform();
    e.preventDefault(); // must be disabled to prevent further browser processing
  }
}
