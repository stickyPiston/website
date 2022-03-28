window.locale = ((navigator.language || navigator.userLanguage).split "-")[0]

other_locale = (locale) ->
  if locale is "en" then "nl" else "en"

document.getElementById "locale"
  .src = "/images/" + (other_locale locale) + ".png"

window.translate = ->
  Array.from document.querySelectorAll "[lang=#{locale}]"
    .forEach (el) -> el.style.display = "inline-block"
  Array.from document.querySelectorAll "[lang=#{other_locale locale}]"
    .forEach (el) -> el.style.display = "none"
  update_title()

document.getElementById "locale"
  .addEventListener "click", (e) ->
    window.locale = if locale is "en" then "nl" else "en"
    e.target.src = "/images/" + (other_locale locale) + ".png"
    translate()
