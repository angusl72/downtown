import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="image-slider"
export default class extends Controller {
  static targets = ['imageOuterContainer']


  connect() {
  }

  beforeAfter(event) {
    // this.imageOuterContainerTarget.style.setProperty('--position', event.currentTarget.value)
    // this.imageOuterContainerTarget.backgroundColor = "blue";
    const a = this.imageOuterContainerTarget
    // this.imageOuterContainerTarget.setAttribute('--position', event.currentTarget.value)
    a.setAttribute('--position', event.currentTarget.value)
    console.log(event.currentTarget.value)
  }
}
