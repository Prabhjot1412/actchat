import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("search")
  }

  users(event) {
    let searchbox = document.getElementById('user_searchbox')

    if(event.target.value == '') {
      searchbox.setAttribute('hidden', 'true')
      return
    }

    searchbox.removeAttribute('hidden')

    let base_path = document.head.querySelector("meta[name=base_path]").content
    let res = fetch(`${base_path}users?q=${event.target.value}`)

    res.then((response) => {
      return response.json()
    }).then((data) => {
      let isNotFound = !document.getElementById('user-not-found')

      if (!!document.getElementById('user-container')) {
        document.getElementById('user-container').remove()
      }

      if (data == false) {
        if (isNotFound) {
          let userNotFound = document.createElement('i')
          userNotFound.setAttribute('id', 'user-not-found')
          userNotFound.classList.add('searchbox-user-not-found', 'fa-solid', 'fa-ban', 'fa-xl')
          searchbox.appendChild(userNotFound)
        }
      } else {
        if (!isNotFound) {
          document.getElementById('user-not-found').remove()
        }

        let container = document.createElement('div')
        container.setAttribute('id', 'user-container')
        searchbox.appendChild(container)

        for(let index in data) {
          let user = data[index]

          let user_data = document.createElement('a')
          user_data.classList.add('searchbox-user-data')
          user_data.setAttribute('href', `/home/public?id=${user.id}`)

          let user_avatar = document.createElement('img')
          user_avatar.classList.add('rounded')
          user_avatar.setAttribute('width', '50')
          user_avatar.setAttribute('height', '50')
          user_avatar.setAttribute('src', user.avatar_url)
          user_data.appendChild(user_avatar)

          let user_name = document.createElement('span')
          user_name.innerText = user.user_name
          user_data.appendChild(user_name)

          container.appendChild(user_data)
          container.appendChild(document.createElement('hr'))
        }
      }
    })
  }
}
