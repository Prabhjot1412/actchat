import { Controller } from "@hotwired/stimulus"

function getOtherButton(like_button, post_id) {
  let check_btn
  if (like_button.id == `like-${post_id}`) {
    check_btn = 'dislike'
  } else {
    check_btn = 'like'
  }

  return document.getElementById(`${check_btn}-${post_id}`)
}

export default class extends Controller {
  connect() {
    console.log("posts")
  }

  liked(event) {
    let like_button = event.target
    let post_id = like_button.getAttribute('post-id')
    let other_button = getOtherButton(like_button, post_id)
    let likes_count = document.getElementById(`likes-count-${post_id}`)
    let btn_type = like_button.getAttribute('btn-type')
    let like_value = like_button.classList.contains('posts-disabled') ? 2 : 1

    fetch(`/posts/vote?post_id=${post_id}&type=${btn_type}`)
    
    if (btn_type == 'like') {
      likes_count.innerText = parseInt(likes_count.innerText) + like_value
    } else {
      likes_count.innerText = parseInt(likes_count.innerText) - like_value
    }

    like_button.classList.remove('posts-animate-unliked')
    like_button.classList.remove('posts-disabled')
    like_button.classList.add('posts-animate-liked')
    like_button.setAttribute('data-action', 'click->posts#unliked')

    other_button.classList.add('posts-disabled')
    other_button.classList.remove('posts-animate-liked')
    other_button.setAttribute('data-action', 'click->posts#liked')
  }

  unliked(event) {
    let like_button = event.target
    let post_id = like_button.getAttribute('post-id')
    let other_button = getOtherButton(like_button, post_id)
    let likes_count = document.getElementById(`likes-count-${post_id}`)
    let btn_type = like_button.getAttribute('btn-type')

    fetch(`/posts/unlike?post_id=${post_id}`)

    if (btn_type == 'like') {
      likes_count.innerText = parseInt(likes_count.innerText) - 1
    } else {
      likes_count.innerText = parseInt(likes_count.innerText) + 1
    }

    like_button.classList.add('posts-animate-unliked')
    like_button.classList.remove('posts-animate-liked')
    like_button.setAttribute('data-action', 'click->posts#liked')

    other_button.classList.remove('posts-disabled')
  }
}
