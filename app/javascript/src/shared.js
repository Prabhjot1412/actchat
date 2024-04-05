export function chat_message(sent_by_current, sender_avatar_url, data) {
 return `
  <div class='d-flex mt-3' style=${sent_by_current ? 'justify-content:end;flex-direction:row-reverse' : ''}>
    <div>
      <img src="${sender_avatar_url}" width="60" height="60" class='rounded' style='margin-right: 5px; margin-top: 3px;'>
    </div>

    <div class='mx-4 my-1 chats-message'>
      <span>${data}</span>
    </div>
  </div
`
}