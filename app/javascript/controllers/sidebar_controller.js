import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("sidebar")
  }

  toggle_sidebar() {
    let list_elements = document.getElementsByClassName('hidden-when-collapsed')
    let sidebar = document.getElementById('sidebar')
    let sidebarExpander = document.getElementById('sidebar-expander')

    for(let element of list_elements) {
      element.toggleAttribute('hidden')
    }

    if (sidebar.style.minWidth != '10rem') {
      sidebar.style.minWidth = '10rem'
      sidebar.style.minHeight = '52.9rem'
      sidebar.style.maxHeight = 'unset'

      sidebarExpander.style.left = '160px'
      sidebarExpander.style.transform = 'rotate(180deg)'
    } else {
      sidebar.style.minWidth = '0'
      sidebar.style.minHeight = '0'
      sidebar.style.maxHeight = '700px'

      sidebarExpander.style.left = '42px'
      sidebarExpander.style.transform = 'rotate(0deg)'
    }
  }
}
