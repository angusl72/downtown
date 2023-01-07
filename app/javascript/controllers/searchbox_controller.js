import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="searchbox"
export default class extends Controller {
  static targets = [ "searchbarNav", "searchbarDropdown"]

  connect() {
    console.log("test comment")
  }

  searchbarDropdown(){
    console.log(this)
    this.searchbarDropdownTarget.hidden = false
    console.log("test comment")
  }
}
