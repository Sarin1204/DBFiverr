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
	auto_message_id uniqueidentifier 
		DEFAULT newid(),
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
