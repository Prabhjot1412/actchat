import { Controller } from "@hotwired/stimulus"
import { chat_message } from "../src/shared"

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
    let holder = document.getElementById('holder')

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
    }).then((data) => {
      chats_holder.innerHTML = ''

      data.forEach(noti => {
        chats_holder.innerHTML += chat_message(noti["sent_by_current?"], noti["sender_avatar_url"], noti["data"])
      });

      holder.scrollTop = holder.scrollHeight
    })
  }

  submit_message() {
    let chats_holder = document.getElementById('chats-holder')
    let sender_avatar_url = document.getElementById('holder').getAttribute('user_avatar')
    let text_area = document.getElementById('text-area')
    let holder = document.getElementById('holder')

    if(!text_area.value) {
      return
    }

    chats_holder.innerHTML += chat_message(true, sender_avatar_url, text_area.value)
    holder.scrollTop = holder.scrollHeight
  }
}
