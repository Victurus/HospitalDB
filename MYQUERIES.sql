/* Helper
	SELECT - ������� ������ �� ������� � ����������� �� � ����������� ����� ��(dbo)

	SELECT * FROM [SCHEMA_NAME].[TABLE_NAME]

	��������� ��� �������� � ��� ������� �� �������

	SELECT [TABLE_ALIAS].ID, ...
	FROM [SCHEMA_NAME].[TABLE_NAME] AS [TABLE_ALIAS]

	������� ���������� ��� �������. ��� �������� ������� ��������� ������� ������� ������.
	�������� ����� AS ����� ��������.

	����� � ������ ����������� ����(���� ��� ������ �� ����� �������)

	SELECT DISTINCT [TABLE_ALIAS].Col1, [TABLE_ALIAS].Col2, [TABLE_ALIAS].Col3
	FROM [SCHEMA_NAME].[TABLE_NAME] [TABLE_ALIAS]

	DISTINCT - �������� ������������ ����� ����������

	������� ����������� ��� �������� �������

	SELECT 
			-- ������ ������������ �������
			 Second_name + ' ' + First_name + ' ' + Patronimyc_name AS ���,
			-- ������������� ������� �������, ��� ��� ������������ ������
			Hire_date AS "���� ������",
			-- ������������� ���������� ������, ����� �������
			Birthday AS [���� ��������],
			-- ����� AS �� �����������
			dbo.doctor.Insurance_individual_account_number �����
	FROM dbo.doctor 

	� ������ ������ � ������ ������ ���� ���� �� ����� ����� NULL �� � �� ����� NULL (��� ���������� ������)
	������� �����:

	SELECT 
		 -- ��� ����
		Second_name + ' ' + First_name + ' ' + Patronimyc_name AS ���,
		-- ��� ������ ISNULL(����,'���� ���� NULL �� �������� ����� ��� ������')
		ISNULL(Second_name,'') + ' ' + ISNULL(First_name,'') + ' ' + ISNULL(Patronimyc_name,'') AS ���,
		CONCAT(Second_name, ' ', First_name, ' ', Patronimyc_name)AS ���
	FROM dbo.doctor

	SELECT 
		'���� �����'=Hire_date,  -- ������ "..." � [...] ����� ������������ '...'
		[���� ��������]=Birthday,
		�����=dbo.doctor.Insurance_individual_account_number
	FROM dbo.doctor
	
	�������������� �������� �� �� ��� � � �++ ���������, ��� � ����������(�� �� �������� ��� 3-�������� ������)

	������ ������� ISNULL ��� ���� ������� COALESCE:

	COALESCE(expr1, expr2, expr3, ...) -- ���������� ������ �� NULL �������� �� ������ ��������

	�������� �����������

	���� ���� - 5, ����� ���������� JOIN
	1.       JOIN - �����_�������       JOIN ������_������� ON �������_����������
	2. LEFT  JOIN - �����_������� LEFT  JOIN ������_������� ON �������_����������
	3. RIGHT JOIN - �����_������� RIGHT JOIN ������_������� ON �������_����������
	4. FULL  JOIN - �����_������� FULL  JOIN ������_������� ON �������_����������
	5. CROSS JOIN - �����_������� CROSS JOIN ������_�������

	+-------------------------------------------------------------------------------------+
	| �������    | ������       | ��������                                                |
	| ���������  | ���������    |                                                         |
	+-------------------------------------------------------------------------------------+
	| JOIN       | INNER JOIN   | �� ����� �����_������� � ������_������� ������������ �  |
	|            |              | ������������ ������ �� ������, �� ������� �����������   |
	|            |              | �������_����������.                                     |
	+-------------------------------------------------------------------------------------+
	| LEFT JOIN  | LEFT OUTER   | ������������ ��� ������ �����_�������(�������� �����    |
	|            | JOIN         | LEFT). ������� ������_������� ����������� ������ ��     |
	|            |              | ������ �����_�������, ��� ������� ����������� �������_  |
	|            |              | ����������. ��� ����������� ������ ������ ����� ������_ |
	|            |              | ������� ���������� NULL-��������.                       |
	+-------------------------------------------------------------------------------------+
	| RIGHT JOIN | RIGHT OUTER  | ������������ ��� ������ ������_�������(�������� �����   |
	|            | JOIN         | RIGHT). ������� �����_������� ����������� ������ ��     |
	|            |              | ������ ������_�������, ��� ������� ����������� �������_ |
	|            |              | ����������. ��� ����������� ������ ������ ����� �����_  |
	|            |              | ������� ���������� NULL-��������.                       |
	+-------------------------------------------------------------------------------------+
	| FULL JOIN  | FULL OUTER   | ������������ ��� ������ �����_������� � ������_�������. |
	|            | JOIN         | ���� ��� ����� �����_������� � ������_�������           |
	|            |              | ����������� �������_����������, �� ��� ������������ �   |
	|            |              | ���� ������. ��� �����, ��� ������� �� �����������      |
	|            |              | �������_����������, NULL-�������� ����������� �� �����  |
	|            |              | �����_�������, ���� �� ����� ������_�������, �          |
	|            |              | ����������� �� ���� ������ ����� ������� � ������ ��    |
	|            |              | �������.                                                |
	+-------------------------------------------------------------------------------------+
	| CROSS JOIN | -            | ����������� ������ ������ �����_������� �� �����        |
	|            |              | �������� ������_�������. ���� ��� ���������� ������     |
	|            |              | �������� ���������� �������������.                      |
	+-------------------------------------------------------------------------------------+

	������� ����

	SELECT DATEPART(datepart, '2007-10-30 12:15:32.1234567 +05:10') AS [����� ����]

	,��� datepart ����� ��������� ��������� ��������

	+--------------------------------+
	| datepart        | return value |
	+--------------------------------+
	| YEAR,YYYY,YY    |     2007     |
	| QUARTER,QQ,Q    |      4       |
	| MONTH,MM,M      |      9       |
	| DAYOFYEAR,DY,Y  |     303      |
	| DAY,DD,D        |     30       |
	| WEEK,WK,WW      |     45       |
	| WEEKDAY,DW      |   1 Check    |
	| HOUR,HH         |     11       |
	| MINUTE,N        |     15       |
	| SECOND,SS,S     |     32       |
	| MILLISECOND,MS  |     123      |
	| MICROSECOND,MCS |  123456      |
	| NANOSECOND,NS   |  123456700   |
	| TZoffset,tz     |     310      |
	+--------------------------------+

	����� ������ ��� ������ WHERE �������

	SELECT d.ID, d.First_name, d.Mobile_number
	FROM dbo.doctor d
	WHERE DATEPART(MONTH, d.Birthday) = DATEPART(MONTH, SYSDATETIME())
		AND DATEPART(DAY, d.Birthday) = DATEPART(DAY, SYSDATETIME())

	��� ������ WHERE ����� ������ ������� ����������� JOIN, �� ��-�� ����� �����
	���������� ��������� ��� ������ ���� ������ �������������, � ����� � ��� ����� 
	������ �� ���� � ����������.

	�������� UPDATE

	UPDATE dbo.region
	SET dbo.region.Name = UPPER(SUBSTRING(r.Name, 1, 1)) + LOWER(SUBSTRING(r.Name, 2, LEN(r.Name) - 1))
	FROM dbo.region r, inserted i 
	WHERE r.ID=i.ID

	/\/\/\/\/\ - ��� ������ ��������� ������ ������� �� ������ ������ ������ �������, ��� ��� ���

	UPDATE [����������� �������]
	SET [����������� ���(�,�)] = [�������� �� ��������� ������ ����� ��������� �������]
	FROM [��� �������(����� ���������)], [����� ���� ��� �������], (... ����� ���� ����� ������)
	WHERE [�������]
*/

USE Hospitals
GO

-- ��������� ����������
SET STATISTICS IO ON
SET STATISTICS TIME ON

-- ������� ���� ������ �� ���� ������� � �� ��������������
SELECT 
	r.Name AS [������������ �������], 
	h.Name AS [�������� ��������], 
	o.Name AS [�������� ������], 
	s.Name AS [���������� �������],
	r.Free_beds AS [��������� �������]
FROM dbo.room r
     JOIN dbo.hospital h   ON h.ID=r.HospitalID
LEFT JOIN dbo.otdel o      ON o.ID=r.OtdelID
RIGHT JOIN dbo.specialize s ON s.ID=r.SpecializeID 

-- ������� ������� � ����� ��������� � �������
SELECT 
	h.Name AS [�������� ��������], 
	h.Date_of_foundation AS [���� ���������], 
	r.Name AS [����� ���������]
FROM dbo.hospital h
FULL JOIN dbo.region r ON r.ID=h.RegionID

-- ������� �������� �� ������� �����
SELECT 
	CONCAT(d.Second_name,' ', d.First_name,' ',d.Patronimyc_name) AS [���],
	CONCAT(SUBSTRING(d.Mobile_number, 1, 2),' ', SUBSTRING(d.Mobile_number, 3, 3),' ',SUBSTRING(d.Mobile_number, 6, 3), ' ', SUBSTRING(d.Mobile_number, 9, 2), ' ', SUBSTRING(d.Mobile_number, 11, 2)) AS [��������� �������],
	CONCAT(SUBSTRING(d.Home_number, 1, 2),' - ', SUBSTRING(d.Home_number, 3, 2),' - ',SUBSTRING(d.Home_number, 5, 2)) AS [�������� �������],
	CONCAT(SUBSTRING(d.Additional_number, 1, 2),' ', SUBSTRING(d.Additional_number, 3, 3),' ',SUBSTRING(d.Additional_number, 6, 3), ' ', SUBSTRING(d.Additional_number, 9, 2), ' ', SUBSTRING(d.Additional_number, 11, 2)) AS [��������������],
	IIF(d.Criminal_conviction = 1, '����', '���') AS [���������],
	d.Addres AS [�����]
FROM dbo.doctor d
WHERE d.Second_name LIKE '%�����%'

-- ������� �� ������� ��������. ��������, � ���� ����� ����������� �����. 3 ���� ��������� �������
SELECT 
	CONCAT(d.Second_name,' ', d.First_name,' ',d.Patronimyc_name) AS [���],
	hp.Salary AS [���������� �����]
FROM dbo.doctor d
JOIN dbo.hospital_profession hp ON hp.ID=d.Hospital_professionID
-- �������, �� ���������� ������
SELECT 
	ISNULL(d.Second_name,'') + ' ' + ISNULL(d.First_name,'') + ' ' + ISNULL(d.Patronimyc_name,'') AS [���],
	hp.Salary AS [���������� �����]
FROM dbo.doctor d
JOIN dbo.hospital_profession hp ON hp.ID=d.Hospital_professionID
-- ������ ������, �� � ���� ����, � �������, ��������. ����� �������� ����� ���� 
-- ����� NULL, � �� �������� ���������� ������ �� ���� ��� ����� NULL.
SELECT 
	d.Second_name + ' ' + d.First_name + ' ' + d.Patronimyc_name AS [���],
	hp.Salary AS [���������� �����]
FROM dbo.doctor d
JOIN dbo.hospital_profession hp ON hp.ID=d.Hospital_professionID

-- �������� ������� ����� ���������
SELECT 
	CONCAT(d.Second_name,' ', d.First_name,' ',d.Patronimyc_name) AS [���],
	hp.Salary + COALESCE(CONVERT(INT, hp.Bonus_salary), 0) AS [������ ��������]
FROM dbo.doctor d
RIGHT JOIN dbo.hospital_profession hp ON hp.ID=d.Hospital_professionID

-- ������� ��������� �� ����������, � �� ��������� � ����������
SELECT 
	CONCAT(ppi.Second_name,' ', ppi.First_name,' ',ppi.Patronimyc_name) AS [��� ��������],
	CONCAT(d.Second_name,' ', d.First_name,' ',d.Patronimyc_name) AS [��� �������� �������],
	p.Admission_diagnosis AS [������� ��� �����������],
	p.Clinical_diagnosis AS  [����������� �������]
FROM dbo.patient p
JOIN dbo.patient_personal_info ppi ON ppi.ID=p.Patient_personal_infoID
JOIN dbo.doctor d ON d.ID=p.DoctorID
WHERE p.Med_fear_pay=1

-- � ��� �������� - ������������ � ���� ������
SELECT 
	CONCAT(d.Second_name,' ', d.First_name,' ',d.Patronimyc_name) AS [���],
	d.Mobile_number AS [��������� �����],
	10000 AS [������ �� ���� ��������],
	CONVERT(INT, hp.Salary) + CONVERT(INT, hp.Bonus_salary) + 10000 AS [������ ��������]
	FROM dbo.doctor d
	JOIN dbo.hospital_profession hp ON hp.ID=d.Hospital_professionID
	WHERE DATEPART(MONTH, d.Birthday) = DATEPART(MONTH, SYSDATETIME()) AND 
		  DATEPART(DAY, d.Birthday) = DATEPART(DAY, SYSDATETIME())     AND
		  d.Termination_date IS NOT NULL

-- ������� ��������
SELECT 
	CONCAT(ppi.Second_name,' ', ppi.First_name,' ',ppi.Patronimyc_name) AS [��� ��������],
	o.Name AS [������������ ��������]
FROM dbo.patient p
LEFT JOIN dbo.operation_patient op ON op.Patient_personal_infoID=p.Patient_personal_infoID
JOIN dbo.patient_personal_info ppi ON ppi.ID=p.Patient_personal_infoID
JOIN dbo.operation o ON o.ID=op.ID

SELECT 
	UPPER(SUBSTRING(s.Name, 1, 1)) + SUBSTRING(s.Name, 2, LEN(s.Name) - 1) AS [�������������]
FROM dbo.specialize s

SELECT 
	CONCAT(d.Second_name,' ', d.First_name,' ',d.Patronimyc_name) AS [���]
FROM dbo.doctor d 
WHERE DATEPART(YEAR, d.Birthday) > 1970

SELECT 
	CONCAT(d.Second_name,' ', d.First_name,' ',d.Patronimyc_name) AS [���]
FROM dbo.doctor d
WHERE EXISTS (SELECT * FROM dbo.patient_personal_info ppi WHERE ppi.ID=d.ID)

-- ��������� ������ �� ����, � ����������� �� ����, ��� ��� ������
SELECT
	d.ID,
	CONCAT(d.Second_name,' ', d.First_name,' ',d.Patronimyc_name) AS [��� �������],
	hp.Name AS [������������ ���������],
	hp.Salary AS [�������� ��������],
	CASE
		WHEN d.Experience > 5  THEN 5000
		WHEN d.Experience > 10 THEN 10000
		WHEN d.Experience > 15 THEN 15000
		ELSE 0
	END [������ �� ����],
	hp.Bonus_salary AS [������� ������],
	CONVERT(INT, hp.Salary) + CONVERT(INT, hp.Bonus_salary) + 
	CASE
		WHEN d.Experience > 5  THEN 5000
		WHEN d.Experience > 10 THEN 10000
		WHEN d.Experience > 15 THEN 15000
		ELSE 0
	END [������ ���������� �����]
FROM dbo.doctor d LEFT JOIN dbo.hospital_profession hp ON d.Hospital_professionID = hp.ID
WHERE d.Termination_date IS NOT NULL
ORDER BY 
	[������ ���������� �����]

-- ��� ������� LEFT JOIN � WHERE ���������� ������ � ���� �� �������
SELECT 
	d.ID, 
	CONCAT(d.Second_name,' ', d.First_name,' ',d.Patronimyc_name) AS [��� �������],
	hp.ID AS [id ���������],
	d.Hospital_professionID
FROM dbo.doctor d LEFT JOIN dbo.hospital_profession hp ON d.Hospital_professionID=hp.ID
ORDER BY 
	d.ID 

SELECT 
	d.ID, 
	CONCAT(d.Second_name,' ', d.First_name,' ',d.Patronimyc_name) AS [��� �������],
	hp.ID AS [id ���������],
	d.Hospital_professionID
FROM dbo.doctor d, dbo.hospital_profession hp 
WHERE d.Hospital_professionID=hp.ID

-- �������� ��������� � ������� ������� �����������
SELECT 
	CONCAT(ppi.Second_name,' ', ppi.First_name,' ',ppi.Patronimyc_name) AS [���],
	ph.Temperature AS [�����������],
	ph.Preasure AS [��������],
	ph.Visit_day AS [���� �������],
	ph.Complaint AS [������]
FROM dbo.patient p LEFT JOIN dbo.patient_personal_info ppi ON p.Patient_personal_infoID=ppi.ID
	 LEFT JOIN dbo.patient_history ph ON ph.Patient_personal_infoID=ppi.ID
GROUP BY ph.ID,ppi.Second_name,ppi.First_name,ppi.Patronimyc_name,ph.Temperature, ph.Preasure, ph.Complaint, ph.Visit_day
HAVING CONVERT(INT, ph.Temperature) > 36

SELECT 
	SUM(CONVERT(INT, hp.Salary) + CONVERT(INT, hp.Bonus_salary)) AS [�� ������ �������� ����������� ���������� ��������]
FROM dbo.doctor d LEFT JOIN dbo.hospital_profession hp ON d.Hospital_professionID=hp.ID

-- ������� �������� � ������� ���� ��������
SELECT 
	CONCAT(d.Second_name,' ', d.First_name,' ',d.Patronimyc_name) AS [��� �������],
	d.Mobile_number AS [��������� �������]
FROM dbo.doctor d
WHERE EXISTS(SELECT * FROM dbo.patient p WHERE d.ID=p.DoctorID)

-- ��������� � ���� �� ������ ������� ���������
SELECT 
	CONCAT(d.Second_name,' ', d.First_name,' ',d.Patronimyc_name) AS [��� �������],
	d.Addres AS [�����],
	IIF(d.Criminal_conviction=1, '����', '���') AS [���������]
FROM dbo.doctor d

-- � ���� �� ��������� ���� ���������
SELECT 
	CONCAT(ppi.Second_name,' ', ppi.First_name,' ',ppi.Patronimyc_name) AS [��� ��������],
	ppi.Addres AS [�����],
	IIF(ppi.Criminal_conviction=1, '����', '���') AS [���������],
	IIF(p.Med_fear_pay=1, '��', '���') AS [��� ����� ������?],
	IIF(ppi.Criminal_conviction=1 AND p.Med_fear_pay=1, '����� �����', '������� �� �����') AS [������ ������]
FROM dbo.patient_personal_info ppi RIGHT JOIN dbo.patient p ON p.Patient_personal_infoID=ppi.ID

-- ��������� ������
-- �������� ������ ���� ��������� ���� "����������" ��������, � ������� ���� ����� � ���������
SELECT 
	CONCAT(ppi.Second_name,' ', ppi.First_name,' ',ppi.Patronimyc_name) AS [��� ��������],
	ppi.Mobile_number AS [��������� �����],
	ppi.Taxpayer_id_number AS [���],
	p.DoctorID 
FROM dbo.patient p 
LEFT JOIN dbo.patient_personal_info ppi ON ppi.ID = p.Patient_personal_infoID
WHERE 
p.DoctorID IN (SELECT d.ID FROM dbo.doctor d) AND 
p.Med_fear_pay = 1                            AND
p.RoomID IN (SELECT r.ID FROM dbo.room r WHERE r.HospitalID IN 
			(SELECT h.ID FROM dbo.hospital h WHERE h.RegionID IN 
			(SELECT r.ID FROM dbo.region r WHERE r.Name LIKE '%����������%')))
								  

-- ��� ���� ����������� � ������ ������ � ��������, � ��� ���
SELECT 
	CONCAT(d.Second_name,' ',d.First_name,' ',d.Patronimyc_name) AS [���], 
	d.Mobile_number AS [��������� �������], 
	IIF(1 = 1, '������', '�������') AS [���] 
FROM dbo.doctor d 
UNION -- ��� �� ����� -- !!!
SELECT 
	CONCAT(ppi.Second_name,' ',ppi.First_name,' ',ppi.Patronimyc_name) AS [���], 
	ppi.Mobile_number AS [��������� �������], 
	IIF(1 = 0, '������', '�������') AS [���] 
	FROM dbo.patient_personal_info ppi
ORDER BY [���]
GO

-- ����� �������
DECLARE @SALARY INT = 70000;
PRINT '���� �� ���, �������� ����� ' + CONVERT(VARCHAR, @SALARY) + '?'
IF @SALARY < SOME (SELECT CONVERT(INT, hp.Salary) FROM dbo.hospital_profession hp)
	PRINT '��,  :)'
ELSE
	PRINT '���, :('

DECLARE @SALARY_SMALLEST INT = 10000;
PRINT '��� ��, �������� ����� ' + CONVERT(VARCHAR, @SALARY_SMALLEST) + '?'
IF @SALARY_SMALLEST < ALL (SELECT CONVERT(INT, hp.Salary) FROM dbo.hospital_profession hp)
	PRINT '��,  :)'
ELSE
	PRINT '���, :('

-- SELECT * FROM dbo.hospital_profession hp WHERE CONVERT(INT, hp.Salary) < 10000

-- ������ �������������� ���� � �� �������
DECLARE @TEMPERATURE INT = 36;
PRINT '� ���� ����������� ������ ' + CONVERT(VARCHAR, @TEMPERATURE) + '?'
IF @TEMPERATURE > SOME (SELECT CONVERT(INT, ph.Temperature) FROM dbo.patient_history ph)
	SELECT
		CONCAT(ppi.Second_name,' ', ppi.First_name,' ',ppi.Patronimyc_name) AS [��� ��������],
		ph.Temperature AS [�����������], 
		ph.Complaint AS [������],
		CONCAT(d.Second_name,' ',d.First_name,' ',d.Patronimyc_name) AS [��� �������]
	FROM dbo.patient_history ph
	LEFT JOIN dbo.patient_personal_info ppi ON ppi.ID = ph.Patient_personal_infoID
	LEFT JOIN dbo.doctor d ON d.ID = ph.DoctorID
	WHERE ph.Temperature > @TEMPERATURE
ELSE
	PRINT '��� �����! ���, �� �������� ���������!' 

-- ������� � ��������
SELECT 
	* 
FROM dbo.patient p, dbo.room r
WHERE p.RoomID = r.ID

SELECT * FROM dbo.room r
where r.Name like '%%'