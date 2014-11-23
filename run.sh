docker run --rm --name magento2 -i -t -p 80:80 --link mysql:mysql -e MYSQL_USER=root -e MYSQL_PASSWORD=admin -e PUBLIC_HOST=$1 wsakaren/docker-magento2-demo-apache $*
