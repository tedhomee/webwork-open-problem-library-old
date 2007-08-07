##############################################################################
# W.K. Ziemer, 2004 wziemer@csulb.edu
##############################################################################


# DBsubject is the basic classification
# for problems, the subject area
#
DROP TABLE IF EXISTS `NPL-DBsubject`;
CREATE TABLE `NPL-DBsubject`
(
	DBsubject_id int(15) NOT NULL auto_increment,
	name varchar(127) NOT NULL,
	KEY DBsubject (name),
	PRIMARY KEY (DBsubject_id)
);

# DBchapter is a more refined classification
# for problem types
#
DROP TABLE IF EXISTS `NPL-DBchapter`;
CREATE TABLE `NPL-DBchapter`
(
	DBchapter_id int(15) NOT NULL auto_increment,
	name varchar(127) NOT NULL,
	DBsubject_id int(15) DEFAULT 0 NOT NULL,
	KEY DBchapter (name),
	KEY (DBsubject_id),
	PRIMARY KEY (DBchapter_id)
);

# DBsection is the finest classification
# for problem types
#
DROP TABLE IF EXISTS `NPL-DBsection`;
CREATE TABLE `NPL-DBsection`
(
	DBsection_id int(15) NOT NULL auto_increment,
	name varchar(255) NOT NULL,
	DBchapter_id int(15) DEFAULT 0 NOT NULL,
	KEY DBsection (name),
	KEY (DBchapter_id),
	PRIMARY KEY (DBsection_id)
);

# institution table contains all places using webwork
#
DROP TABLE IF EXISTS `NPL-institution`;
CREATE TABLE `NPL-institution`
(
	institution_id int (15) NOT NULL auto_increment,
	name varchar (255) NOT NULL,
	department varchar (255),
	address varchar (255),
	city varchar (255),
	state char(2),
	zipcode char(10),
	website varchar (255),
	KEY institution (name),
	PRIMARY KEY (institution_id)
);

# author table contains all problem authors
#
DROP TABLE IF EXISTS `NPL-author`;
CREATE TABLE `NPL-author`
(
	author_id int (15) NOT NULL auto_increment,
	institution_id int (15) NOT NULL,
	lastname varchar (100) NOT NULL,
	firstname varchar (100) NOT NULL,
	email varchar (255),
	KEY author (lastname, firstname),
	PRIMARY KEY (author_id)
);

# path table contains relative path, machine, and user ownership
#
DROP TABLE IF EXISTS `NPL-path`;
CREATE TABLE `NPL-path`
(
	path_id int(15) NOT NULL auto_increment,
	path varchar(127) NOT NULL,
	machine varchar(127),
	user varchar(127),
	KEY (path),
	PRIMARY KEY (path_id)
);

# pgfile table contains classification, location, and revision history about the .pg file
#
DROP TABLE IF EXISTS `NPL-pgfile`;
CREATE TABLE `NPL-pgfile`
(
	pgfile_id int(15) NOT NULL auto_increment,
	DBsection_id int(15) NOT NULL,
	author_id int(15),
	institution_id int(15),
	path_id int(15) NOT NULL,
	filename varchar(255) NOT NULL,
	history blob,
	PRIMARY KEY (pgfile_id)
);

# keywords for problems
#
DROP TABLE IF EXISTS `NPL-keyword`;
CREATE TABLE `NPL-keyword`
(
	keyword_id int(15) NOT NULL auto_increment,
	keyword varchar(65) NOT NULL,
	KEY (keyword),
	PRIMARY KEY (keyword_id)
);

# pgfile_keyword associates prolems with keywords
#
DROP TABLE IF EXISTS `NPL-pgfile-keyword`;
CREATE TABLE `NPL-pgfile-keyword`
(
	pgfile_id int(15) DEFAULT 0 NOT NULL,
	keyword_id int(15) DEFAULT 0 NOT NULL,
	KEY pgfile_keyword (keyword_id, pgfile_id),
	KEY pgfile (pgfile_id)
);

# pgfile_institution associates problems with institutions
#
DROP TABLE IF EXISTS `NPL-pgfile-institution`;
CREATE TABLE `NPL-pgfile-institution`
(
	pgfile_id int(15) DEFAULT 0 NOT NULL,
	institution_id int(15) DEFAULT 0 NOT NULL,
	PRIMARY KEY (institution_id, pgfile_id)
);

# textbook table contains textbook info
#
DROP TABLE IF EXISTS `NPL-textbook`;
CREATE TABLE `NPL-textbook`
(
	textbook_id int (15) NOT NULL auto_increment,
	title varchar (255) NOT NULL,
	edition int (3) DEFAULT 0 NOT NULL,
	author varchar (63) NOT NULL,
	publisher varchar (127),
	isbn char (15),
	pubdate varchar (27),
	PRIMARY KEY (textbook_id)
);

# weak table chapter
# chapters from a textbook
#
DROP TABLE IF EXISTS `NPL-chapter`;
CREATE TABLE `NPL-chapter`
(
	chapter_id int (15) NOT NULL auto_increment,
	textbook_id int (15),
	number int(3),
	name varchar(127) NOT NULL,
	page int(4),
	PRIMARY KEY (chapter_id)
	
);

# weak table section
# sections from a textbook chapter
#
DROP TABLE IF EXISTS `NPL-section`;
CREATE TABLE `NPL-section`
(
	section_id int(15) NOT NULL auto_increment,
	chapter_id int (15),
	number int(3),
	name varchar(127) NOT NULL,
	page int(4),
	PRIMARY KEY section (section_id)
);

# problem
# problems from a textbook
#
DROP TABLE IF EXISTS `NPL-problem`;
CREATE TABLE `NPL-problem`
(
	problem_id int(15) NOT NULL auto_increment,
	section_id int(15),
	number int(4) NOT NULL,
	page int(4),
	#KEY (page, number),
	KEY (section_id),
	PRIMARY KEY (problem_id)
	
);

# pgfile_problem table
# associates pgfiles to problems from a textbook.
#
DROP TABLE IF EXISTS `NPL-pgfile-problem`;
CREATE TABLE `NPL-pgfile-problem`
(
	pgfile_id int(15) DEFAULT 0 NOT NULL,
	problem_id int(15) DEFAULT 0 NOT NULL,
	PRIMARY KEY (pgfile_id, problem_id)
);

##############################################################################
# end of create_tables.sql
##############################################################################
