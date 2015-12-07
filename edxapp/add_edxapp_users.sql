DELETE FROM auth_userprofile;
DELETE FROM auth_user;


INSERT INTO `auth_user`
(id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined)
VALUES
(1,'root','','','root@example.com','pbkdf2_sha256$20000$Z43Ig8BkDcuV$jXHDJ6hVlZ8mNvMzBc2E8Cvenn82nHU/f362dCW0Goo=',1,1,1,'2014-06-27 16:02:38','2014-06-27 16:02:38'),
(2,'honor','','','honor@example.com','pbkdf2_sha256$10000$SIYgUolRMd35$dt5ZeHX2ps7Coqglk8hSPRJxVEH3kVQkQllhTjnBJ04=',0,1,0,'2014-06-27 16:02:38','2014-06-27 16:02:38'),
(3,'audit','','','audit@example.com','pbkdf2_sha256$10000$sfNzLaI1CvBJ$AIqa6GSe5K3n0osFvUACtQZwoNJ8KUQ4PUREax2C8+k=',0,1,0,'2014-06-27 16:02:39','2014-06-27 16:02:39'),
(4,'verified','','','verified@example.com','pbkdf2_sha256$10000$RO9nkgfPoQTC$MLlcU1cXMLUIFk23RhhUitBQQOuO2G4GoANhLUqZYoU=',0,1,0,'2014-06-27 16:02:41','2014-06-27 16:02:41'),
(5,'staff','','','staff@example.com','pbkdf2_sha256$10000$JSgY8vhYcv8S$shZbfM9JrumafupkEbDHyghYGvUDvLOxhzc8YjQ8lOM=',1,1,0,'2014-06-27 16:02:43','2014-06-27 16:02:43');


INSERT INTO `auth_userprofile`
(id, user_id, name, language, location, meta, courseware, gender, mailing_address, year_of_birth, level_of_education, goals, allow_certificate, country, city)
VALUES
(1,1,'root','','','','course.xml',NULL,NULL,NULL,NULL,NULL,1,'',NULL),
(2,2,'honor','','','','course.xml',NULL,NULL,NULL,NULL,NULL,1,'',NULL),
(3,3,'audit','','','','course.xml',NULL,NULL,NULL,NULL,NULL,1,'',NULL),
(4,4,'verified','','','','course.xml',NULL,NULL,NULL,NULL,NULL,1,'',NULL),
(5,5,'staff','','','','course.xml',NULL,NULL,NULL,NULL,NULL,1,'',NULL);
