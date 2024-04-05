import { Controller } from "@hotwired/stimulus"

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
      } else {
        alert(data.message)
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
        alert(data.message)
      }
    })
  }
}
