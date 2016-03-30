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
CREATE TABLE [dbo].Person(
	email_id varchar(100),
	password binary(64) NOT NULL,
	firstname varchar(100) NOT NULL,
	lastname varchar(100) NOT NULL,
	credit money DEFAULT 0,
	CONSTRAINT ck_checkmoneypositive CHECK (credit > 0),
	CONSTRAINT pk_email PRIMARY KEY (email_id)
	)