# Jobbel.nl

## Installation

Make a certbot.ini with the following contents and then run `docker-compose up`

```ini
email = <your email here>
authenticator = webroot
webroot-path = /var/www/certbot
agree-tos = true
```