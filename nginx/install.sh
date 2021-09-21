#!/bin/bash

# install nginx rpm
#
rpm -iv ./nginx.rpm
systemctl start nginx
systemctl status nginx

# replace original index.html
#
cp /usr/share/nginx/html/index.html /usr/share/nginx/html/index.html.old
cp index.html /usr/share/nginx/html/index.html
cp uoblogo.png /usr/share/nginx/html
