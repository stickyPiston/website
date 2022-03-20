request_and_load = (url, hooks = []) ->
  req = new XMLHttpRequest
  req.onreadystatechange = () ->
    if req.readyState is XMLHttpRequest.DONE and
       req.status is 200
      (document.querySelector "main").innerHTML =
        (req.responseXML.querySelector "main").innerHTML
      hooks.forEach (hook) -> hook()
      Array.from document.querySelectorAll "a[href]"
        .forEach (el) ->
          el.addEventListener "click", (e) ->
            e.preventDefault()
            window.history.pushState {}, "", e.target.href
            render()
  req.open "GET", url
  req.send()

render = () ->
  switch window.location.pathname
    when "/" then request_and_load "/views/index.html"
    when "/about" then request_and_load "/views/about.html"
    when "/projects"
      request_and_load "/views/projects.html", [projects]

render()
