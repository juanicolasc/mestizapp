import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="customer"
export default class extends Controller {
  static values = {
    name: String
  }
  connect() {
      document.querySelector("#cliente").value = this.nameValue
  }
}
