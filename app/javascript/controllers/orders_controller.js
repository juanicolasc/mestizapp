import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="orders"
export default class extends Controller {
  connect() {
  }
  confirm(event) {
      let confirmed = confirm("¿Estás seguro?")

      if(!confirmed){
          event.preventDefault()
      }
  }
}
