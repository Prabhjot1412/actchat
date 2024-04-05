export function setCookie(name, value) {
  document.cookie = `${name}=${value}`
  
  return getCookie(name)
}

export function getCookie(name) {
  let cookies = document.cookie

  if (!(cookies.includes(`${name}=`))) {
    return false
  }
  let start_index = cookies.indexOf(`${name}=`) + `${name}=`.length
  let target_cookie = cookies.slice(start_index)

  if (!target_cookie.includes(';')) { // last cookie in the list
    return target_cookie
  }

  target_cookie = target_cookie.slice(0, target_cookie.indexOf(';'))

  return target_cookie
}
