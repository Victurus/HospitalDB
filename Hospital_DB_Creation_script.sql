USE master;
IF DB_ID(N'Hospitals') IS NOT NULL
	DROP DATABASE Hospitals; -- удалить базу данных 
GO
-- разрешить работать с настройками с закладки "дополнительно" (advanced) --
sp_configure 'show advanced', 1;
RECONFIGURE WITH OVERRIDE;
GO
-- разрешение на создание автономных баз данных -- 
sp_configure 'contained database authentication', 1;
RECONFIGURE WITH OVERRIDE;
GO
-- автономная бд - бд, которая всю инфу в себе хранит, то есть где хочешь потом развернётся --
--##################################################################################################### --
-- создание базы данных -- 
CREATE DATABASE Hospitals     /* создание базы */
 CONTAINMENT = PARTIAL        /* указание состояния включения базы 
								 NONE - неавтономная БД
								 PARTIAL - частично автономная*/
ON
PRIMARY ( NAME = Hospital_dat,     /* ON - означает явное указание файлов базы */
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\hospitaldat.mdf', /* их распределение на диске */
	SIZE = 600MB,
	MAXSIZE = 2048MB,
	FILEGROWTH = 10MB ),

FILEGROUP Patients_dat
( NAME = Patients_dat,
	FILENAME = 'A:\DB_Hospitals\patientsdat.ndf', -- Вторичный файл
	SIZE = 500MB,
	MAXSIZE = 2048MB,
	FILEGROWTH = 20MB )

LOG ON							/* аналогично предыдущему только для логов */
( NAME = Hospital_log,
	FILENAME = 'B:\DB_Hospitals\hospitallog.ldf', 
	SIZE = 100MB,
	MAXSIZE = 2048MB,
	FILEGROWTH = 10MB )

/* /\/\/\  если нужно раскидать базу по разным файлам на диске то такие формочки
 ( имя файла, где он, что он ) пишутся для каждого отдельно, только после ON один
  файлов должен быть назван первичным для этого перед ним ставится слово PRIMARY */

COLLATE Cyrillic_General_100_CI_AI /* Задаёт параметры сортировки для базы по-умолчанию */
	WITH 
		NESTED_TRIGGERS = ON,  /* определяет допустимо ли каскадирование триггеров AFTER */
		TWO_DIGIT_YEAR_CUTOFF = 2050;

GO