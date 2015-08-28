# docker-odoo9

Docker container for [Odoo 9][3]

"Odoo is the fastest evolving business software in the world. Odoo has a complete suite of business applications covering all business needs, from Website/Ecommerce down to manufacturing, inventory and accounting, all seamlessly integrated. It is the first time ever a software editor managed to reach such a functional coverage."

note : this to test and learn about the future release of Odoo .. This is pre-release and not recomended for deployment please used Odoo 8 (quantumobject/docker-odoo) when oddo 9 is finally release this container will replace the odoo 8 container. 

## Install dependencies

  - [Docker][2]

To install docker in Ubuntu 14.04 use the commands:

    $ sudo apt-get update
    $ wget -qO- https://get.docker.com/ | sh

 To install docker in other operating systems check [docker online documentation][4]

## Usage

To run container use the command below:

    $ docker run -d -p 8069 -p 8070 quantumobject/docker-odoo9
 
## Accessing the Odoo applications:

After that check with your browser at addresses plus the port assigined by docker for port 8069:

  - **http://host_ip:port/**
 
Them you can log-in admin/admin for the master management account. Please change the password.   

To access the container from the server that the container is running :

    $ docker exec -it container_id /bin/bash

## More Info

About Odoo [www.odoo.com][1]

To help improve this container [quantumobject/docker-odoo9][5]

[1]:https://www.odoo.com
[2]:https://www.docker.com
[3]:https://www.odoo.com/slides/slide/keynote-odoo-9-new-features-201
[4]:http://docs.docker.com
[5]:https://github.com/QuantumObject/docker-odoo9
