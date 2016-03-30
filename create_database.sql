--Create database DBFiverr
USE [master]
GO
--Check if database exists
IF DB_ID('DBFiverr') IS NOT NULL
	DROP DATABASE [DBFiverr]
GO
--Create the database
CREATE DATABASE [DBFiverr]
GO
use DBFiverr

--creating person table
CREATE TABLE Person(
	email_id varchar(100),
	password binary(64) NOT NULL,
	first_name varchar(100) NOT NULL,
	last_name varchar(100) NOT NULL,
	credit money DEFAULT 0,
	CONSTRAINT ck_checkmoneypositive CHECK (credit >= 0),
	CONSTRAINT pk_email PRIMARY KEY (email_id)
	);
GO

--creating table category
CREATE TABLE Category(
	category_id int,
	category_name varchar(100) NOT NULL,
	CONSTRAINT pk_categoryid PRIMARY KEY (category_id)
	);
GO

--creating mapping table between person and category
CREATE TABLE Person_Category(
	email_id varchar(100), 
	category_id int,
	CONSTRAINT pk_email_category PRIMARY KEY (email_id, category_id),
	CONSTRAINT fk_email FOREIGN KEY (email_id) REFERENCES Person(email_id),
	CONSTRAINT fk_categorgy FOREIGN KEY (category_id) REFERENCES Category(category_id)
	);
GO

--creating table new request
CREATE TABLE New_Request(
	request_id uniqueidentifier 
		DEFAULT newid(),
	email_id varchar(100) NOT NULL,
	category_id int NOT NULL, 
	description varchar(max),
	deadline datetime, 
	CONSTRAINT pk_requestid PRIMARY KEY (request_id),
	CONSTRAINT fk_email_request FOREIGN KEY (email_id) REFERENCES Person(email_id),
	CONSTRAINT fk_categorgy_request FOREIGN KEY (category_id) REFERENCES Category(category_id)
	);
GO

--creating table pending request
CREATE TABLE Pending_Request(
	pending_request_id int,
	requester_id varchar(100) NOT NULL,
	provider_id varchar(100) NOT NULL,
	category_id int NOT NULL, 
	description varchar(max),
	deadline datetime, 
	CONSTRAINT pk_pending_requestid PRIMARY KEY (pending_request_id),
	CONSTRAINT fk_email_requester FOREIGN KEY (requester_id) REFERENCES Person(email_id),
	CONSTRAINT fk_email_provider FOREIGN KEY (provider_id) REFERENCES Person(email_id),
	CONSTRAINT fk_categorgy_byrequester FOREIGN KEY (category_id) REFERENCES Category(category_id)
	);
GO

--creating table completed request
CREATE TABLE Completed_Request(
	completed_request_id int,
	requester_id varchar(100) NOT NULL,
	provider_id varchar(100) NOT NULL,
	category_id int NOT NULL, 
	description varchar(max),
	accepted bit NOT NULL, 
	CONSTRAINT pk_completed_requestid PRIMARY KEY (completed_request_id),
	CONSTRAINT fk_email_requester_complete FOREIGN KEY (requester_id) REFERENCES Person(email_id),
	CONSTRAINT fk_email_provider_complete FOREIGN KEY (provider_id) REFERENCES Person(email_id),
	CONSTRAINT fk_categorgy_byrequester_complete FOREIGN KEY (category_id) REFERENCES Category(category_id)
	);
GO


--creating table service
CREATE TABLE Service(
	service_id uniqueidentifier 
		DEFAULT newid(),
	email_id varchar(100) NOT NULL,
	category_id int NOT NULL, 
	description varchar(max), 
	CONSTRAINT pk_serviceid PRIMARY KEY (service_id),
	CONSTRAINT fk_service_provider_email FOREIGN KEY (email_id) REFERENCES Person(email_id),
	CONSTRAINT fk_service_category FOREIGN KEY (category_id) REFERENCES Category(category_id)
	);
GO

--creating table message
CREATE TABLE Message(
	message_id uniqueidentifier 
		DEFAULT newid(),
	author_id varchar(100) NOT NULL,
	thread_id uniqueidentifier 
		DEFAULT newid(),
	msg_subject varchar(100),
	body varchar(max),
	msg_date datetime, 
	CONSTRAINT pk_messageid PRIMARY KEY (message_id),
	CONSTRAINT fk_author_email FOREIGN KEY (author_id) REFERENCES Person(email_id)
	);
GO

--creating table placeholder
CREATE TABLE Placeholder(
	placeholder_id int IDENTITY,
	placeholder_name varchar(50),
	CONSTRAINT pk_placeholderid PRIMARY KEY (placeholder_id)
	);
Go


--creating mapping table person_message
--thread_id in user message and message are not linked because we want to delete the mappings to remove the messasge from a user's folder but not the message from the message table so that it exists in other users folders if the conversation  exists

CREATE TABLE Person_Message(
	email_id varchar(100),
	message_id uniqueidentifier 
		DEFAULT newid(),
	placeholder_id int NOT NULL,
	thread_id uniqueidentifier 
		DEFAULT newid(),
	is_read bit DEFAULT 0, 
	CONSTRAINT pk_person_message PRIMARY KEY (email_id,message_id),
	CONSTRAINT fk_email_person FOREIGN KEY (email_id) REFERENCES Person(email_id),
	CONSTRAINT fk_placeholder FOREIGN KEY (placeholder_id) REFERENCES Placeholder(placeholder_id)
	);
GO


