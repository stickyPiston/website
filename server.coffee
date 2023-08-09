http  = require "http"
fs    = (require "fs").promises
path  = require "path"
mime  = require "mime-types"

# Configuration

static_dirs = ["views", "css", "images", "js"]

routes =
  "/": "main.html"
  "/about": "main.html"
  "/projects": "main.html"

# Server logic

handle_route = (req, res) ->
  try switch
    when req.url of routes
      content = await fs.readFile path.join __dirname, routes[req.url]
      res.writeHead 200, "Content-Type": (mime.lookup routes[req.url]) or "text/plain"
      res.end content
    when (req.url.split "/")[1] in static_dirs
      content = await fs.readFile path.join __dirname, req.url
      res.writeHead 200, "Content-Type": (mime.lookup req.url) or "text/plain"
      res.end content
    else
      res.writeHead 404, "Content-Type": "text/html"
      res.end await fs.readFile path.join __dirname, "views", "404.html"
  catch error
    console.error "server error: " + error
    res.writeHead 500, "Content-Type": "text/plain"
    res.end "Server error"

http.createServer handle_route
  .on "error", (msg) -> console.error "error starting server: " + msg
  .on "listening", -> console.log "server listening on port 3001"
  .listen 3001
