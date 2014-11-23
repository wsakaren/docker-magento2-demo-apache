#!/bin/bash

docker build -t docker-magento2-demo-apache .

echo To publish use:
echo docker tag docker-magento2-demo-apache wsakaren/docker-magento2-demo-apache
echo docker tag docker-magento2-demo-apache wsakaren/docker-magento2-demo-apache:0.1.0-alpha102
echo docker push wsakaren/docker-magento2-demo-apache:0.1.0-alpha102
