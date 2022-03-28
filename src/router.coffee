request_and_load = (url, transition = true) ->
  req = new XMLHttpRequest
  req.overrideMimeType "text/xml"
  load = ->
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
  req.onreadystatechange = ->
    if req.readyState is XMLHttpRequest.DONE and
       req.status is 200
      if transition
        document.getElementById "transition"
          .style.transformOrigin = "100% 100% 0"
        setTimeout (->
          load()
          document.getElementById "transition"
            .style.transform = "scale(0, 1)"
          document.getElementById "transition"
            .style.zIndex = 20
          document.getElementById "transition-text"
            .style.display = "none"
          document.body.style.overflow = "auto"), 750
      else
        load()
  req.open "GET", url
  req.send()

reset_page = ->
  # Remove custom scripts and styles
  tagNames = { "script": "js/router.js", "link": "css/main.css" }
  for own key, val of tagNames
    Array.from document.getElementsByTagName key
      .forEach (s) ->
        if key is "script"
          s.parentNode.removeChild s unless s.src.match val
        else
          s.parentNode.removeChild s unless s.href.match val

route_meta =
  "/":
    title: "Home"
    colour: "#f00"
  "/about":
    title: "About"
    colour: "#0f0"
  "/projects":
    title: "Projects"
    colour: "#00f"

animate_transition = ->
  window.scrollTo 0, 0
  document.body.style.overflow = "hidden"
  transition_div = document.getElementById "transition"
  transition_div.style.zIndex = 20
  transition_div.style.transformOrigin = "0 100% 0"
  transition_div.style.transform = "scale(1, 1)"
  transition_div.style.background = 
    route_meta[window.location.pathname].colour
  transition_text = document.getElementById "transition-text"
  transition_text.style.display = "inline-block"
  transition_text.innerText =
    route_meta[window.location.pathname].title

render = (transition = true) ->
  follow_route = ->
    switch window.location.pathname
      when "/" then request_and_load "/views/index.html", transition
      when "/about" then request_and_load "/views/about.html", transition
      when "/projects" then request_and_load "/views/projects.html", transition
  if transition
    animate_transition()
    setTimeout (-> reset_page(); follow_route()), 500
  else
    follow_route()

Array.from document.querySelectorAll "a[href]"
  .forEach (el) ->
    el.addEventListener "click", (e) ->
      e.preventDefault()
      window.history.pushState {}, "", e.target.href
      render()

render false

window.onpopstate = render
