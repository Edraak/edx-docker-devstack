all: build
	# The default step, build without run.
	echo Now you can run the stack using $ docker-compose up


build: build_syslog build_images copy_platform_code db_initialize_mysql
	# Build the images.
	echo Done buidling images and database

build_syslog:
	docker build -t edx-devstack-syslog https://github.com/Edraak/syslogdocker.git


copy_platform_code:
	bash ensure_empty_dir.sh ../edx-platform/
	bash ensure_empty_dir.sh ../envs-edx/

	docker-compose run --no-deps lms bash /edx/app/edxapp/copy_code.sh

	sudo chown -R $$USER:$$USER ../edx-platform ../envs-edx


print_warning:
	echo 'DANGER ZONE!'
	echo 'This will remove your databases, CODE, and anything local!'
	echo 'Are you sure?'
	echo ' - Press Ctrl-C to exit'
	echo ' - Press Enter to continue'

	read _


danger_remove_code: print_warning
	sudo rm -rf ../edx-platform/ ../envs-edx/


danger_kill_and_remove_volumes: print_warning
	# Remove all the volumes to cleanup the state
	docker-compose kill
	docker-compose rm --force -v


danger_remove_everything: danger_remove_code danger_kill_and_remove_volumes
	# Remove all the volumnes and everything.
	echo 'Your data is now gone.!'


build_images:
	# Rebuild the lms image and other images if requried.
	# This step will take some time to build the image...
	docker-compose build


quick_edxapp_restart:
	touch ../edx-platform/lms/urls.py ../edx-platform/cms/urls.py


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
	docker-compose run lms mysql --host mysql --default-character-set=utf8 -u root -ppassword < build/edxapp/create_edxapp.sql

	# Splitting this into three steps to avoid a bug in `0002_remove_article_subscription`
	# Migrating...
	docker-compose run lms python manage.py lms migrate wiki 0001_initial --settings=docker
	docker-compose run lms python manage.py lms migrate wiki 0002_remove_article_subscription --fake --settings=docker
	docker-compose run lms python manage.py lms migrate --settings=docker
	docker-compose run lms python manage.py cms migrate --settings=docker

	docker-compose run lms mysql --host mysql --default-character-set=utf8 -u root -ppassword edxapp < build/edxapp/add_edxapp_users.sql
