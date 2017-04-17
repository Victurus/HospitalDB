USE Hospitals
GO
-- удаление хранимых функций(для пересоздания)

IF OBJECT_ID('dbo.doctor_cnt', 'P') IS NOT NULL
	DROP PROCEDURE dbo.doctor_cnt;
GO

IF OBJECT_ID('dbo.patient_cnt', 'P') IS NOT NULL
	DROP PROCEDURE dbo.patient_cnt;
GO

IF OBJECT_ID('dbo.hire_doctor', 'P') IS NOT NULL
	DROP PROCEDURE dbo.hire_doctor;
GO

IF OBJECT_ID('dbo.patient_to_hospital', 'P') IS NOT NULL
	DROP PROCEDURE dbo.patient_to_hospital;
GO

IF OBJECT_ID('dbo.doctor_patient_cnt', 'P') IS NOT NULL
	DROP PROCEDURE dbo.doctor_patient_cnt;
GO

IF OBJECT_ID('dbo.money_cnt', 'P') IS NOT NULL
	DROP PROCEDURE dbo.money_cnt;
GO

IF OBJECT_ID('dbo.temperature_choose', 'P') IS NOT NULL
	DROP PROCEDURE dbo.temperature_choose;
GO

IF OBJECT_ID('dbo.hospital_doctor_cnt', 'P') IS NOT NULL
	DROP PROCEDURE dbo.hospital_doctor_cnt;
GO

IF OBJECT_ID('dbo.hospital_free_beds_cnt', 'P') IS NOT NULL
	DROP PROCEDURE dbo.hospital_free_beds_cnt;
GO

-- конец удаления хранимых функций

-- создание хранимых процедур

CREATE PROCEDURE dbo.doctor_cnt
@CNT INT OUTPUT
AS
	SELECT @CNT = COUNT(*) FROM dbo.doctor
GO

CREATE PROCEDURE dbo.patient_cnt
@CNT INT OUTPUT
AS
	SELECT @CNT = COUNT(*) FROM dbo.patient 
GO

CREATE PROCEDURE dbo.hire_doctor 
@Hosp_profID INT, 
@OtdelID INT, 
@First_name NVARCHAR(100),
@Second_name NVARCHAR(100),     
@Patronimyc_name NVARCHAR(100), 
@Hire_date DATETIME =SYSDATETIME,
@Termination_date DATETIME,
@Birthday DATETIME,
@Experience INT,
@Hier_education_institute NVARCHAR(150), 
@Mobile_number NVARCHAR(20),
@Home_number NVARCHAR(20),
@Additional_number NVARCHAR(20),
@Addres NVARCHAR(100),
@Driver_license BIT,
@Taxpayer_id_number NVARCHAR(50), -- ИНН
@Insurance_individual_account_number NVARCHAR(50), -- СНИЛС
@Criminal_conviction BIT -- есть судимость 1, нет судимости 0
AS
	INSERT INTO dbo.doctor VALUES
		(@Hosp_profID, @OtdelID, @First_name, @Second_name, @Patronimyc_name, @Hire_date, @Termination_date, @Birthday, @Experience, @Hier_education_institute, @Mobile_number, @Home_number, @Additional_number, @Addres, @Driver_license, @Taxpayer_id_number, @Insurance_individual_account_number, @Criminal_conviction)
GO

CREATE PROCEDURE dbo.patient_to_hospital
@First_name NVARCHAR(100),
@Second_name NVARCHAR(100),
@Patronimyc_name NVARCHAR(100),
@Birthday DATETIME,
@Mobile_number NVARCHAR(50),
@Home_number NVARCHAR(50),
@Additional_number NVARCHAR(50),
@Addres NVARCHAR(50),
@Driver_license BIT,
@Taxpayer_id_number NVARCHAR(50),
@Insurance_individual_account_number NVARCHAR(50), 
@Criminal_conviction BIT,
@OtdelID INT,
@DoctorID INT,
@RoomID INT,
@Day_of_entry DATE,
@Day_of_discharge DATE,
@Admission_diagnosis NVARCHAR(500),
@Clinical_diagnosis NVARCHAR(500),
@Med_fear_pay BIT
AS
	INSERT INTO dbo.patient_personal_info VALUES
		(@First_name , @Second_name , @Patronimyc_name , @Birthday , @Mobile_number , @Home_number , @Additional_number , @Addres , @Driver_license , @Taxpayer_id_number , @Insurance_individual_account_number , @Criminal_conviction)

	DECLARE @Patient_personal_infoID INT;
	SELECT @Patient_personal_infoID = ppi.ID FROM dbo.patient_personal_info ppi
	WHERE ppi.First_name = @First_name AND 
		  ppi.Second_name = @Second_name AND
		  ppi.Patronimyc_name = @Patronimyc_name AND
		  ppi.Insurance_individual_account_number = @Insurance_individual_account_number

	INSERT INTO dbo.patient VALUES
		(@OtdelID, @DoctorID, @Patient_personal_infoID, @RoomID, @Day_of_entry, @Day_of_discharge, @Admission_diagnosis, @Clinical_diagnosis, @Med_fear_pay)
GO

CREATE PROCEDURE dbo.doctor_patient_cnt
@ID INT =-1
AS
	IF @ID < 0
	BEGIN
		SELECT 
			CONCAT(d.First_name,' ', d.Second_name,' ', d.Patronimyc_name) AS [ФИО врача],
			o.Name AS [Название отдела],
			(SELECT COUNT(*) FROM dbo.patient p WHERE p.DoctorID = d.ID) AS [Количество пациентов]
		FROM dbo.doctor d
		JOIN dbo.otdel o ON d.OtdelID = o.ID	
	END
	ELSE
	BEGIN
		SELECT 
			CONCAT(d.First_name,' ', d.Second_name,' ', d.Patronimyc_name) AS [ФИО врача],
			o.Name AS [Название отдела],
			(SELECT COUNT(*) FROM dbo.patient p WHERE p.DoctorID = d.ID) AS [Количество пациентов]
		FROM dbo.doctor d, dbo.otdel o
		WHERE d.ID = @ID AND o.ID = d.OtdelID
	END
GO

CREATE PROCEDURE dbo.money_cnt
@Year_situation INT =-1
AS
	DECLARE @FIVE     INT;
	DECLARE @TEN      INT;
	DECLARE @FIVTEEN  INT;
	DECLARE @BIRTHDAY INT;
	IF @Year_situation < 0
	BEGIN
		SET @FIVE     = 0;
		SET @TEN      = 0;
		SET @FIVTEEN  = 0;
		SET @BIRTHDAY = 0;
	END
	ELSE IF @Year_situation = 1
	BEGIN
		SET @FIVE     = 1000;
		SET @TEN      = 4000;
		SET @FIVTEEN  = 6000;
		SET @BIRTHDAY = 3000;
	END
	ELSE IF @Year_situation = 2
	BEGIN 
		SET @FIVE     =  5000;
		SET @TEN      = 10000;
		SET @FIVTEEN  = 15000;
		SET @BIRTHDAY = 10000;
	END
	ELSE IF @Year_situation > 2
	BEGIN 
		SET @FIVE     = 10000;
		SET @TEN      = 15000;
		SET @FIVTEEN  = 20000;
		SET @BIRTHDAY = 16000;
	END

	SELECT
	CONCAT(d.Second_name,' ', d.First_name,' ',d.Patronimyc_name) AS [ФИО доктора],
	hp.Name AS [Наименование профессии],
	hp.Salary AS [Исходная зарплата],
	CASE
		WHEN d.Experience > 5  THEN @FIVE
		WHEN d.Experience > 10 THEN @TEN 
		WHEN d.Experience > 15 THEN @FIVTEEN
		ELSE 0
	END [Премия за стаж],
	hp.Bonus_salary AS [Обычная премия],
	IIF(DATEPART(MONTH, d.Birthday) = DATEPART(MONTH, SYSDATETIME()) AND 
		  DATEPART(DAY, d.Birthday)   = DATEPART(DAY,   SYSDATETIME()), @BIRTHDAY, 0) 
		  AS [День рожденная премия],
	CONVERT(INT, hp.Salary) + CONVERT(INT, hp.Bonus_salary) + 
	CASE
		WHEN d.Experience > 5  THEN @FIVE
		WHEN d.Experience > 10 THEN @TEN
		WHEN d.Experience > 15 THEN @FIVTEEN
		ELSE 0
	END 
	+ IIF(DATEPART(MONTH, d.Birthday) = DATEPART(MONTH, SYSDATETIME()) AND 
		  DATEPART(DAY, d.Birthday)   = DATEPART(DAY,   SYSDATETIME()), @BIRTHDAY, 0)
	AS [Полная заработная плата]
FROM dbo.doctor d LEFT JOIN dbo.hospital_profession hp ON d.Hospital_professionID = hp.ID
WHERE d.Termination_date IS NOT NULL
ORDER BY 
	[Полная заработная плата]
GO

CREATE PROCEDURE dbo.temperature_choose
@TEMPERATURE INT =37
AS
	IF @TEMPERATURE > 40 OR @TEMPERATURE < 30
	BEGIN
		PRINT 'Вы псих ненормальный, такой температуры быть не может!!!'
	END
	ELSE
	BEGIN
		SELECT 
			CONCAT(ppi.Second_name,' ', ppi.First_name,' ',ppi.Patronimyc_name) AS [ФИО пациента],
			ph.Temperature AS [Температура больного],
			ph.Preasure AS [Давление больного],
			ph.Complaint AS [Жалобы больного],
			CONCAT(d.Second_name,' ',d.First_name,' ',d.Patronimyc_name) AS [ФИО доктора], 
			d.Mobile_number AS [Мобильный доктора],
			r.Name AS [Палата]
		FROM dbo.patient p 
		JOIN dbo.patient_personal_info ppi ON p.Patient_personal_infoID = ppi.ID
		JOIN dbo.patient_history ph ON ph.Patient_personal_infoID = ppi.ID
		JOIN dbo.doctor d ON d.ID = p.DoctorID
		JOIN dbo.room r ON p.RoomID = r.ID
		WHERE ph.Temperature = @TEMPERATURE
	END
GO

CREATE PROCEDURE dbo.hospital_doctor_cnt
@ID INT =-1
AS
	IF @ID < 0
	BEGIN
		SELECT 
			h.Name AS [Название больницы],
			(SELECT COUNT(*) 
			 FROM dbo.doctor d 
			 JOIN dbo.otdel o ON d.OtdelID = o.ID 
			 WHERE o.HospitalID = h.ID) AS [Количество докторов в больнице]
		FROM dbo.hospital h
		JOIN dbo.region r  ON r.ID = h.RegionID
		END
	ELSE
	BEGIN
		SELECT 
			h.Name AS [Название больницы],
			(SELECT COUNT(*) 
			 FROM dbo.doctor d 
			 JOIN dbo.otdel o ON d.OtdelID = o.ID 
			 WHERE o.HospitalID = h.ID) AS [Количество докторов в больнице]
		FROM dbo.hospital h
		JOIN dbo.region r  ON r.ID = h.RegionID
		WHERE H.ID = @ID
	END
GO

CREATE PROCEDURE dbo.hospital_free_beds_cnt
@ID INT =-1, @GETINFO BIT =0, @MYCURSOR CURSOR VARYING OUTPUT
AS
	IF @ID < 0
	BEGIN
		SET NOCOUNT ON;
		SET @MYCURSOR = CURSOR
		FORWARD_ONLY STATIC FOR
			SELECT
				h.Name AS [Название больницы],
				r.Free_beds - (SELECT COUNT(*) FROM dbo.patient p WHERE r.ID = p.RoomID) AS [Количество свободных мест]
			FROM dbo.hospital h
			RIGHT JOIN dbo.room r ON r.HospitalID = h.ID
	END
	ELSE IF @ID < (SELECT COUNT(*) FROM dbo.hospital)
	BEGIN
	SET NOCOUNT ON;
		SET @MYCURSOR = CURSOR
		FORWARD_ONLY STATIC FOR
			SELECT
				h.Name AS [Название больницы],
				r.Free_beds - (SELECT COUNT(*) FROM dbo.patient p WHERE r.ID = p.RoomID) AS [Количество свободных мест]
			FROM dbo.hospital h
			JOIN dbo.room r ON r.HospitalID = h.ID
			WHERE h.ID = @ID
	END
	ELSE
	BEGIN
		PRINT 'Ошибка: Нет больницы с таким индексом'
		RETURN 1
	END

	OPEN @MYCURSOR;
	IF @GETINFO = 1
	BEGIN
		DECLARE @FNAME NVARCHAR(350);
		DECLARE @CNT INT;
		FETCH NEXT FROM @MYCURSOR INTO
		@FNAME, @CNT;

		DECLARE @LNAME NVARCHAR(350);
		DECLARE @FILLER VARCHAR(350);
		SET @FILLER = '                                          ';
		PRINT @FILLER + 'Больница' + ' | ' + 'Свободные места'
		WHILE (@@FETCH_STATUS = 0)
		BEGIN
			DECLARE @LOCALCNT INT;
			FETCH NEXT FROM @MYCURSOR INTO
			@LNAME, @LOCALCNT;
			IF @FNAME = @LNAME
			BEGIN
				SET @CNT = @CNT + @LOCALCNT;
			END
			ELSE
			BEGIN
				PRINT @FNAME + ' | ' + CONVERT(VARCHAR(100), @CNT)
				SET @CNT = 0
			END
			SET @FNAME = @LNAME;
		END
		PRINT @FNAME + ' | ' + CONVERT(VARCHAR(100), @CNT)
	END
	RETURN 0
GO

-- конец создания хранимых процедур

-- вызов хранимых процедур

DECLARE @MYCURSOR CURSOR;
EXEC dbo.hospital_free_beds_cnt DEFAULT, 1, @MYCURSOR OUTPUT;
--FETCH NEXT FROM @MYCURSOR;
CLOSE @MYCURSOR;
DEALLOCATE @MYCURSOR;
EXEC dbo.hospital_free_beds_cnt 5, 1, @MYCURSOR OUTPUT;

--EXEC dbo.hospital_doctor_cnt DEFAULT;
--EXEC dbo.hospital_doctor_cnt 15;

--EXEC dbo.temperature_choose DEFAULT;
--EXEC dbo.temperature_choose 300;

--EXEC dbo.money_cnt DEFAULT;
--EXEC dbo.money_cnt 1;

--EXEC dbo.doctor_patient_cnt DEFAULT;
/*
SELECT 
	 CONCAT(d.First_name,' ', d.Second_name,' ', d.Patronimyc_name) AS [ФИО врача],
	 o.Name AS [Название отдела]
FROM dbo.doctor d
FULL JOIN dbo.otdel o ON o.ID = d.OtdelID
WHERE d.ID = 9
*/
--EXEC dbo.doctor_patient_cnt 9;

--EXEC dbo.patient_to_hospital N'Василий', N'Петрович', N'Пупков', '10-04-1993', '+89432483364', '334422', NULL, N'Улица Шлимпампуськиных д. 5', 1, N'33398014245', N'81482847876', 0, 4, 43, 1044, '20001010', NULL, N'Устал', N'Зашибись', 1;
--SELECT * FROM dbo.patient_personal_info ppi
--JOIN dbo.patient p ON p.Patient_personal_infoID = ppi.ID
--WHERE ppi.ID = 700004

--EXEC dbo.hire_doctor 21, 9737, N'Сидр', N'Баранович', N'Здравый', '10-3-1946', '10-6-1937', '25-4-1985',23, 'Академия дятлов', '+728168174816','335759','+764584865575',    'Город этот улица №0',0,32294215682,723418374754,0;
--SELECT * FROM dbo.doctor d
--ORDER BY d.First_name

--DECLARE @MYCNT INT;
--EXEC dbo.patient_cnt @MYINT OUTPUT;
----PRINT 'Пациентов у нас ровно ' + CONVERT(VARCHAR(20), @MYCNT) + ' человек.';

--EXEC dbo.doctor_cnt @MYCNT OUTPUT ;
--PRINT 'Докторов у нас ровно ' + CONVERT(VARCHAR(20), @MYCNT) + ' человек.';
GO