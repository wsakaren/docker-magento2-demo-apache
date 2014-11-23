# Magento 2 (alpha) Demo

[Magento](http://magento.com/) is an open source ecommerce engine,
developed by eBay Inc powering 240,000+ online ecommerce sites.
Magento 2 is the next major platform release of Magento.
The Magento 2 code base is pushed weekly to GitHub during development.

## Docker

Docker is basically a platform which allows you to build a VM-like environment.

With Docker you can have containers for each separate 'component' and then connected these containers together.

The containers themseleves are generated via scripts, and can run anywhere.

### Installing Docker on a MAC 

1. Install the [OSX Installer](https://github.com/boot2docker/osx-installer/releases/tag/v1.3.1)
2. In Applications run boot2docker.app
3. Run the hello world app to ensure its working - docker run hello-world

### Further Info

- Installation - [https://docs.docker.com/installation/mac/](https://docs.docker.com/installation/mac/)

- Cheat Sheet - [https://github.com/wsargent/docker-cheat-sheet](https://github.com/wsargent/docker-cheat-sheet)

- Creating Images - [https://docs.docker.com/userguide/dockerimages/#creating-our-own-images](https://docs.docker.com/userguide/dockerimages/#creating-our-own-images)


## Containers

Only two containers are currently involved:

1. Standard MySQL database container ('mysql')
2. Magento 2 container

### Running MySQL


You need to start the MySQL container yourself. Please name the container 'mysql'
and expose port 3306 for the Magento 2 container to use. For the purpose
of this demo, set the 'root' account password to 'admin'. 

Note: An interesting experiment for the reader is to replace the 'mysql' container with a Maria DB instance.


This command will run the container

    docker run --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=admin mysql
    
To stop mysql 
    
    docker stop

To restart mysql after the container has been created 
    
    docker start

### Running Magento2

This can only be run once the MySQL container is running.

This command will run the container

    ./run.sh yourhost.example.com
    
Under the hood this runs the command

    docker run --rm --name magento2 -p 80:80 --link mysql:mysql \
       -e MYSQL_USER=root -e MYSQL_PASSWORD=admin \
       -e PUBLIC_HOST=yourhost.example.com \
       wsakaren/docker-magento2-demo-apache
       
When this container is started, it loops waiting for a succesful
connection to the MySQL database. Once achieved it runs a PHP script
to create the database. A MySQL dump is then loaded to put a few
products into the database. These two steps can take up to 30 seconds.
Finally Apache is run. After it is running site can be connected to
using a web browser.

## Files

* **Dockerfile** - Contains instructions to build Magento 2 using Composer (PHP packaging system). It also loads a SQL dump of a database with a few sample records so you can perform queries out of the box. Trying querying for 'jacket'
* **build.sh** - Creates the Magento 2 container using the Dockerfile
* **run.sh** - Links the Magento 2 container to the MySQL Container


## Using Magento 2

Magento 2 is still under active development. A developer beta is due
for release late 2014 with GA in 2015. The steps for installing
Magento 2 are not finalized and are subject to change before final
release. That is in part why this demonstration was put together.
To make it easier for someone to get Magento 2 running.

To access the store front, use http://yourhost.example.com (the host
name supplied as PUBLIC_HOST above). To access the admin interface,
use http://yourhost.example.com/index.php/backend with a username
of 'admin' and password of 'admin123'. (Obviously this is not
intended for production usage!)

Be aware if you start a new container instance, it will wipe the
database and start again.

This script currently does not load up any products - it is more to
demonstrate the installation steps. Sample data is "coming soon".
