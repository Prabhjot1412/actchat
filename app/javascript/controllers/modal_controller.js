import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("modal")
  }

  toggle_modal() {
    let modal = document.getElementById('modal')

    if (modal.style.display == 'block') {
      modal.style.opacity = '0'
      setTimeout(() => { modal.style.display = 'none'}, 100)
    } else {
      modal.style.display = 'block'
      modal.style.opacity = '100%'
    }
  }
}
