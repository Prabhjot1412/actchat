import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("preview")
  }

  preview_image() {
    console.log('preview_image')

    let file_field = document.getElementById('file_field')
    let image_holder = document.getElementById('preview')

    if(file_field.files.length == 0) {
      image_holder.setAttribute('hidden', 'true')
      return
    }

    let image = file_field.files[0]
    let url = URL.createObjectURL(image)

    image_holder.removeAttribute('hidden')
    image_holder.setAttribute('src', url)
  }
}
