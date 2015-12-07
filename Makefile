# TODO: Checkout the edX platform

all: build_stuff
	# The default step, build without run.
	echo Now you can run the stack using $ docker-compose up


build_stuff: build_images lms_install_github_prereqs db_initialize_mysql
	# Build the images.
	echo Done buidling images and database


dangerous_clean_and_run: dangerous_clean build_stuff
	# Clean everything, rebuild and run `$ paver lms` to test this docker setup.
	docker-compose up


dangerous_clean: dangerous_remove_instances dangerous_remove_compose_stuff dangerous_remove_volumes
	# Clean everything: instances, volumnes and WIPE everything else.
	echo Done cleanup


dangerous_remove_instances:
	# Kill all the docker-compose instances (this will loose some run data).
	docker-compose kill


dangerous_remove_compose_stuff:
	# Remove the compose instances (this will loose some run data).
	docker-compose rm --force mysql
	docker-compose rm --force memcached
	docker-compose rm --force mongo
	docker-compose rm --force lms


dangerous_remove_volumes:
	# Remove all the volumnes (this will remove the database and other data).
	echo 'Are you sure? This will remove your databases?'
	echo ' - Press Ctrl-C to exit'
	echo ' - Press Enter to continue'

	read _anything_
	sudo rm -rf ./docker-vols


build_images:
	# Rebuild the lms image and other images if requried.
	# This step will take some time to build the image...
	docker-compose build


lms_install_github_prereqs:
	# Installs the github requirements in the `edx-platform/src/` dir.

	docker-compose run lms pip install --exists-action w -r requirements/edx/github.txt

db_initialize_mysql:
	# Build the database from scratch: create database and migrate it.

	# Waiting mysql to launch (Quit using Ctrl-C this if it takes more than 1 minute)...
	# wait for 1/10 of the second before check again
	while ! docker-compose run lms nc -z mysql 3306; \
	do \
		sleep 0.1; \
		echo -n .; \
	done

	# mysql is launched.

	# Creating database edxapp...
	# TODO Check if this is not consistnent with edX
	docker-compose run lms mysql --host mysql --default-character-set=utf8 -u root -ppassword < edxapp/create_edxapp.sql

	# Splitting this into three steps to avoid a bug in `0002_remove_article_subscription`
	# Migrating...
	docker-compose run lms python manage.py lms migrate wiki 0001_initial --settings=docker
	docker-compose run lms python manage.py lms migrate wiki 0002_remove_article_subscription --fake --settings=docker
	docker-compose run lms python manage.py lms migrate --settings=docker
	docker-compose run lms python manage.py cms migrate --settings=docker

	docker-compose run lms mysql --host mysql --default-character-set=utf8 -u root -ppassword edxapp < edxapp/add_edxapp_users.sql
