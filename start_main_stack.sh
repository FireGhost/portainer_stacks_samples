#!/bin/sh

portainer_host=subdomain.mydomain.tld
letsencrypt_email=myemail@domain.tld

docker run -d -p 80:80 -p 443:443 \
-v nginx_proxy_certs:/etc/nginx/certs \
-v nginx_proxy_dhparam:/etc/nginx/dhparam \
-v nginx_proxy_vhostd:/etc/nginx/vhost.d \
-v nginx_proxy_htpasswd:/etc/nginx/htpasswd \
-v nginx_proxy_html:/usr/share/nginx/html \
-v /var/run/docker.sock:/tmp/docker.sock:ro \
--label com.github.jrcs.letsencrypt_nginx_proxy_companion.nginx_proxy \
--name nginx-proxy \
--restart always \
jwilder/nginx-proxy:alpine

docker run -d \
-v /var/run/docker.sock:/var/run/docker.sock:ro \
--volumes-from nginx-proxy \
--name letsencrypt \
--restart always \
jrcs/letsencrypt-nginx-proxy-companion:latest

docker run -d \
-v portainer_data:/data \
-v /var/run/docker.sock:/var/run/docker.sock \
-e VIRTUAL_HOST=$portainer_host \
-e LETSENCRYPT_HOST=$portainer_host \
-e LETSENCRYPT_EMAIL=$letsencrypt_email \
--name portainer \
--restart always \
--cpu-shares=1536 \
portainer/portainer:latest \
-H unix:///var/run/docker.sock
