import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("chats")
  }

  show_chats(event) {
    let friend = event.target
    let editor = document.getElementById('text-editor')
    let form = document.getElementById('chat-form')

    if (!friend.classList.contains('chats')) {
      friend = friend.parentElement
    }
    let friend_id = friend.getAttribute('friend-id')
    let chats_holder = document.getElementById('chats-holder')

    editor.removeAttribute('hidden')
    form.setAttribute('action', `/notifications/create?kind=chat&friend_id=${friend_id}`)

    let current_active = document.getElementById('chats-friend-item-active')
    if (current_active) {
      current_active.classList.remove('chats-friend-item-active')
      current_active.classList.add('chats-friend-item')
      current_active.removeAttribute('id')
    }

    friend.classList.remove('chats-friend-item')
    friend.classList.add('chats-friend-item-active')
    friend.setAttribute('id', 'chats-friend-item-active')

    let res = fetch(`/notifications/fetch_chats?friend_id=${friend_id}`)

    res.then((response) => {
      return response.json()
    }).then((data) =>{
      console.log(data)

      data.forEach(noti => {
        chats_holder.innerHTML +=
        `
          <div class='d-flex' style=${noti["sent_by_current?"] ? 'justify-content:end;flex-direction:row-reverse' : ''}>
            <div>
              <img src="${noti["sender_avatar_url"]}" width="60" height="60" class='rounded' style='margin-right: 5px; margin-top: 3px;'>
            </div>

            <div class='mx-4 my-1 chats-message'>
              <span>${noti["data"]}</span>
            </div>
          </div
        `
      });
    })
  }
}
