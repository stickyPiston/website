http = require "http"
fs   = require "fs"
path = require "path"

# Configuration

static_dirs = ["views", "css", "images", "js"]

routes =
  "/": "main.html",
  "/about": "main.html",
  "/projects": "main.html"

# Server logic

content_types =
  "js": "text/javascript"
  "html": "text/html"
  "css": "text/css"
  "png": "image/png"

server = http.createServer (req, res) ->
  if routes[req.url]
    extension = (routes[req.url].split ".").pop()
    res.writeHead 200, "Content-Type": content_types[extension] or "text/plain"
    fs.readFile (path.join __dirname, routes[req.url]), (err, data) -> res.end data
  else
    res.writeHead 404
    res.end "We couldn't find the page you're looking for"

# Add static routes (css, scripts, images)
for dir in static_dirs
  resolved_path = path.join __dirname, dir
  for file in fs.readdirSync resolved_path
    static_file = path.join dir, file
    routes["/" + static_file] = static_file

server.listen 80
