import {getCookie, setCookie} from './cookies'

window.onscroll = function(ev) {
  if(document.getElementById('posts_container') == null) {
    return
  }

  if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight -4 && window.scrollY >= 7) {
    if(!getCookie('page') || getCookie('page') == '') {
      setCookie('page', 2)
    } else {
      setCookie('page', parseInt(getCookie('page')) + 1)
    }

    let additional_params = '?'
    if(!(document.getElementById('personel') == null)) {
      additional_params += 'type=personel&'
    }

    let urlParams = new URLSearchParams(window.location.search);
    let id = urlParams.get('id')
    if(!!id) {
      additional_params += `id=${id}&`
    }

    let base_path = document.head.querySelector("meta[name=base_path]").content
    let res = fetch(`${base_path}posts/${getCookie('page')}${additional_params}`)


    res.then((response) => {
      return response.json()
    }).then((data) => {
      let posts_container = document.getElementById('posts_container')

      for (var key in data) {
        let post = data[key]
        let post_html =
        `
        <div class='d-flex justify-content-center py-3' style='padding-bottom: 5px;'>
          <div class="card" style="width: 60rem">
            <div class="card-body">
              <h5 class="card-title">
                <img src='${post.avatar_url}' width="30" height="30" class='rounded'>

                <span style='margin-left: 8px'> ${post.owner_name} </span>
              </h5>

              ${post.image_attached ? `<img class='my-3 ' src='${post.image_url}' width='900' height='500'>` : ''}

              <p class="card-text mt-3" style='margin-left: 9px; max-height: 30rem; overflow: auto'> ${post.text} </p>
            </div>
          </div>
        </div>
        `

        posts_container.innerHTML += post_html
      };
    })
  }
};

window.onunload = function(ev) {
  setCookie('page', '')
}
