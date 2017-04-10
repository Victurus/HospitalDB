USE Hospitals;
GO

-- �������� ������������� --
IF OBJECT_ID('doctor_finder', 'V') IS NOT NULL
DROP VIEW doctor_finder;
GO

IF OBJECT_ID('patients_info', 'V') IS NOT NULL
DROP VIEW patients_info;
GO

IF OBJECT_ID('VIEW_hospital', 'V') IS NOT NULL
DROP VIEW VIEW_hospital
GO
-- ����� �������� ������������� --

-- ���������� ���� �������� � ������ � ���� ���������(����� ��)
CREATE VIEW doctor_finder
--WITH ENCRYPTION
AS 
	SELECT 
		CONCAT(d.Second_name,' ', d.First_name, ' ', d.Patronimyc_name) AS [���],
		d.Mobile_number AS [����� ����������],
		d.Addres AS [�����]
	FROM dbo.doctor d 
	LEFT JOIN dbo.hospital_profession hp ON d.Hospital_professionID = hp.ID
GO

-- ����� ������ �� �������������
SELECT * FROM doctor_finder
GO
-- ��������� ������� �������� �������������(���������)
-- ���� ������� ����� WITH ENCRYPTION, �� ����� ��������
--> ����� ��� ������� "doctor_finder" ����������. <--
EXEC SP_HELPTEXT 'doctor_finder';
GO

CREATE VIEW patients_info
WITH ENCRYPTION, SCHEMABINDING
AS
	SELECT 
		CONCAT(ppi.Second_name,' ',ppi.First_name, ' ',ppi.Patronimyc_name) AS [��� ��������],
		p.Admission_diagnosis AS [������� ��� �����������],
		p.Clinical_diagnosis AS [����������� �������],
		r.Name AS [������ �],
		CONCAT(d.Second_name,' ', d.First_name, ' ', d.Patronimyc_name) AS [������� ����],
		d.Mobile_number AS [��������� �������],
		d.Experience AS [���� �������]
	FROM dbo.patient p
	JOIN dbo.patient_personal_info ppi ON p.Patient_personal_infoID = ppi.ID
	JOIN dbo.doctor d ON p.DoctorID = d.ID
	JOIN dbo.room r ON p.RoomID = r.ID
WITH CHECK OPTION
GO

--DROP INDEX IDX_pi ON dbo.patients_info
--GO

CREATE UNIQUE CLUSTERED INDEX IDX_pi
ON dbo.patients_info ([��� ��������], [������ �])
GO

SELECT * FROM patients_info
GO

CREATE VIEW VIEW_hospital
WITH ENCRYPTION, SCHEMABINDING
AS
	SELECT 
		h.Name AS [�������� ��������],
		h.Number AS [�����],
		h.Date_of_foundation AS [���� ���������],
		h.RegionID AS [ID �������]
	FROM dbo.hospital h
WITH CHECK OPTION
GO

CREATE UNIQUE CLUSTERED INDEX IDX_hosp
ON VIEW_hospital([�������� ��������], [�����])
GO

SELECT * FROM VIEW_hospital

SET NUMERIC_ROUNDABORT OFF;
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER ON;
GO

INSERT INTO VIEW_hospital ([�������� ��������], [�����], [���� ���������], [ID �������]) VALUES
	(N'����� �������', N'1742', N'10-03-2000', N'5')

SELECT * FROM hospital h
WHERE h.RegionID = N'5'