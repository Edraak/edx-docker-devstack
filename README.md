#Docker DevStack for the edX Platform



Build the stack:

Install `make`, `docker` and `docker-compose` and run the following commands:

    $ cd compose/
    $ make
    $ docker-compose up


It should take no less than 30 minutes to build, but up to 4 hours based on your Internet connection and workstation specs.


Once it works you'll have the following pages:

 - [www.local.edx.org](http://www.local.edx.org)
 - [studio.local.edx.org](http://studio.local.edx.org)
