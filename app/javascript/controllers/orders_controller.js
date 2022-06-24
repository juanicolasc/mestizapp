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
  calculator(event) {
      let method = event.currentTarget.value
      if(method == 'Efectivo'){
          document.querySelector("#calculator").hidden = false
      }else{
          document.querySelector("#calculator").hidden = true
      }
  }
  calculate(event) {
      let curent = event.currentTarget.value
      if(curent > event.params.original){
          document.querySelector("#change").value = curent - event.params.original
      }else{
          document.querySelector("#change").value = 0
      }
  }
  tip(event) {
      document.querySelector("#order_tip").value = (event.params.final * event.params.percentage)
  }
}
