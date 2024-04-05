import { Controller } from "@hotwired/stimulus"
import { flash_notice, flash_alert } from "../src/flash"

export default class extends Controller {
  connect() {
    console.log("notification")
  }

  accept(event) {
    let notification_id = event.target.getAttribute('notification-id')
    let accept_notification_url = `/notifications/accept?notification_id=${notification_id}`
    let res = fetch(accept_notification_url)

    res.then((response) => {
      return response.json()
    }).then((data) => {
      if (data.status == 'success') {
        document.getElementById(`notification-${notification_id}`).remove()
        flash_notice('Friend Request Accepted')
      } else {
        flash_alert(data.message)
      }
    })
  }

  reject(event) {
    let notification_id = event.target.getAttribute('notification-id')
    let reject_notification_url = `/notifications/reject?notification_id=${notification_id}`
    let res = fetch(reject_notification_url)

    res.then((response) => {
      return response.json()
    }).then((data) => {
      if (data.status == 'success') {
        document.getElementById(`notification-${notification_id}`).remove()
      } else {
        flash_alert(data.message)
      }
    })
  }

  send(event) {
    let icon = document.getElementById('friend-request-icon')
    let sender_id = event.target.getAttribute('sender-id')
    let receiver_id = event.target.getAttribute('receiver-id')

    if (icon.classList.contains('fa-user-plus')) {
      let res = fetch(`/notifications/send_notification?sender_id=${sender_id}&receiver_id=${receiver_id}`)

      res.then((response) => {
        return response.json()
      }).then((data) => {
        if (data.status != 'success') {
          flash_alert(data.message)
        } else {
          icon.style.transform = 'rotate(360deg)'
          icon.classList.remove('fa-user-plus', 'friend-request-send')
          icon.classList.add('fa-user-minus', 'friend-request-sent')
        }
      })
    } else {
      let res = fetch(`/notifications/reject?sender_id=${sender_id}&receiver_id=${receiver_id}`)

      res.then((response) => {
        return response.json()
      }).then((data) => {
        if (data.status != 'success') {
          flash_alert(data.message)
        } else {
          icon.style.transform = 'rotate(0deg)'
          icon.classList.remove('fa-user-minus', 'friend-request-sent')
          icon.classList.add('fa-user-plus', 'friend-request-send')    
        }
      })
    }
  }
}
