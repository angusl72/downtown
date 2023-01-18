import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="image-slider"
export default class extends Controller {
  static targets = ['imageOuterContainer']


  connect() {
  }

  beforeAfter(event) {
    const a = this.imageOuterContainerTarget
    a.style.setProperty("--position", `${event.currentTarget.value}%`);
    console.log(event.currentTarget.value)
  }
}
