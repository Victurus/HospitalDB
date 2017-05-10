USE Hospitals
GO

/* Просто примечание:
   - Ссылаться можно только на UNIQUE или PRIMARY KEY;
   - CONSTRAINT это ограничение
*/

-- Строки удаления таблиц нужны для их пересоздания --

IF OBJECT_ID('dbo.patient_history', 'U') IS NOT NULL
	DROP TABLE dbo.patient_history;
GO

IF OBJECT_ID('dbo.patient', 'U') IS NOT NULL
	DROP TABLE dbo.patient;
GO

IF OBJECT_ID('dbo.operation_patient', 'U') IS NOT NULL
	DROP TABLE dbo.operation_patient;
GO

IF OBJECT_ID('dbo.operation', 'U') IS NOT NULL
	DROP TABLE dbo.operation;
GO

IF OBJECT_ID('dbo.patient_insurance_number', 'U') IS NOT NULL
	DROP TABLE dbo.patient_insurance_number
GO

IF OBJECT_ID('dbo.patient_personal_info', 'U') IS NOT NULL
	DROP TABLE dbo.patient_personal_info;
GO

IF OBJECT_ID('dbo.doctor_insurance_number', 'U') IS NOT NULL
	DROP TABLE dbo.doctor_insurance_number
GO

IF OBJECT_ID('dbo.doctor', 'U') IS NOT NULL
	DROP TABLE dbo.doctor;
GO

IF OBJECT_ID('dbo.insurance_org', 'U') IS NOT NULL
	DROP TABLE dbo.insurance_org;
GO

IF OBJECT_ID('dbo.hospital_profession', 'U') IS NOT NULL
	DROP TABLE dbo.hospital_profession;
GO

IF OBJECT_ID('dbo.room', 'U') IS NOT NULL
	DROP TABLE dbo.room;
GO

IF OBJECT_ID('dbo.specialize', 'U') IS NOT NULL
	DROP TABLE dbo.specialize;
GO

IF OBJECT_ID('dbo.otdel', 'U') IS NOT NULL
	DROP TABLE dbo.otdel;
GO

IF OBJECT_ID('dbo.hospital', 'U') IS NOT NULL
	DROP TABLE dbo.hospital;
GO

IF OBJECT_ID('dbo.region', 'U') IS NOT NULL
	DROP TABLE dbo.region;
GO

-- конец удаления тоблиц --

-- создание таблиц(отношений) --

CREATE TABLE dbo.region
(	ID INT IDENTITY(1, 1) NOT NULL,
	Name NVARCHAR(200) NOT NULL,
	CONSTRAINT PK_region PRIMARY KEY(ID),
	CONSTRAINT UQ_name_region UNIQUE(Name)
)
GO

CREATE TRIGGER dbo.region_name ON dbo.region
AFTER INSERT, UPDATE
AS
BEGIN
	UPDATE dbo.region
	SET dbo.region.Name = UPPER(SUBSTRING(r.Name, 1, 1)) + LOWER(SUBSTRING(r.Name, 2, LEN(r.Name) - 1))
	FROM dbo.region r, inserted i
	WHERE r.ID=i.ID
END
GO

CREATE TABLE dbo.hospital
(   ID INT IDENTITY(1, 1) NOT NULL,
	Name NVARCHAR(350) NOT NULL,
	RegionID INT NOT NULL,
	Date_of_foundation DATE,
	Number INT NOT NULL,
	CONSTRAINT PK_hospital PRIMARY KEY(ID),
	CONSTRAINT FK_region_hospital FOREIGN KEY (RegionID) REFERENCES dbo.region(ID)
)
GO

CREATE TRIGGER dbo.hospital_name ON dbo.hospital
AFTER INSERT, UPDATE
AS
BEGIN
	UPDATE dbo.hospital
	SET dbo.hospital.Name = UPPER(SUBSTRING(h.Name, 1, 1)) + LOWER(SUBSTRING(h.Name, 2, LEN(h.Name) - 1))
	FROM dbo.hospital h, inserted i
	WHERE i.ID = h.ID
END
GO

CREATE TRIGGER dbo.region_del ON dbo.region
INSTEAD OF DELETE
AS 
BEGIN
	DECLARE @I INT;
	SELECT @I = d.ID FROM deleted d
	IF EXISTS(SELECT * FROM dbo.hospital h WHERE h.ID=@I)
	BEGIN
		PRINT 'Ошибка: Нельзя удалить регион в котором есть больница.'
		ROLLBACK TRANSACTION
	END
	ELSE
	BEGIN
		DELETE FROM dbo.region WHERE dbo.region.ID = @I
	END
END
GO

CREATE TABLE dbo.otdel
(	ID INT IDENTITY(1,1) NOT NULL,
	HospitalID INT NOT NULL,
	Name NVARCHAR(150) NOT NULL,
	CONSTRAINT PK_otdel PRIMARY KEY(ID),
	CONSTRAINT FK_hospital FOREIGN KEY(HospitalID) REFERENCES dbo.hospital(ID)
)
GO

CREATE TRIGGER dbo.otdel_name ON dbo.otdel
AFTER INSERT, UPDATE
AS 
BEGIN
	UPDATE dbo.otdel
	SET dbo.otdel.Name = UPPER(SUBSTRING(o.Name, 1, 1)) + LOWER(SUBSTRING(o.Name, 2, LEN(o.Name) - 1))
	FROM dbo.otdel o, inserted i
	WHERE i.ID = o.ID
END
GO

CREATE TABLE dbo.specialize
(	ID INT IDENTITY(1,1) NOT NULL,
	Name NVARCHAR(100) NOT NULL,
	CONSTRAINT PK_specialize PRIMARY KEY (ID)
)
GO

CREATE TRIGGER dbo.specialize_name ON dbo.specialize
AFTER INSERT, UPDATE
AS
BEGIN
	UPDATE dbo.specialize
	SET dbo.specialize.Name = UPPER(SUBSTRING(s.Name, 1, 1)) + LOWER(SUBSTRING(s.Name, 2, LEN(s.Name) - 1))
	FROM dbo.specialize s, inserted i
	WHERE i.ID = s.ID
END
GO

CREATE TABLE dbo.room
(	ID INT IDENTITY(1, 1) NOT NULL,
	Name NVARCHAR(15) NOT NULL,     -- 123абвгд ...
	HospitalID INT NOT NULL,
	OtdelID INT NOT NULL,
	SpecializeID INT NOT NULL,
	Free_beds INT NOT NULL,
	CONSTRAINT PK_room PRIMARY KEY(ID),
	CONSTRAINT UQ_name_room_hospitalID UNIQUE(Name, HospitalID),
	CONSTRAINT FK_hospital_room FOREIGN KEY(HospitalID) REFERENCES dbo.hospital(ID),
	CONSTRAINT FK_otdel_room FOREIGN KEY(OtdelID) REFERENCES dbo.otdel(ID),
	CONSTRAINT FK_specialize_room FOREIGN KEY(SpecializeID) REFERENCES dbo.specialize(ID)
)
GO

CREATE TABLE dbo.hospital_profession
(	ID INT IDENTITY(1, 1) NOT NULL,
	Name NVARCHAR(90) NOT NULL,
	Salary NVARCHAR(50) NOT NULL,
	Bonus_salary NVARCHAR(50),
	Bonus_salary_tarif NVARCHAR(150),
	CONSTRAINT PK_hospital_profession PRIMARY KEY(ID)
)
GO

CREATE TRIGGER dbo.hospital_profession_name ON dbo.hospital_profession
AFTER INSERT, UPDATE
AS
BEGIN
	UPDATE dbo.hospital_profession
	SET dbo.hospital_profession.Name = UPPER(SUBSTRING(hp.Name, 1, 1)) + LOWER(SUBSTRING(hp.Name, 2, LEN(hp.Name) - 1))
	FROM dbo.hospital_profession hp, inserted i
	WHERE i.ID = hp.ID
END
GO

CREATE TABLE dbo.insurance_org
(	ID INT IDENTITY(1, 1) NOT NULL,
	Name NVARCHAR(200) NOT NULL,
	Addres NVARCHAR(200) NOT NULL,
	CONSTRAINT PK_insurance_org PRIMARY KEY (ID),
	CONSTRAINT UQ_name_addres UNIQUE(Name, Addres)
)
GO

CREATE TABLE dbo.doctor
(	ID INT IDENTITY(1, 1) NOT NULL,
	Hospital_professionID INT NOT NULL,
	OtdelID INT NOT NULL,
	First_name NVARCHAR(100) NOT NULL,      -- имя 
	Second_name NVARCHAR(100) NOT NULL,     -- фамилия
	Patronimyc_name NVARCHAR(100),          -- отчество
	Hire_date DATETIME NOT NULL DEFAULT SYSDATETIME(), -- дата зачисления на службу
	Termination_date DATETIME,                         -- дата увольнения со службы
	Birthday DATETIME NOT NULL, 
	Experience INT NOT NULL,
	Hier_education_institute NVARCHAR(200) NOT NULL, 
	Mobile_number NVARCHAR(20) NOT NULL,
	Home_number NVARCHAR(20) NOT NULL,
	Additional_number NVARCHAR(20),
	Addres NVARCHAR(150) NOT NULL,
	Driver_license BIT,
	Taxpayer_id_number NVARCHAR(50) NOT NULL, -- ИНН
	Insurance_individual_account_number NVARCHAR(50) NOT NULL, -- СНИЛС
	Criminal_conviction BIT NOT NULL, -- есть судимость 1, нет судимости 0
	CONSTRAINT PK_doctor PRIMARY KEY NONCLUSTERED (ID),
	CONSTRAINT FK_hospital_profession_doctor FOREIGN KEY(Hospital_professionID) REFERENCES dbo.hospital_profession(ID),
	CONSTRAINT FK_otdel_doctor FOREIGN KEY(OtdelID) REFERENCES dbo.otdel(ID),
	CONSTRAINT UQ_Doctor_Taxpayer_id_number UNIQUE (Taxpayer_id_number),
	CONSTRAINT UQ_Doctor_Insurance_individual_account_number UNIQUE (Insurance_individual_account_number)
)
GO

CREATE TRIGGER dbo.doctor_name ON dbo.doctor
AFTER INSERT, UPDATE
AS
BEGIN
	UPDATE dbo.doctor
	SET dbo.doctor.First_name = UPPER(SUBSTRING(d.First_name, 1, 1)) + LOWER(SUBSTRING(d.First_name, 2, LEN(d.First_name) - 1)),
		dbo.doctor.Second_name = UPPER(SUBSTRING(d.Second_name, 1, 1)) + LOWER(SUBSTRING(d.Second_name, 2, LEN(d.Second_name) - 1)),
		dbo.doctor.Patronimyc_name = UPPER(SUBSTRING(d.Patronimyc_name, 1, 1)) + LOWER(SUBSTRING(d.Patronimyc_name, 2, LEN(d.Patronimyc_name) - 1))
	FROM dbo.doctor d, inserted i
	WHERE i.ID = d.ID
END
GO

CREATE TRIGGER dbo.otdel_del ON dbo.otdel
INSTEAD OF DELETE
AS 
BEGIN
	DECLARE @I INT;
	SELECT @I = d.ID FROM deleted d
	IF EXISTS(SELECT * FROM dbo.doctor d WHERE d.OtdelID=@I)
	BEGIN
		PRINT 'Ошибка: Нельзя удалить отдел в котором есть доктора.'
		ROLLBACK TRANSACTION
	END
	ELSE
	BEGIN
		DELETE FROM dbo.room  WHERE dbo.room.OtdelID = @I
		DELETE FROM dbo.otdel WHERE dbo.otdel.ID = @I
	END
END
GO

CREATE TABLE dbo.doctor_insurance_number
(	ID INT NOT NULL, -- ЭТО ЕГО НОМЕР СТРАХОВОЙ
	Insurance_orgID INT NOT NULL,
	DoctorID INT NOT NULL,
	CONSTRAINT PK_doctor_insurance_number PRIMARY KEY NONCLUSTERED(ID),
	CONSTRAINT FK_insurance_org_doctor_insurance_number FOREIGN KEY(Insurance_orgID) REFERENCES dbo.insurance_org(ID),
	CONSTRAINT FK_doctor_doctor_insurance_number FOREIGN KEY(DoctorID) REFERENCES dbo.doctor(ID),
	CONSTRAINT UQ_doctor_insurance_orgID UNIQUE CLUSTERED(DoctorID, Insurance_orgID)
)
GO

CREATE TABLE dbo.patient_personal_info
(	ID INT IDENTITY(1,1) NOT NULL,
	First_name NVARCHAR(100) NOT NULL,       -- имя
	Second_name NVARCHAR(100) NOT NULL,      -- фамилия
	Patronimyc_name NVARCHAR(100),           -- отчество
	Birthday DATETIME NOT NULL,
	Mobile_number NVARCHAR(50) NOT NULL,
	Home_number NVARCHAR(50) NOT NULL,
	Additional_number NVARCHAR(50),
	Addres NVARCHAR(100) NOT NULL,
	Driver_license BIT,
	Taxpayer_id_number NVARCHAR(50) NOT NULL, -- ИНН
	Insurance_individual_account_number NVARCHAR(50) NOT NULL, -- СНИЛС
	Criminal_conviction BIT, -- есть судимость 1, нет судимости 0
	CONSTRAINT PK_patient_personal_info PRIMARY KEY NONCLUSTERED (ID),
	CONSTRAINT UQ_Patient_Taxpayer_id_number UNIQUE (Taxpayer_id_number),
	CONSTRAINT UQ_Patient_Insurance_individual_account_number UNIQUE (Insurance_individual_account_number)
) ON Patients_dat
GO

CREATE TRIGGER dbo.patient_personal_info_name ON dbo.patient_personal_info
AFTER INSERT, UPDATE
AS
BEGIN
	UPDATE dbo.patient_personal_info
	SET dbo.patient_personal_info.First_name = UPPER(SUBSTRING(ppi.First_name, 1, 1)) + LOWER(SUBSTRING(ppi.First_name, 2, LEN(ppi.First_name) - 1)),
		dbo.patient_personal_info.Second_name = UPPER(SUBSTRING(ppi.Second_name, 1, 1)) + LOWER(SUBSTRING(ppi.Second_name, 2, LEN(ppi.Second_name) - 1)),
		dbo.patient_personal_info.Patronimyc_name = UPPER(SUBSTRING(ppi.Patronimyc_name, 1, 1)) + LOWER(SUBSTRING(ppi.Patronimyc_name, 2, LEN(ppi.Patronimyc_name) - 1))
	FROM dbo.patient_personal_info ppi, inserted i
	WHERE i.ID = ppi.ID
END
GO

CREATE TABLE dbo.patient_insurance_number
(	ID INT NOT NULL,
	Insurance_orgID INT NOT NULL,
	Patient_personal_infoID INT NOT NULL,
	CONSTRAINT PK_patient_insurance_number PRIMARY KEY NONCLUSTERED(ID),
	CONSTRAINT FK_insurance_org_patient_insurance_number FOREIGN KEY(Insurance_orgID) REFERENCES dbo.insurance_org(ID),
	CONSTRAINT FK_patient_personal_info_patient_insurance_number FOREIGN KEY(Patient_personal_infoID) REFERENCES dbo.patient_personal_info(ID),
	CONSTRAINT UQ_patient_personal_info_insurance_orgID UNIQUE CLUSTERED (Patient_personal_infoID, Insurance_orgID)
) ON Patients_dat
GO

CREATE TABLE dbo.operation
(	ID INT IDENTITY(1, 1) NOT NULL,
	Name NVARCHAR(150) NOT NULL,
	Cost INT NOT NULL,
	CONSTRAINT PK_operation PRIMARY KEY(ID)
)
GO

CREATE TRIGGER dbo.operation_name ON dbo.operation
AFTER INSERT, UPDATE
AS
BEGIN
	UPDATE dbo.operation
	SET dbo.operation.Name = UPPER(SUBSTRING(o.Name, 1, 1)) + LOWER(SUBSTRING(o.Name, 2, LEN(o.Name) - 1))
	FROM dbo.operation o, inserted i
	WHERE i.ID = o.ID
END
GO

CREATE TABLE dbo.operation_patient
(	ID INT IDENTITY(1, 1) NOT NULL,
	DoctorID INT NOT NULL,
	Patient_personal_infoID INT NOT NULL,
	OperationID INT NOT NULL,
	DateOfOperation DATETIME NOT NULL,
	CONSTRAINT PK_operation_patient PRIMARY KEY (ID),
	CONSTRAINT FK_patient_personal_info_operation_patient FOREIGN KEY(Patient_personal_infoID) REFERENCES dbo.patient_personal_info(ID),
	CONSTRAINT FK_operation FOREIGN KEY(operationID) REFERENCES dbo.operation(ID),
	CONSTRAINT FK_doctorID FOREIGN KEY(DoctorID) REFERENCES dbo.doctor(ID)
) ON Patients_dat
GO
--	У человека может быть несколько страховок

CREATE TABLE dbo.patient
(	OtdelID INT NOT NULL,
	DoctorID INT NOT NULL,
	Patient_personal_infoID INT NOT NULL,
	RoomID INT NOT NULL, -- больной лежит в одной комнате
	Day_of_entry DATETIME NOT NULL DEFAULT SYSDATETIME(),
	Day_of_discharge DATETIME,
	Admission_diagnosis NVARCHAR(500) NOT NULL, -- диагноз при поступлении
	Clinical_diagnosis NVARCHAR(500),
	Med_fear_pay BIT NOT NULL, -- мед страх платит?
	CONSTRAINT ID_patient_doctor_otdel_personal_info_room PRIMARY KEY (OtdelID, DoctorID, Patient_personal_infoID, Day_of_entry),
	CONSTRAINT FK_otdel_patient FOREIGN KEY (OtdelID) REFERENCES dbo.otdel(ID),
	CONSTRAINT FK_doctor_patient FOREIGN KEY (DoctorID) REFERENCES dbo.doctor(ID),
	CONSTRAINT FK_patient_personal_info_patient FOREIGN KEY (Patient_personal_infoID) REFERENCES dbo.patient_personal_info(ID),
	CONSTRAINT FK_room_patient FOREIGN KEY (RoomID) REFERENCES dbo.room(ID),
	CONSTRAINT UQ_roomID_patient UNIQUE (RoomID)
) ON Patients_dat
GO

CREATE TRIGGER dbo.patient_insert ON dbo.patient
AFTER INSERT
AS
BEGIN
	DECLARE @FREE_BEDS_CNT INT;
	DECLARE @I INT;
	SELECT @I=i.RoomID FROM inserted i;
	SELECT @FREE_BEDS_CNT = COUNT(*) FROM dbo.patient p WHERE p.RoomID = @I
	DECLARE @REAL_BEDS_CNT INT; 
	SELECT @REAL_BEDS_CNT = r.Free_beds FROM dbo.room r WHERE r.ID = @I;

	IF (@FREE_BEDS_CNT + 1 > @REAL_BEDS_CNT)
	BEGIN
		PRINT 'Ошибка: В палату больше пациентов вместить нельзя, мест нет.'
		ROLLBACK TRANSACTION
	END
END
GO

CREATE TRIGGER dbo.doctor_del ON dbo.doctor
INSTEAD OF DELETE
AS
BEGIN
	DECLARE @I INT;
	SELECT @I = d.ID FROM deleted d
	IF EXISTS(SELECT * FROM dbo.patient p WHERE p.DoctorID=@I)
	BEGIN
		PRINT 'Ошибка: Нельзя удалить доктора у которого есть пациенты.'
		ROLLBACK TRANSACTION
	END
	ELSE
	BEGIN
		DELETE FROM dbo.doctor WHERE dbo.doctor.ID = @I
	END
END
GO

CREATE TABLE dbo.patient_history
(	ID INT IDENTITY(1, 1) NOT NULL,
	Patient_personal_infoID INT NOT NULL,
	DoctorID INT NOT NULL,
	Visit_day DATETIME NOT NULL DEFAULT SYSDATETIME(),
	Temperature INT NOT NULL,
	Preasure INT NOT NULL,
	Complaint NVARCHAR(400) NOT NULL DEFAULT N'Нет', -- жалобы
	CONSTRAINT PK_patient_history PRIMARY KEY (ID),
	CONSTRAINT FK_patient_personal_info_patient_history FOREIGN KEY (Patient_personal_infoID) REFERENCES dbo.patient_personal_info(ID), 
	CONSTRAINT FK_doctor_patient_history FOREIGN KEY (DoctorID) REFERENCES dbo.doctor(ID)
 ) ON Patients_dat
GO

CREATE TRIGGER dbo.patient_del ON dbo.patient
INSTEAD OF DELETE
AS
BEGIN
	DECLARE @PATIENT_HISTORY_ID INT;
	DECLARE @PATIENT_PERSONAL_INFO_ID INT;
	DECLARE @I INT;

	SELECT @PATIENT_PERSONAL_INFO_ID = d.Patient_personal_infoID FROM deleted d
	SELECT @PATIENT_HISTORY_ID = ph.ID FROM dbo.patient_history ph WHERE ph.Patient_personal_infoID = @PATIENT_PERSONAL_INFO_ID
	DELETE FROM dbo.patient_history WHERE dbo.patient_history.ID = @PATIENT_HISTORY_ID
	DELETE FROM dbo.patient_personal_info WHERE dbo.patient_personal_info.ID = @PATIENT_PERSONAL_INFO_ID
	UPDATE dbo.patient
	SET dbo.patient.Day_of_discharge = SYSDATETIME();
END