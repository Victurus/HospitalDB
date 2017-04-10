USE Hospitals
GO

/* 
	Вывод сведений о пространстве журнала для всех баз данных:
	В следующем примере выводятся сведения LOGSPACE для всех баз данных, содержащихся в экземпляре SQL Server.
	Transact-SQL 
*/

DBCC SQLPERF(LOGSPACE);  
GO  

SELECT * FROM dbo.hospital

-- пример с интернета про локальный, скалярные переменные
DECLARE @StartTime DateTime = SYSDATETIME()

WAITFOR DELAY '00:00:01'
DECLARE @Seconds int = DATEDIFF(Second, @StartTime,SYSDATETIME())
SELECT GETDATE(),'Обновление=Успех сек='+CAST(@Seconds AS VARCHAR(8)) -- пишем результат