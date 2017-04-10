USE Hospitals;
GO

-- удаление представлений --
IF OBJECT_ID('doctor_finder', 'V') IS NOT NULL
DROP VIEW doctor_finder;
GO

IF OBJECT_ID('patients_info', 'V') IS NOT NULL
DROP VIEW patients_info;
GO

IF OBJECT_ID('VIEW_hospital', 'V') IS NOT NULL
DROP VIEW VIEW_hospital
GO
-- конец удаления представлений --

-- посмотреть всех докторов и способ с ними связаться(найти их)
CREATE VIEW doctor_finder
--WITH ENCRYPTION
AS 
	SELECT 
		CONCAT(d.Second_name,' ', d.First_name, ' ', d.Patronimyc_name) AS [ФИО],
		d.Mobile_number AS [Номер мобильного],
		d.Addres AS [Адрес]
	FROM dbo.doctor d 
	LEFT JOIN dbo.hospital_profession hp ON d.Hospital_professionID = hp.ID
GO

-- вывод данных из представления
SELECT * FROM doctor_finder
GO
-- выводится команда создания представления(построчно)
-- если указана опция WITH ENCRYPTION, то будет выведено
--> Текст для объекта "doctor_finder" зашифрован. <--
EXEC SP_HELPTEXT 'doctor_finder';
GO

CREATE VIEW patients_info
WITH ENCRYPTION, SCHEMABINDING
AS
	SELECT 
		CONCAT(ppi.Second_name,' ',ppi.First_name, ' ',ppi.Patronimyc_name) AS [ФИО пациента],
		p.Admission_diagnosis AS [Диагноз при поступлении],
		p.Clinical_diagnosis AS [Клинический диагноз],
		r.Name AS [Палата №],
		CONCAT(d.Second_name,' ', d.First_name, ' ', d.Patronimyc_name) AS [Лечащий врач],
		d.Mobile_number AS [Мобильный телефон],
		d.Experience AS [Стаж доктора]
	FROM dbo.patient p
	JOIN dbo.patient_personal_info ppi ON p.Patient_personal_infoID = ppi.ID
	JOIN dbo.doctor d ON p.DoctorID = d.ID
	JOIN dbo.room r ON p.RoomID = r.ID
WITH CHECK OPTION
GO

--DROP INDEX IDX_pi ON dbo.patients_info
--GO

CREATE UNIQUE CLUSTERED INDEX IDX_pi
ON dbo.patients_info ([ФИО пациента], [Палата №])
GO

SELECT * FROM patients_info
GO

CREATE VIEW VIEW_hospital
WITH ENCRYPTION, SCHEMABINDING
AS
	SELECT 
		h.Name AS [Название больницы],
		h.Number AS [Номер],
		h.Date_of_foundation AS [Дата основания],
		h.RegionID AS [ID региона]
	FROM dbo.hospital h
WITH CHECK OPTION
GO

CREATE UNIQUE CLUSTERED INDEX IDX_hosp
ON VIEW_hospital([Название больницы], [Номер])
GO

SELECT * FROM VIEW_hospital

SET NUMERIC_ROUNDABORT OFF;
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER ON;
GO

INSERT INTO VIEW_hospital ([Название больницы], [Номер], [Дата основания], [ID региона]) VALUES
	(N'Медус пунктус', N'1742', N'10-03-2000', N'5')

SELECT * FROM hospital h
WHERE h.RegionID = N'5'