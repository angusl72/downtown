import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="searchbox"
export default class extends Controller {
  connect() {
    console.log("test comment")
  }
}
