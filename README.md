# Portainer Stacks Samples
This repo contains some usefull stacks for the Portainer docker tool

# Main stack
The main stack from this repo is an *nginx-proxy + letsencrypt companion + portainer* stack.

All the stacks from this repo is using the environment variables given by the *nginx-proxy* image and the *letsencrypt* image.

The mandatory variables for each sites are:
- VIRTUAL_HOST=mydomain.tld
- LETSENCRYPT_HOST=mydomain.tld
- LETSENCRYPT_EMAIL=mymail@adresse.tld

And, sometimes, it uses those variables as well:
- VIRTUAL_PROTO=https
- VIRTUAL_PORT=443

For the *VIRTUAL_\** variables, check the documentation on https://hub.docker.com/r/jwilder/nginx-proxy/.
And for the *LETSENCRYPT_\** variables, the documentation https://hub.docker.com/r/jrcs/letsencrypt-nginx-proxy-companion/.
