USE master;
IF DB_ID(N'Hospitals') IS NOT NULL
	DROP DATABASE Hospitals; -- ������� ���� ������ 
GO
-- ��������� �������� � ����������� � �������� "�������������" (advanced) --
sp_configure 'show advanced', 1;
RECONFIGURE WITH OVERRIDE;
GO
-- ���������� �� �������� ���������� ��� ������ -- 
sp_configure 'contained database authentication', 1;
RECONFIGURE WITH OVERRIDE;
GO
-- ���������� �� - ��, ������� ��� ���� � ���� ������, �� ���� ��� ������ ����� ���������� --
--##################################################################################################### --
-- �������� ���� ������ -- 
CREATE DATABASE Hospitals     /* �������� ���� */
 CONTAINMENT = PARTIAL        /* �������� ��������� ��������� ���� 
								 NONE - ������������ ��
								 PARTIAL - �������� ����������*/
ON
PRIMARY ( NAME = Hospital_dat,     /* ON - �������� ����� �������� ������ ���� */
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\hospitaldat.mdf', /* �� ������������� �� ����� */
	SIZE = 600MB,
	MAXSIZE = 2048MB,
	FILEGROWTH = 10MB ),

FILEGROUP Patients_dat
( NAME = Patients_dat,
	FILENAME = 'A:\DB_Hospitals\patientsdat.ndf', -- ��������� ����
	SIZE = 500MB,
	MAXSIZE = 2048MB,
	FILEGROWTH = 20MB )

LOG ON							/* ���������� ����������� ������ ��� ����� */
( NAME = Hospital_log,
	FILENAME = 'B:\DB_Hospitals\hospitallog.ldf', 
	SIZE = 100MB,
	MAXSIZE = 2048MB,
	FILEGROWTH = 10MB )

/* /\/\/\  ���� ����� ��������� ���� �� ������ ������ �� ����� �� ����� ��������
 ( ��� �����, ��� ��, ��� �� ) ������� ��� ������� ��������, ������ ����� ON ����
  ������ ������ ���� ������ ��������� ��� ����� ����� ��� �������� ����� PRIMARY */

COLLATE Cyrillic_General_100_CI_AI /* ����� ��������� ���������� ��� ���� ��-��������� */
	WITH 
		NESTED_TRIGGERS = ON,  /* ���������� ��������� �� �������������� ��������� AFTER */
		TWO_DIGIT_YEAR_CUTOFF = 2050;

GO