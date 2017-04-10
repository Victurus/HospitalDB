DROP DATABASE Hospitals -- ������� ���� ������ 
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
( NAME = Hospital_dat,     /* ON - �������� ����� �������� ������ ���� */
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\hospitaldat.mdf', /* �� ������������� �� ����� */
	SIZE = 600MB,
	MAXSIZE = 2048MB,
	FILEGROWTH = 10MB ),

FILEGROUP HospGroup 
( NAME = HospGroup_dat,
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\hospGROUPdat.mdf',
	SIZE = 500MB,
	MAXSIZE = 2048MB,
	FILEGROWTH = 20MB )

LOG ON							/* ���������� ����������� ������ ��� ����� */
( NAME = Hospital_log,
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\hospitallog.ldf', 
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

GO -- ��� � ����� ��� ���������� ���������� ��� �����������