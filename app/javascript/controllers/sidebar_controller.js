import { Controller } from "@hotwired/stimulus"
import { setCookie } from "../src/cookies"

export default class extends Controller {
  connect() {
    console.log("sidebar")
  }

  toggle_sidebar() {
    let list_elements = document.getElementsByClassName('hidden-when-collapsed')
    let sidebar = document.getElementById('sidebar')
    let sidebarExpander = document.getElementById('sidebar-expander')

    for(let element of list_elements) {
      if (element.getAttribute('hidden') == '') {
        setTimeout(() => {element.toggleAttribute('hidden')}, 250)
      } else {
        element.toggleAttribute('hidden')
      }
    }

    if (sidebar.style.minWidth != '10rem') {
      sidebar.style.minWidth = '10rem'
      sidebar.style.minHeight = '52.9rem'
      sidebar.style.maxHeight = 'unset'

      sidebarExpander.style.left = '160px'
      sidebarExpander.style.transform = 'rotate(180deg)'
    } else {
      sidebar.style.minWidth = '3rem'
      sidebar.style.minHeight = '0'
      sidebar.style.maxHeight = '700px'

      sidebarExpander.style.left = '46px'
      sidebarExpander.style.transform = 'rotate(0deg)'
    }
  }

  reset_page() {
    setCookie('page', '')
  }
}
