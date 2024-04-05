import consumer from "channels/consumer"

consumer.subscriptions.create("NotificationsChannel", {
  connected() {
    console.log('action-cable-notifications')
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    let count = document.getElementById('notification-count')

    if(!count) {
      return
    }

    count.innerText = data.notification_count
  }
});
