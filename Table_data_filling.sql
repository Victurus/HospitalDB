USE Hospitals
GO
PRINT 'REGION'
BULK INSERT dbo.region
	FROM 'C:\Users\������\Documents\SQL Server Management Studio\HospitalDB\DataFillers\Region_Filler.txt'
	WITH
	(
		CODEPAGE='65001', -- ������� �������� ��� ����������� ������ ������� ��������
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '
'
	)
PRINT 'HOSPITAL'
BULK INSERT dbo.hospital
	FROM 'C:\Users\������\Documents\SQL Server Management Studio\HospitalDB\DataFillers\Hospital_Filler.txt'
	WITH
	(
		CODEPAGE='65001', -- ������� �������� ��� ����������� ������ ������� ��������
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '
'
	)
PRINT 'OTDEL'
BULK INSERT dbo.otdel
	FROM 'C:\Users\������\Documents\SQL Server Management Studio\HospitalDB\DataFillers\Otdel_Filler.txt'
	WITH
	(
		CODEPAGE='65001', -- ������� �������� ��� ����������� ������ ������� ��������
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '
'
	)
PRINT 'SPECIALIZE'
BULK INSERT dbo.specialize
	FROM 'C:\Users\������\Documents\SQL Server Management Studio\HospitalDB\DataFillers\Specializes_Filler.txt'
	WITH
	(
		CODEPAGE='65001', -- ������� �������� ��� ����������� ������ ������� ��������
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '
'
	)
PRINT 'ROOM'
BULK INSERT dbo.room
	FROM 'C:\Users\������\Documents\SQL Server Management Studio\HospitalDB\DataFillers\Room_Filler.txt'
	WITH
	(
		CODEPAGE='65001', -- ������� �������� ��� ����������� ������ ������� ��������
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '
'
	)
PRINT 'HOSPITAL_PROFESSION'
BULK INSERT dbo.hospital_profession
	FROM 'C:\Users\������\Documents\SQL Server Management Studio\HospitalDB\DataFillers\Hospital_profession_Filler.txt'
	WITH
	(
		CODEPAGE='65001', -- ������� �������� ��� ����������� ������ ������� ��������
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '
'
	)
PRINT 'INSURANCE_ORG'
BULK INSERT dbo.insurance_org
	FROM 'C:\Users\������\Documents\SQL Server Management Studio\HospitalDB\DataFillers\Insurance_org_Filler.txt'
	WITH
	(
		CODEPAGE='65001', -- ������� �������� ��� ����������� ������ ������� ��������
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '
'
	)
PRINT 'DOCTOR'
BULK INSERT dbo.doctor
	FROM 'C:\Users\������\Documents\SQL Server Management Studio\HospitalDB\DataFillers\Doctor_Filler.txt'
	WITH
	(
		CODEPAGE='65001', -- ������� �������� ��� ����������� ������ ������� ��������
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '
'
	)
PRINT 'DOCTOR_INSURANCE_NUMBER'
BULK INSERT dbo.doctor_insurance_number
	FROM 'C:\Users\������\Documents\SQL Server Management Studio\HospitalDB\DataFillers\Doctor_insurance_number_Filler.txt'
	WITH
	(
		CODEPAGE='65001', -- ������� �������� ��� ����������� ������ ������� ��������
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '
'
	)
PRINT 'PATIENT_PERSONAL_INFO'
BULK INSERT dbo.patient_personal_info
	FROM 'C:\Users\������\Documents\SQL Server Management Studio\HospitalDB\DataFillers\Patient_personal_info_Filler.txt'
	WITH
	(
		CODEPAGE='65001', -- ������� �������� ��� ����������� ������ ������� ��������
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '
'
	)
PRINT 'PATIENT_INSURANCE_NUMBER'
BULK INSERT dbo.patient_insurance_number
	FROM 'C:\Users\������\Documents\SQL Server Management Studio\HospitalDB\DataFillers\Patient_insurance_number_Filler.txt'
	WITH
	(
		CODEPAGE='65001', -- ������� �������� ��� ����������� ������ ������� ��������
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '
'
	)
PRINT 'OPERATION'
BULK INSERT dbo.operation
	FROM 'C:\Users\������\Documents\SQL Server Management Studio\HospitalDB\DataFillers\Operation_Filler.txt'
	WITH
	(
		CODEPAGE='65001', -- ������� �������� ��� ����������� ������ ������� ��������
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '
'
	)
PRINT 'OPERATION_PATIENT'
BULK INSERT dbo.operation_patient
	FROM 'C:\Users\������\Documents\SQL Server Management Studio\HospitalDB\DataFillers\Operation_patient_Filler.txt'
	WITH
	(
		CODEPAGE='65001', -- ������� �������� ��� ����������� ������ ������� ��������
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '
'
	)
PRINT 'PATIENT'
BULK INSERT dbo.patient
	FROM 'C:\Users\������\Documents\SQL Server Management Studio\HospitalDB\DataFillers\Patient_Filler.txt'
	WITH
	(
		CODEPAGE='65001', -- ������� �������� ��� ����������� ������ ������� ��������
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '
'
	)
PRINT 'PATIENT_HISTORY'
BULK INSERT dbo.patient_history
	FROM 'C:\Users\������\Documents\SQL Server Management Studio\HospitalDB\DataFillers\Patient_history_Filler.txt'
	WITH
	(
		CODEPAGE='65001', -- ������� �������� ��� ����������� ������ ������� ��������
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '
'
	)