USE Hospitals
GO

/* 
	����� �������� � ������������ ������� ��� ���� ��� ������:
	� ��������� ������� ��������� �������� LOGSPACE ��� ���� ��� ������, ������������ � ���������� SQL Server.
	Transact-SQL 
*/

DBCC SQLPERF(LOGSPACE);  
GO  

SELECT * FROM dbo.hospital

-- ������ � ��������� ��� ���������, ��������� ����������
DECLARE @StartTime DateTime = SYSDATETIME()

WAITFOR DELAY '00:00:01'
DECLARE @Seconds int = DATEDIFF(Second, @StartTime,SYSDATETIME())
SELECT GETDATE(),'����������=����� ���='+CAST(@Seconds AS VARCHAR(8)) -- ����� ���������