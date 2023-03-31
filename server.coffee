https = require "https"
http  = require "http"
fs    = (require "fs").promises
path  = require "path"
mime  = require "mime-types"

# Configuration

cert_path = "/etc/letsencrypt/live/jobbel.nl/fullchain.pem"
key_path  = "/etc/letsencrypt/live/jobbel.nl/privkey.pem"

static_dirs = ["views", "css", "images", "js", ".well-known"]

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
    when req.url.startsWith "/.well-known"
      content = await fs.readFile path.join "/var/www/certbot", req.url
      res.writeHead 200, "text/plain"
      res.end content
    when (req.url.split "/")[1] in static_dirs
      content = await fs.readFile path.join __dirname, req.url
      res.writeHead 200, "Content-Type": (mime.lookup req.url) or "text/plain"
      res.end content
    else
      res.writeHead 404, "Content-Type": "text/plain"
      res.end "We couldn't find the page you're looking for"
  catch error
    console.error "server error: " + error
    res.writeHead 500, "Content-Type": "text/plain"
    res.end "Server error"

start_http = ->
  http.createServer handle_route
    .on "error", (msg) -> console.error "error starting server: " + msg
    .listen 80

start_https = ->
  if (await fs.exists cert_path) and (await fs.exists key_path)
    cert = await fs.readFile cert_path ; key = await fs.readFile key_path
    https.createServer { key, cert }, handle_route
      .on "error", (msg) -> console.error "error starting server: " + msg
      .listen 443

repeat_every = (time, func) -> setInterval func, time
day = 1000 * 60 * 60 * 24

do ->
  try
    server = {}
    server.http = do start_http
    repeat_every day, ->
      do server.https.close if server.https
      server.https = do start_https
  catch error
    console.error "error starting server: " + error
