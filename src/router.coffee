request_and_load = (url, hooks = []) ->
  req = new XMLHttpRequest
  req.onreadystatechange = () ->
    if req.readyState is XMLHttpRequest.DONE and
       req.status is 200
      (document.querySelector "main").innerHTML =
        (req.responseXML.getElementById "content").innerHTML
      (document.querySelector "head").innerHTML =
        (req.responseXML.getElementById "head").innerHTML
      Array.from (req.responseXML.getElementById "scripts").children
        .forEach (s) ->
          script = document.createElement "script"
          script.src = s.getAttribute "src"
          document.querySelector "body"
            .appendChild script
  req.open "GET", url
  req.send()

resetPage = () ->
  # Remove custom scripts and styles
  tagNames = { "script": "js/router.js", "link": "css/main.css" }
  for own key, val of tagNames
    Array.from document.getElementsByTagName key
      .forEach (s) ->
        if key is "script"
          s.parentNode.removeChild s unless s.src.match val
        else
          s.parentNode.removeChild s unless s.href.match val

render = () ->
  resetPage()
  switch window.location.pathname
    when "/" then request_and_load "/views/index.html"
    when "/about" then request_and_load "/views/about.html"
    when "/projects" then request_and_load "/views/projects.html"

Array.from document.querySelectorAll "a[href]"
  .forEach (el) ->
    el.addEventListener "click", (e) ->
      e.preventDefault()
      window.history.pushState {}, "", e.target.href
      render()

render()
