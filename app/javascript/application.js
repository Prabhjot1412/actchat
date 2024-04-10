// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import './src/fetch_posts'
import "channels"

import "trix"
import "@rails/actiontext"

window.addEventListener('blur', () => {
  document.title = 'Come Back °՞(ᗒᗣᗕ)՞°'
})

window.addEventListener('focus', () => {
  document.title = 'Actchat'
})