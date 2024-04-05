export function flash_notice(msg) {
  let flash_notice = document.createElement('p')
  flash_notice.classList.add('alert', 'alert-info', 'notices-fadeout')
  flash_notice.innerText = msg

  document.getElementById('flash-messages-container').appendChild(flash_notice)
}

export function flash_alert(msg) {
  let flash_notice = document.createElement('p')
  flash_notice.classList.add('alert', 'alert-danger', 'notices-fadeout')
  flash_notice.innerText = msg

  document.getElementById('flash-messages-container').appendChild(flash_notice)
}