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
	firstname varchar(100) NOT NULL,
	lastname varchar(100) NOT NULL,
	totalcredit money DEFAULT 0,
	reservedcredit money DEFAULT 0,
	CONSTRAINT ck_checkmoneypositive CHECK (totalcredit >= 0),
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
	title  varchar(max),
	description varchar(max),
	date datetime DEFAULT getdate(),
	days_to_complete int, 
	CONSTRAINT pk_requestid PRIMARY KEY (request_id),
	CONSTRAINT fk_email_request FOREIGN KEY (email_id) REFERENCES Person(email_id),
	CONSTRAINT fk_categorgy_request FOREIGN KEY (category_id) REFERENCES Category(category_id)
	);
GO

--creating table pending request
CREATE TABLE Pending_Request(
	pending_request_id uniqueidentifier default NEWID(),
	requester_id varchar(100) NOT NULL,
	provider_id varchar(100) NOT NULL,
	category_id int NOT NULL, 
	title  varchar(max),
	description varchar(max),
	date datetime DEFAULT getdate(),
	deadline datetime, 
	CONSTRAINT pk_pending_requestid PRIMARY KEY (pending_request_id),
	CONSTRAINT fk_email_requester FOREIGN KEY (requester_id) REFERENCES Person(email_id),
	CONSTRAINT fk_email_provider FOREIGN KEY (provider_id) REFERENCES Person(email_id),
	CONSTRAINT fk_categorgy_byrequester FOREIGN KEY (category_id) REFERENCES Category(category_id)
	);
GO

--creating table completed request
CREATE TABLE Completed_Request(
	completed_request_id uniqueidentifier default NEWID(),
	requester_id varchar(100) NOT NULL,
	provider_id varchar(100) NOT NULL,
	category_id int NOT NULL,
	title  varchar(max), 
	description varchar(max),
	date datetime DEFAULT getdate(),
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
	title  varchar(max),
	description varchar(max), 
	date datetime DEFAULT getdate(),
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
	request_id uniqueidentifier null,
	thread_id uniqueidentifier 
		DEFAULT newid(),
	msg_subject varchar(100),
	body varchar(max),
	msg_date datetime, 
	CONSTRAINT pk_messageid PRIMARY KEY (message_id),
	CONSTRAINT fk_request_id FOREIGN KEY (request_id) REFERENCES New_Request(request_id),
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

CREATE TABLE Automated_Message(
	auto_message_id int identity(1,1),
	subject  varchar(max),
	body varchar(max),
	CONSTRAINT pk_automated_message PRIMARY KEY (auto_message_id)
);
GO

--Insert records into Person table
INSERT [dbo].Person (email_id, password, firstname, lastname) VALUES ('john.doe@gmail.com', HASHBYTES('SHA2_512', 'vfdwes'), N'John',N'Doe');
INSERT [dbo].Person (email_id, password, firstname, lastname) VALUES ('michelle.davison@gmail.com', HASHBYTES('SHA2_512', 'adsvc'), N'Michelle',N'Davison');
INSERT [dbo].Person (email_id, password, firstname, lastname) VALUES ('mayteh.kendall@yahoo.com', HASHBYTES('SHA2_512', 'ghjgss'), N'Kendall',N'Mayteh');
INSERT [dbo].Person (email_id, password, firstname, lastname) VALUES ('bruce.onandonga12@gmail.com', HASHBYTES('SHA2_512', 'vhbdsserfsa'), N'Onandonga',N'Bruce');
INSERT [dbo].Person (email_id, password, firstname, lastname) VALUES ('tony.antavius@asu.edu', HASHBYTES('SHA2_512', 'vcngfhgfscx'), N'Antavius',N'Anthony');
INSERT [dbo].Person (email_id, password, firstname, lastname) VALUES ('danny.bradley34@gmail.com', HASHBYTES('SHA2_512', 'jtkjhkhfg'), N'Bradlee',N'Danny');
INSERT [dbo].Person (email_id, password, firstname, lastname) VALUES ('reynaldo.suscipe@gmail.com', HASHBYTES('SHA2_512', 'asgfdvger'), N'Suscipe',N'Reynaldo');
INSERT [dbo].Person (email_id, password, firstname, lastname) VALUES ('ger.sullivan@asu.edu', HASHBYTES('SHA2_512', 'sgfdhgft'), N'Sullivan',N'Geraldine');
INSERT [dbo].Person (email_id, password, firstname, lastname) VALUES ('nicole.reh123@gmail.com', HASHBYTES('SHA2_512', 'ssfsfawqq'), N'Nicole',N'Rehdahl');
INSERT [dbo].Person (email_id, password, firstname, lastname) VALUES ('katy.smith@yahoo.com', HASHBYTES('SHA2_512', 'bgfbrtsf'), N'Katy',N'Smith');

--Insert sample categories for services
INSERT [dbo].Category (category_id, category_name) VALUES (1, 'Graphics & Design');
INSERT [dbo].Category (category_id, category_name) VALUES (2, 'Digital Marketing');
INSERT [dbo].Category (category_id, category_name) VALUES (3, 'Video & Animation');
INSERT [dbo].Category (category_id, category_name) VALUES (4, 'Audio & Music');
INSERT [dbo].Category (category_id, category_name) VALUES (5, 'Programming & Technology');
INSERT [dbo].Category (category_id, category_name) VALUES (6, 'Advertising');

--insert each persons category preferences
INSERT [dbo].Person_Category (email_id, category_id) VALUES ('john.doe@gmail.com', 1);
INSERT [dbo].Person_Category (email_id, category_id) VALUES ('john.doe@gmail.com', 3);
INSERT [dbo].Person_Category (email_id, category_id) VALUES ('john.doe@gmail.com', 4);
INSERT [dbo].Person_Category (email_id, category_id) VALUES ('michelle.davison@gmail.com', 4);
INSERT [dbo].Person_Category (email_id, category_id) VALUES ('michelle.davison@gmail.com', 2);
INSERT [dbo].Person_Category (email_id, category_id) VALUES ('michelle.davison@gmail.com', 5);
INSERT [dbo].Person_Category (email_id, category_id) VALUES ('mayteh.kendall@yahoo.com', 6);
INSERT [dbo].Person_Category (email_id, category_id) VALUES ('mayteh.kendall@yahoo.com', 3);
INSERT [dbo].Person_Category (email_id, category_id) VALUES ('mayteh.kendall@yahoo.com', 1);
INSERT [dbo].Person_Category (email_id, category_id) VALUES ('bruce.onandonga12@gmail.com', 5);
INSERT [dbo].Person_Category (email_id, category_id) VALUES ('bruce.onandonga12@gmail.com', 3);
INSERT [dbo].Person_Category (email_id, category_id) VALUES ('tony.antavius@asu.edu', 5);
INSERT [dbo].Person_Category (email_id, category_id) VALUES ('tony.antavius@asu.edu', 2);
INSERT [dbo].Person_Category (email_id, category_id) VALUES ('danny.bradley34@gmail.com', 1);
INSERT [dbo].Person_Category (email_id, category_id) VALUES ('danny.bradley34@gmail.com', 2);
INSERT [dbo].Person_Category (email_id, category_id) VALUES ('reynaldo.suscipe@gmail.com', 2);
INSERT [dbo].Person_Category (email_id, category_id) VALUES ('reynaldo.suscipe@gmail.com', 6);
INSERT [dbo].Person_Category (email_id, category_id) VALUES ('ger.sullivan@asu.edu', 3);
INSERT [dbo].Person_Category (email_id, category_id) VALUES ('ger.sullivan@asu.edu', 5);
INSERT [dbo].Person_Category (email_id, category_id) VALUES ('nicole.reh123@gmail.com', 5);
INSERT [dbo].Person_Category (email_id, category_id) VALUES ('nicole.reh123@gmail.com', 6);
INSERT [dbo].Person_Category (email_id, category_id) VALUES ('katy.smith@yahoo.com', 2);
INSERT [dbo].Person_Category (email_id, category_id) VALUES ('katy.smith@yahoo.com', 4);

--insert new service offers for each user
INSERT [dbo].Service(email_id, category_id,title, description) VALUES ('john.doe@gmail.com', 3,'Create videos', 'I will create videos for you!!!');
INSERT [dbo].Service(email_id, category_id,title, description) VALUES ('michelle.davison@gmail.com', 4,'Create music ','Let me create music using my amazing music skills for you!');
INSERT [dbo].Service(email_id, category_id,title, description) VALUES ('mayteh.kendall@yahoo.com', 2,'Market a product', 'I have 1500 followers on Facebook. I can market your product to them!');
INSERT [dbo].Service(email_id, category_id,title, description) VALUES ('bruce.onandonga12@gmail.com', 1,'Design Flyers', 'I can design your next flyer!');
INSERT [dbo].Service(email_id, category_id,title, description) VALUES ('tony.antavius@asu.edu', 6,'Hand out flyers', 'I will hand out flyers for your business.');
INSERT [dbo].Service(email_id, category_id,title, description) VALUES ('danny.bradley34@gmail.com', 5,'Fix HTML,CSS', 'I will fix the HTML, CSS bugs on your website.');
INSERT [dbo].Service(email_id, category_id,title, description) VALUES ('reynaldo.suscipe@gmail.com', 4,'Write Classical Music', 'I can write classical music for you.');
INSERT [dbo].Service(email_id, category_id,title, description) VALUES ('ger.sullivan@asu.edu', 5,'Normalize DB', 'I will help you normalize your database design!');
INSERT [dbo].Service(email_id, category_id,title, description) VALUES ('nicole.reh123@gmail.com', 1,'Paint poster', 'I can paint a new poster for you');
INSERT [dbo].Service(email_id, category_id,title, description) VALUES ('katy.smith@yahoo.com', 6,'Help Advertise', 'I can help you advertise.');

--insert records into pending requests table
INSERT [dbo].Pending_Request(requester_id, provider_id, category_id,title, description, deadline) VALUES ('katy.smith@yahoo.com','bruce.onandonga12@gmail.com', 6,'Handing out flyers', 'I need someone to hand out flyers for my ice cream business.', '20160408');
INSERT [dbo].Pending_Request(requester_id, provider_id, category_id,title, description, deadline) VALUES ('reynaldo.suscipe@gmail.com','ger.sullivan@asu.edu', 5,'DB design normalize', 'I need my database design normalized.', '20160410');
INSERT [dbo].Pending_Request(requester_id, provider_id, category_id,title, description, deadline) VALUES ('mayteh.kendall@yahoo.com','nicole.reh123@gmail.com', 1,'New poster painted', 'I need a new poster painted.', '20160405');
INSERT [dbo].Pending_Request(requester_id, provider_id, category_id,title, description, deadline) VALUES ('tony.antavius@asu.edu','john.doe@gmail.com', 3,'Birthday Video needed', 'I need a video of my birthday made.', '20160402');
INSERT [dbo].Pending_Request(requester_id, provider_id, category_id,title, description, deadline) VALUES ('nicole.reh123@gmail.com','bruce.onandonga12@gmail.com', 1,'New flyer design needed', 'I need a new design for a flyer.', '20160414');
INSERT [dbo].Pending_Request(requester_id, provider_id, category_id,title, description, deadline) VALUES ('bruce.onandonga12@gmail.com','michelle.davison@gmail.com', 4,'Creating music', 'I need someone to create music for my movie.', '20160412');
INSERT [dbo].Pending_Request(requester_id, provider_id, category_id,title, description, deadline) VALUES ('michelle.davison@gmail.com','mayteh.kendall@yahoo.com', 2,'Marketing help', 'I need my amazing product marketed to businesses.', '20160415');
INSERT [dbo].Pending_Request(requester_id, provider_id, category_id,title, description, deadline) VALUES ('john.doe@gmail.com','danny.bradley34@gmail.com', 6,'HTML,CSS help', 'I need some HTML/CSS fixed for my website', '20160409');
INSERT [dbo].Pending_Request(requester_id, provider_id, category_id,title, description, deadline) VALUES ('michelle.davison@gmail.com','katy.smith@yahoo.com', 6,'Advertise business', 'I need someone to help me advertise my business', '20160408');
INSERT [dbo].Pending_Request(requester_id, provider_id, category_id,title, description, deadline) VALUES ('danny.bradley34@gmail.com','bruce.onandonga12@gmail.com', 1,'Design a flyer', 'I need someone to design a new flyer.', '20160424');


--Insert sample new requests
INSERT [dbo].New_Request (email_id, category_id,title, description, days_to_complete) VALUES ('john.doe@gmail.com', 1,'Logo design help', 'I want to get a logo designed for my company', 5);
INSERT [dbo].New_Request (email_id, category_id,title, description, days_to_complete) VALUES ('bruce.onandonga12@gmail.com', 3,'Professional photo', 'I want to professional photoshoot done', 3);
INSERT [dbo].New_Request (email_id, category_id, title,description, days_to_complete) VALUES ('danny.bradley34@gmail.com', 3,'Animated cartoon help', 'I want to make an animated cartoon character', 5);
INSERT [dbo].New_Request (email_id, category_id,title, description, days_to_complete) VALUES ('ger.sullivan@asu.edu', 4,'Disc record help', 'I want to get a disc recorded', 7);
INSERT [dbo].New_Request (email_id, category_id,title, description, days_to_complete) VALUES ('katy.smith@yahoo.com', 5,'Code verification', 'I want to get my code in java verified', 9);
INSERT [dbo].New_Request (email_id, category_id,title, description, days_to_complete) VALUES ('mayteh.kendall@yahoo.com', 6, 'Ideas for advertisement','I want ideas to launch a new advertising campaign for a product', 10);
INSERT [dbo].New_Request (email_id, category_id,title, description, days_to_complete) VALUES ('michelle.davison@gmail.com', 1, 'logo design needed','I want to get a logo designed for my company', 15);
INSERT [dbo].New_Request (email_id, category_id,title, description, days_to_complete) VALUES ('nicole.reh123@gmail.com', 2,'Professional video needed', 'I want to make a professional video for advertisement campaign', 4);
INSERT [dbo].New_Request (email_id, category_id,title, description, days_to_complete) VALUES ('reynaldo.suscipe@gmail.com', 5,'Python gui needed', 'I want a python programmer to code a gui', 6);
INSERT [dbo].New_Request (email_id, category_id,title, description, days_to_complete) VALUES ('tony.antavius@asu.edu', 6,'Advertisement banner needed', 'I want to get a advertisement banner created for my website', 8);

--Insert sample completed requests
INSERT [dbo].Completed_Request (requester_id, provider_id, category_id, description,title, accepted) VALUES ('john.doe@gmail.com', 'bruce.onandonga12@gmail.com', 1,'Logo design needed', 'I want to get a logo designed for my company', 1);
INSERT [dbo].Completed_Request (requester_id, provider_id, category_id, description,title, accepted) VALUES ('bruce.onandonga12@gmail.com', 'john.doe@gmail.com', 3,'Professional photo needs to be taken', 'I want a professional photoshoot done', 1);
INSERT [dbo].Completed_Request (requester_id, provider_id, category_id, description,title, accepted) VALUES ('danny.bradley34@gmail.com', 'bruce.onandonga12@gmail.com',3,'Animated cartoon character', 'I want to make an animated cartoon character', 0);
INSERT [dbo].Completed_Request (requester_id, provider_id, category_id, description,title, accepted) VALUES ('ger.sullivan@asu.edu', 'mayteh.kendall@yahoo.com', 4,'Disc record needed', 'I want to get a disc recorded', 0);
INSERT [dbo].Completed_Request (requester_id, provider_id, category_id, description,title, accepted) VALUES ('katy.smith@yahoo.com', 'bruce.onandonga12@gmail.com', 5,'Java code verification', 'I want to get my code in java verified', 0);
INSERT [dbo].Completed_Request (requester_id, provider_id, category_id, description,title, accepted) VALUES ('mayteh.kendall@yahoo.com', 'michelle.davison@gmail.com', 6,'Launch advert campaign', 'I want ideas to launch a new advertising campaign for a product', 1);
INSERT [dbo].Completed_Request (requester_id, provider_id, category_id, description,title, accepted) VALUES ('michelle.davison@gmail.com', 'john.doe@gmail.com',1, 'Company logo design','I want to get a logo designed for my company', 1);
INSERT [dbo].Completed_Request (requester_id, provider_id, category_id, description,title, accepted) VALUES ('nicole.reh123@gmail.com', 'tony.antavius@asu.edu', 2,'Professional video ', 'I want to make a professional video for advertisement campaign', 1);
INSERT [dbo].Completed_Request (requester_id, provider_id, category_id, description,title, accepted) VALUES ('reynaldo.suscipe@gmail.com','michelle.davison@gmail.com', 5,'Python program gui', 'I want a python programmer to code a gui', 1);
INSERT [dbo].Completed_Request (requester_id, provider_id, category_id, description,title, accepted) VALUES ('tony.antavius@asu.edu', 'michelle.davison@gmail.com', 6,'Advert banner needed', 'I want to get a advertisement banner created for my website', 0);

GO

--insertion into placeholder table
INSERT INTO [dbo].[Placeholder]([placeholder_name]) VALUES ('Inbox');
INSERT INTO [dbo].[Placeholder]([placeholder_name]) VALUES ('Draft');
INSERT INTO [dbo].[Placeholder]([placeholder_name]) VALUES ('Sent');
GO


/*---------------------------------------------------------------------------------------------------*/
--insertion into message table
CREATE PROCEDURE sp_retrieve_request_details
 @email_id varchar(max),
 @request_id uniqueidentifier OUTPUT,
 @title varchar(max) OUTPUT
AS 
	SELECT @request_id = request_id, @title = title from New_Request where email_id = @email_id

go

DECLARE @hold_request_id uniqueidentifier, @hold_title varchar(max)
EXEC sp_retrieve_request_details 'nicole.reh123@gmail.com', @request_id=@hold_request_id OUTPUT, @title = @hold_title OUTPUT
INSERT INTO [dbo].[Message]([author_id],[msg_subject],[body],[msg_date],[request_id])
VALUES ('mayteh.kendall@yahoo.com'
           ,'Advertising-Reg'
           ,'Hi, I will help you with ' + @hold_title
           ,'2016-04-05 17:43:04.780', @hold_request_id );

declare @message_id uniqueidentifier
set @message_id = (select message_id from Message where author_id = 'mayteh.kendall@yahoo.com')

declare @thread_id uniqueidentifier
set @thread_id = (select thread_id from Message where author_id = 'mayteh.kendall@yahoo.com')

insert into dbo.Person_Message values ('nicole.reh123@gmail.com', @message_id,1,@thread_id,0)

insert into dbo.Person_Message values ('mayteh.kendall@yahoo.com', @message_id,3,@thread_id,0)
		   
GO
DECLARE @hold_request_id uniqueidentifier, @hold_title varchar(max)
EXEC sp_retrieve_request_details 'nicole.reh123@gmail.com', @request_id=@hold_request_id OUTPUT, @title = @hold_title OUTPUT
INSERT INTO [dbo].[Message]([author_id],[msg_subject],[body],[msg_date],[request_id])
VALUES ('michelle.davison@gmail.com'
           ,'Logo Design-Reg'
           ,'Hi, I will help you with ' +@hold_title
           ,'2016-04-05 22:43:04.680',  @hold_request_id);

declare @message_id uniqueidentifier
set @message_id = (select message_id from Message where author_id = 'michelle.davison@gmail.com')

declare @thread_id uniqueidentifier
set @thread_id = (select thread_id from Message where author_id = 'michelle.davison@gmail.com')

insert into dbo.Person_Message values ('nicole.reh123@gmail.com', @message_id,1,@thread_id,0)

insert into dbo.Person_Message values ('michelle.davison@gmail.com', @message_id,3,@thread_id,0)

GO
DECLARE @hold_request_id uniqueidentifier, @hold_title varchar(max)
EXEC sp_retrieve_request_details 'danny.bradley34@gmail.com', @request_id=@hold_request_id OUTPUT, @title = @hold_title OUTPUT
INSERT INTO [dbo].[Message]([author_id],[msg_subject],[body],[msg_date],[request_id])
VALUES ('katy.smith@yahoo.com'
           ,'Programming-Reg'
           ,'Hi, I will help you with ' +@hold_title
           ,'2016-03-05 10:15:04.780', @hold_request_id);

declare @message_id uniqueidentifier
set @message_id = (select message_id from Message where author_id = 'katy.smith@yahoo.com')

declare @thread_id uniqueidentifier
set @thread_id = (select thread_id from Message where author_id = 'katy.smith@yahoo.com')

insert into dbo.Person_Message values ('danny.bradley34@gmail.com', @message_id,1,@thread_id,0)

insert into dbo.Person_Message values ('katy.smith@yahoo.com', @message_id,3,@thread_id,0)

GO
DECLARE @hold_request_id uniqueidentifier, @hold_title varchar(max)
EXEC sp_retrieve_request_details 'danny.bradley34@gmail.com', @request_id=@hold_request_id OUTPUT, @title = @hold_title OUTPUT
INSERT INTO [dbo].[Message]([author_id],[msg_subject],[body],[msg_date],[request_id])
VALUES ('reynaldo.suscipe@gmail.com'
           ,'Programming-Reg'
           ,'Hi, I will help you with ' +@hold_title
           ,'2016-02-17 12:35:04.780', @hold_request_id );

declare @message_id uniqueidentifier
set @message_id = (select message_id from Message where author_id = 'reynaldo.suscipe@gmail.com')

declare @thread_id uniqueidentifier
set @thread_id = (select thread_id from Message where author_id = 'reynaldo.suscipe@gmail.com')

insert into dbo.Person_Message values ('danny.bradley34@gmail.com', @message_id,1,@thread_id,0)

insert into dbo.Person_Message values ('reynaldo.suscipe@gmail.com', @message_id,3,@thread_id,0)

go
DECLARE @hold_request_id uniqueidentifier, @hold_title varchar(max)
EXEC sp_retrieve_request_details 'mayteh.kendall@yahoo.com', @request_id=@hold_request_id OUTPUT, @title = @hold_title OUTPUT
INSERT INTO [dbo].[Message]([author_id],[msg_subject],[body],[msg_date],[request_id])
VALUES ('tony.antavius@asu.edu'
           ,'Advertising-Reg'
           ,'Hi, I will help you with ' +@hold_title
           ,'2016-01-09 09:33:04.780', @hold_request_id );

declare @message_id uniqueidentifier
set @message_id = (select message_id from Message where author_id = 'tony.antavius@asu.edu')

declare @thread_id uniqueidentifier
set @thread_id = (select thread_id from Message where author_id = 'tony.antavius@asu.edu')

insert into dbo.Person_Message values ('mayteh.kendall@yahoo.com', @message_id,1,@thread_id,0)

insert into dbo.Person_Message values ('tony.antavius@asu.edu', @message_id,3,@thread_id,0)

go		   
INSERT INTO [dbo].[Message]([author_id],[msg_subject],[body],[msg_date],[request_id])
VALUES ('john.doe@gmail.com'
           ,'How are you doing?'
           ,'Hi, Whatsup? How is everything going with you?'
           ,'2016-04-06 15:11:38.733', null);

declare @message_id uniqueidentifier
set @message_id = (select message_id from Message where author_id = 'john.doe@gmail.com')

declare @thread_id uniqueidentifier
set @thread_id = (select thread_id from Message where author_id = 'john.doe@gmail.com')

insert into dbo.Person_Message values ('mayteh.kendall@yahoo.com', @message_id,1,@thread_id,0)

insert into dbo.Person_Message values ('john.doe@gmail.com', @message_id,3,@thread_id,0)

go
INSERT INTO [dbo].[Message]([author_id],[msg_subject],[body],[msg_date],[request_id])
VALUES ('danny.bradley34@gmail.com'
           ,'Hey'
           ,'Hi, Can you teach me HTML5?'
           ,'2016-01-26 10:10:38.733', null);

declare @message_id uniqueidentifier
set @message_id = (select message_id from Message where author_id = 'danny.bradley34@gmail.com')

declare @thread_id uniqueidentifier
set @thread_id = (select thread_id from Message where author_id = 'danny.bradley34@gmail.com')

insert into dbo.Person_Message values ('mayteh.kendall@yahoo.com', @message_id,1,@thread_id,0)

insert into dbo.Person_Message values ('tony.antavius@asu.edu', @message_id,3,@thread_id,0)

GO

CREATE PROCEDURE sp_compose_new_message_thread
--exec sp_compose_new_message_thread 'mayteh.kendall@yahoo.com','john.doe@gmail.com',null, 'Hi!!','Hey, How are you doing?'
 @author_id varchar(max),
 @receiver_id varchar (max),
 @request_id uniqueidentifier,
 @msg_subject varchar(max),
 @body varchar(max)
AS 
declare @message_id uniqueidentifier
set @message_id = NEWID()
declare @thread_id uniqueidentifier
set @thread_id = NEWID()
begin try
	begin tran
	INSERT INTO [dbo].[Message]([message_id],[author_id],[thread_id],[msg_subject],[body],[msg_date],[request_id])
		VALUES (@message_id,@author_id, @thread_id,@msg_subject,@body,getdate(), @request_id);

insert into dbo.Person_Message values (@receiver_id, @message_id,1,@thread_id,0)

insert into dbo.Person_Message values (@author_id, @message_id,3,@thread_id,0)
	commit tran
end try
begin catch
	print 'sp_compose_new_message_thread failed'
end catch
go
--insert messages for automated message table
INSERT INTO Automated_Message (body)
VAlUES ('You have successfully registered on WorkNet. Take the experience of outsourcing and freelancing together. Happy working!');--subject ('Welcome' +@firstname, @lastname)
INSERT INTO Automated_Message (body)
VAlUES ('You have a new service provider requesting to serve your request.');--subject('action required for request' + @title)
INSERT INTO Automated_Message (body)
VAlUES ('Your request has reached deadline. Kindly review the work and take action.'); --subject ('Request' +@title +'has reached deadline)
INSERT INTO Automated_Message (body)
VAlUES ('The requester liked your work. Credits are being transferred on your account.');--subject('Credits transferred for request' + @title)
INSERT INTO Automated_Message (body)
VALUES ('The requester did not like your work. You will receive credits once the legal department verifies the request');--subject('Credits on hold for request' + @title)
INSERT INTO Automated_Message (body)
VAlUES ('You donot have enough credits to post the request. Please purchase more credits to to be able to post a new request');--subject('Not enough credits for posting new request')
--SQL Scripts
--INSERT INTO SERVICE
GO
CREATE PROCEDURE sp_service
@email_service varchar(100),
@category int,
@title varchar(max),
@description varchar(max)
AS
	INSERT INTO Service ([dbo].email_id, [dbo].category_id, [dbo].title, [dbo].description)
	VAlUES (@email_service, @category, @title, @description)
GO

--sample execute script to insert into service
--EXECUTE sp_service 'bruce.onandonga12@gmail.com', 1,'I will photoshop any image', 'Hi, you will receive 1024*1024 / 512*512(or desired size) png with transparent background'
--GO

--delete from service
CREATE PROCEDURE sp_delete_service
@service_id uniqueidentifier
AS
DELETE FROM Service WHERE service_id = @service_id
GO

--sample execute script to delete from service
--EXECUTE sp_delete_service '50A5A39E-90F1-494A-8D0D-59A373293225'
--GO




--Stored proc for inserting data into Person table
create proc sp_insert_person
@email_id varchar(100), @password varchar(100), @firstname varchar(100), @lastname varchar(100) 
as 
begin
insert into Person(email_id, password, firstname, lastname)
values(@email_id, HASHBYTES('SHA2_512',@password), @firstname, @lastname);
end
GO
--exec sp_insert_person 'Admin@WorkNet.com','asdfgh','Admin','WorkNet';



--Stored proc for inserting data into New_request table
create proc sp_insert_new_request
@email_id varchar(100), @category_id int,@title varchar(max),  @description varchar(max), @days_to_complete int
as
begin
if((select (totalcredit-reservedcredit) from person where email_id=@email_id) >5)
begin 
insert into New_Request(email_id, category_id, title, description, days_to_complete)
values(@email_id, @category_id,@title, @description, @days_to_complete);
end
else
begin
declare @body varchar(max);
select @body=body from dbo.Automated_Message where auto_message_id=6;
exec sp_compose_new_message_thread 'Admin@WorkNet.com',@email_id,null,'Creation of new request failed', @body;
end
end
GO
--exec sp_insert_new_request 'danny.bradley34@gmail.com', 1, 'Help', 'I want something', 5;


--Stored proc for moving data from new-request to pending_request
create proc sp_insert_pending_request @request_id uniqueidentifier, @provider_id varchar(100)
as

begin
begin tran
declare  @requester_id varchar(100),@category_id int,@description varchar(max) ,@title varchar(max),@days_to_complete int;
select @requester_id=email_id, @category_id=category_id, @description=description, @title=title,@days_to_complete=days_to_complete
from New_Request
where request_id=@request_id;

insert into Pending_Request(requester_id, provider_id, category_id, title, description, deadline)
values(@requester_id,@provider_id,@category_id,@title, @description, dateadd(day,@days_to_complete,getdate()))

delete from New_Request
where request_id=@request_id
commit tran
end
GO

--exec sp_insert_pending_request '79371517-FD0B-4D75-A2BD-24D6F35D7192','danny.bradley34@gmail.com'


--insert into completed request table

CREATE PROCEDURE sp_completed_request
--sample execute script to move the request from pending_request to completed_request
--EXECUTE sp_completed_request '52001416-AD96-496B-AB7C-00898A1A0541', 1
@pending_request_id uniqueidentifier,
@accepted_status bit
AS
BEGIN
	begin tran
	DECLARE @requester_id varchar(100), @provider_id varchar(100), @category_id int, @title varchar(max), @description varchar(max)
	
	SELECT @requester_id = requester_id, @provider_id = provider_id, @category_id=category_id, @title = title, @description = description
	FROM Pending_Request WHERE pending_request_id = @pending_request_id;
	
	INSERT INTO Completed_Request (requester_id, provider_id, category_id, description, accepted, title)
	VALUES (@requester_id, @provider_id, @category_id, @description, @accepted_status, @title);

	DELETE FROM Pending_Request
	WHERE pending_request_id= @pending_request_id;
	commit tran
END
go
--Procedure for retrieving n records from new request table given email_id
create proc sp_retrieve_new_requests
--exec sp_retrieve_new_requests 'mayteh.kendall@yahoo.com', 3
@email_id varchar(max),
@num_records int
as
	begin
		select Top (@num_records) title, description, days_to_complete from New_Request
		where email_id = @email_id
		order by date
	end
go
create proc sp_retrieve_pending_requests
--exec sp_retrieve_pending_requests 'danny.bradley34@gmail.com', 3
@email_id varchar(max),
@num_records int
as
	begin
		select Top (@num_records) provider_id, title, description, deadline from Pending_Request
		where requester_id = @email_id
		order by deadline
	end
go
create proc sp_retrieve_pending_requests_provider
--exec sp_retrieve_pending_requests_provider 'bruce.onandonga12@gmail.com', 3
@email_id varchar(max),
@num_records int
as
	begin
		select Top (@num_records) requester_id, title, description, deadline from Pending_Request
		where provider_id = @email_id
		order by deadline
	end
go
create proc sp_retrieve_unread_messages
--declare @hold_number_unread_messages int
--exec sp_retrieve_unread_messages 'danny.bradley34@gmail.com','Inbox',@number_unread_messages = @hold_number_unread_messages output
--print @hold_number_unread_messages
@email_id varchar(max),
@placeholder_name varchar(max),
@number_unread_messages int output

as
	begin
		declare @placeholder_id int
		set @placeholder_id = (
			select placeholder_id 
			from placeholder 
			where placeholder_name = @placeholder_name
			)

		select @number_unread_messages = count(*)
		from Person_Message
		where email_id = @email_id
		and placeholder_id = @placeholder_id
		and is_read = 0;
	end
	go

--Stored proc for retrieving messages for a user based on his/her placeholder selection
create proc sp_retrieveplaceholdermessages @email_id varchar(100), 
@placeholder_id int
as 
begin

declare @thread_id uniqueidentifier;

declare cr_getmaxdatefromthread cursor
for
select distinct thread_id from Person_Message
where email_id=@email_id and placeholder_id=@placeholder_id;

open cr_getmaxdatefromthread;
fetch next from cr_getmaxdatefromthread into @thread_id;

while @@FETCH_STATUS=0
begin 

select top 1 * from Message
where thread_id=@thread_id 
order by msg_date;

fetch next from cr_getmaxdatefromthread into @thread_id;
end

close cr_getmaxdatefromthread;
deallocate cr_getmaxdatefromthread;
end
go

exec sp_retrieveplaceholdermessages 'mayteh.kendall@yahoo.com', 1;

select * from dbo.Message;




--Stored proc for showing top requests in the categories the user is interested in
create proc sp_toprequests @email_id varchar(100)
as
begin
select *
from New_Request
where category_id in (
select category_id
from Person_Category
where email_id=@email_id);
end
go

--exec sp_toprequests 'bruce.onandonga12@gmail.com';

--Stored proc for showing top services in the categories the user is interested in
create proc sp_topservices @email_id varchar(100)
as
begin
select *
from dbo.Service
where category_id in (
select category_id
from Person_Category
where email_id=@email_id);
end
go


--exec sp_topservices 'bruce.onandonga12@gmail.com';

--User defined fucntion to authenticate user login
create function udf_authenticate
(@email_id varchar(100),
@password varchar(100)
)
returns int
as
begin
return(select case when exists(select *
from dbo.person
where email_id=@email_id and password=HASHBYTES('SHA2_512',@password) )
then 1
else 0 
end)
end
go

--select dbo.udf_authenticate('bruce.onandonga12@gmail.com', 'sadkjg');

--Stored proc for updating User Information
create proc sp_updateUserProfile
@email_id varchar(100), @password varchar(100), @firstname varchar(100), @lastname varchar(100)
as
begin 
update dbo.Person
set password=HASHBYTES('SHA2_512',@password), firstname=@firstname, lastname=@lastname
where email_id=@email_id;
end
go

--exec sp_updateUserProfile 'tony.antavius@asu.edu', 'ABCD345', 'Antavius', 'Tony';


