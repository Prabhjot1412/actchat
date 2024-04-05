import consumer from "channels/consumer"
import { chat_message } from "../src/shared";

consumer.subscriptions.create("ChatChannel", {
  connected() {
    console.log('chat-channel')
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log(data)
    let chats_holder = document.getElementById('chats-holder')
    let active_chat = document.getElementById('chats-friend-item-active')

    if(!chats_holder || !active_chat || parseInt(active_chat.getAttribute('friend-id')) != parseInt(data['sender_id']) ) {
      return
    }

    let holder = document.getElementById('holder')

    chats_holder.innerHTML += chat_message(false, data["avatar_url"], data["message"])
    holder.scrollTop = holder.scrollHeight
  }
});
