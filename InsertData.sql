USE [DBFiverr]
GO

--ALtering structure of message table, adding a column request_id
alter table dbo.message
add request_id uniqueidentifier not null foreign key references dbo.New_Request(request_id);
GO

--Altering column definition of request_id
alter table dbo.message
alter column request_id uniqueidentifier null;
GO

--insertion into message table
INSERT INTO [dbo].[Message]([author_id],[msg_subject],[body],[msg_date],[request_id])
VALUES ('mayteh.kendall@yahoo.com'
           ,'Advertising-Reg'
           ,'Hi, Can you help me with ideas for advertising a new product that our company is planning to launch?'
           ,'2016-04-05 17:43:04.780', '217F651D-E3E5-4510-863A-3DD5AEED4A0C');

INSERT INTO [dbo].[Message]([author_id],[msg_subject],[body],[msg_date],[request_id])
VALUES ('michelle.davison@gmail.com'
           ,'Logo Design-Reg'
           ,'Hi, Can you help me the logo of our company ?'
           ,'2016-04-05 22:43:04.680', 'C3C3A57C-DEAE-4920-9D8C-798F0D502438');

INSERT INTO [dbo].[Message]([author_id],[msg_subject],[body],[msg_date],[request_id])
VALUES ('katy.smith@yahoo.com'
           ,'Programming-Reg'
           ,'Hi, Can you help me verify my Java code?'
           ,'2016-03-05 10:15:04.780', '5732BE5E-8B99-4F60-AAD2-348FE5A5F60D');

INSERT INTO [dbo].[Message]([author_id],[msg_subject],[body],[msg_date],[request_id])
VALUES ('reynaldo.suscipe@gmail.com'
           ,'Programming-Reg'
           ,'Hi, Can you help me design a GUI for my website?'
           ,'2016-02-17 12:35:04.780', 'E12F69E5-4809-41BB-A2FA-6BF465C052FD');


INSERT INTO [dbo].[Message]([author_id],[msg_subject],[body],[msg_date],[request_id])
VALUES ('tony.antavius@asu.edu'
           ,'Advertising-Reg'
           ,'Hi, I can hand out flyers for your new company and help make it popular if you wish'
           ,'2016-01-09 09:33:04.780', '217F651D-E3E5-4510-863A-3DD5AEED4A0C');


INSERT INTO [dbo].[Message]([author_id],[msg_subject],[body],[msg_date],[request_id])
VALUES ('john.doe@gmail.com'
           ,'How are you doing?'
           ,'Hi, Whatsup? How is everything going with you?'
           ,'2016-04-06 15:11:38.733', null);

INSERT INTO [dbo].[Message]([author_id],[msg_subject],[body],[msg_date],[request_id])
VALUES ('danny.bradley34@gmail.com'
           ,'Hey'
           ,'Hi, Can you teach me HTML5?'
           ,'2016-01-26 10:10:38.733', null);

GO

select * from dbo.Message;
GO

--insertion into placeholder table
INSERT INTO [dbo].[Placeholder]([placeholder_name]) VALUES ('Inbox');
INSERT INTO [dbo].[Placeholder]([placeholder_name]) VALUES ('Draft');
INSERT INTO [dbo].[Placeholder]([placeholder_name]) VALUES ('Sent');
GO

select * from dbo.Placeholder;
GO

--insertion into person_message table
INSERT INTO [dbo].[Person_Message]([email_id],[message_id],[placeholder_id],[thread_id],[is_read])
     VALUES('katy.smith@yahoo.com','60B1BE9E-629D-4F1B-8CC5-0129C306D0C5',3,'A9ABA512-211B-47B7-AA9B-E683F295FA8F',null);
INSERT INTO [dbo].[Person_Message]([email_id],[message_id],[placeholder_id],[thread_id],[is_read])
     VALUES('danny.bradley34@gmail.com','60B1BE9E-629D-4F1B-8CC5-0129C306D0C5',1,'A9ABA512-211B-47B7-AA9B-E683F295FA8F',0);
INSERT INTO [dbo].[Person_Message]([email_id],[message_id],[placeholder_id],[thread_id],[is_read])
     VALUES('mayteh.kendall@yahoo.com','42D3A101-2EFF-4999-A3FF-055EE31C9BAA',3,'6BDCDD4B-7A15-480F-A665-9A5F56E899C0',null);
INSERT INTO [dbo].[Person_Message]([email_id],[message_id],[placeholder_id],[thread_id],[is_read])
     VALUES('katy.smith@yahoo.com','42D3A101-2EFF-4999-A3FF-055EE31C9BAA',1,'6BDCDD4B-7A15-480F-A665-9A5F56E899C0',0);
INSERT INTO [dbo].[Person_Message]([email_id],[message_id],[placeholder_id],[thread_id],[is_read])
     VALUES('john.doe@gmail.com','455878E9-EFFA-4814-A22D-18CDBE847F3B',3,'7F33C543-AD7B-4531-8E24-B39A9300149F',null);
INSERT INTO [dbo].[Person_Message]([email_id],[message_id],[placeholder_id],[thread_id],[is_read])
     VALUES('katy.smith@yahoo.com','455878E9-EFFA-4814-A22D-18CDBE847F3B',1,'7F33C543-AD7B-4531-8E24-B39A9300149F',0);
INSERT INTO [dbo].[Person_Message]([email_id],[message_id],[placeholder_id],[thread_id],[is_read])
     VALUES('reynaldo.suscipe@gmail.com','20EBB25C-5C2D-46A4-9645-61083AA56018',3,'F0047959-5DD3-45C8-8E33-85C394D5843D',null);
INSERT INTO [dbo].[Person_Message]([email_id],[message_id],[placeholder_id],[thread_id],[is_read])
     VALUES('danny.bradley34@gmail.com','20EBB25C-5C2D-46A4-9645-61083AA56018',1,'F0047959-5DD3-45C8-8E33-85C394D5843D',0);
INSERT INTO [dbo].[Person_Message]([email_id],[message_id],[placeholder_id],[thread_id],[is_read])
     VALUES('danny.bradley34@gmail.com','06115562-C4B3-42CF-93C2-AF25EA087861',3,'6E91D2E9-87C2-4116-8B19-6B88DCB1B3F4',null);
INSERT INTO [dbo].[Person_Message]([email_id],[message_id],[placeholder_id],[thread_id],[is_read])
     VALUES('ger.sullivan@asu.edu','06115562-C4B3-42CF-93C2-AF25EA087861',1,'6E91D2E9-87C2-4116-8B19-6B88DCB1B3F4',0);
INSERT INTO [dbo].[Person_Message]([email_id],[message_id],[placeholder_id],[thread_id],[is_read])
     VALUES('michelle.davison@gmail.com','EA29CB8E-1013-4D72-BDAB-BF79687A2EF9',3,'99EDF1B5-1D4D-4136-AA33-90FD0696DDB9',null);
INSERT INTO [dbo].[Person_Message]([email_id],[message_id],[placeholder_id],[thread_id],[is_read])
     VALUES('nicole.reh123@gmail.com','EA29CB8E-1013-4D72-BDAB-BF79687A2EF9',1,'99EDF1B5-1D4D-4136-AA33-90FD0696DDB9',0);
INSERT INTO [dbo].[Person_Message]([email_id],[message_id],[placeholder_id],[thread_id],[is_read])
     VALUES('tony.antavius@asu.edu','2A9A76A0-C5F7-41B3-B938-F2E63FB0B452',3,'B37571A0-878E-44E9-8AD8-B9AE2E30E463',null);
INSERT INTO [dbo].[Person_Message]([email_id],[message_id],[placeholder_id],[thread_id],[is_read])
     VALUES('mayteh.kendall@yahoo.com','2A9A76A0-C5F7-41B3-B938-F2E63FB0B452',1,'B37571A0-878E-44E9-8AD8-B9AE2E30E463',0);
GO

select * from dbo.[Person_Message];
GO








 









