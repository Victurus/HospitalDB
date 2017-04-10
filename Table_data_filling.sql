USE Hospitals
GO
PRINT 'REGION'
BULK INSERT dbo.region
	FROM 'C:\Users\������\Documents\SQL Server Management Studio\���� ������ �� ���� ��������\DataFillers\Region_Filler.txt'
	WITH
	(
		CODEPAGE='65001', -- ������� �������� ��� ����������� ������ ������� ��������
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n'
	)
PRINT 'HOSPITAL'
BULK INSERT dbo.hospital
	FROM 'C:\Users\������\Documents\SQL Server Management Studio\���� ������ �� ���� ��������\DataFillers\Hospital_Filler.txt'
	WITH
	(
		CODEPAGE='65001', -- ������� �������� ��� ����������� ������ ������� ��������
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n'
	)
PRINT 'OTDEL'
BULK INSERT dbo.otdel
	FROM 'C:\Users\������\Documents\SQL Server Management Studio\���� ������ �� ���� ��������\DataFillers\Otdel_Filler.txt'
	WITH
	(
		CODEPAGE='65001', -- ������� �������� ��� ����������� ������ ������� ��������
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n'
	)
PRINT 'SPECIALIZE'
BULK INSERT dbo.specialize
	FROM 'C:\Users\������\Documents\SQL Server Management Studio\���� ������ �� ���� ��������\DataFillers\Specializes_Filler.txt'
	WITH
	(
		CODEPAGE='65001', -- ������� �������� ��� ����������� ������ ������� ��������
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n'
	)
PRINT 'ROOM'
BULK INSERT dbo.room
	FROM 'C:\Users\������\Documents\SQL Server Management Studio\���� ������ �� ���� ��������\DataFillers\Room_Filler.txt'
	WITH
	(
		CODEPAGE='65001', -- ������� �������� ��� ����������� ������ ������� ��������
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n'
	)
PRINT 'HOSPITAL_PROFESSION'
BULK INSERT dbo.hospital_profession
	FROM 'C:\Users\������\Documents\SQL Server Management Studio\���� ������ �� ���� ��������\DataFillers\Hospital_profession_Filler.txt'
	WITH
	(
		CODEPAGE='65001', -- ������� �������� ��� ����������� ������ ������� ��������
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n'
	)
PRINT 'INSURANCE_ORG'
BULK INSERT dbo.insurance_org
	FROM 'C:\Users\������\Documents\SQL Server Management Studio\���� ������ �� ���� ��������\DataFillers\Insurance_org_Filler.txt'
	WITH
	(
		CODEPAGE='65001', -- ������� �������� ��� ����������� ������ ������� ��������
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n'
	)
PRINT 'DOCTOR'
BULK INSERT dbo.doctor
	FROM 'C:\Users\������\Documents\SQL Server Management Studio\���� ������ �� ���� ��������\DataFillers\Doctor_Filler.txt'
	WITH
	(
		CODEPAGE='65001', -- ������� �������� ��� ����������� ������ ������� ��������
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n'
	)
PRINT 'DOCTOR_INSURANCE_NUMBER'
BULK INSERT dbo.doctor_insurance_number
	FROM 'C:\Users\������\Documents\SQL Server Management Studio\���� ������ �� ���� ��������\DataFillers\Doctor_insurance_number_Filler.txt'
	WITH
	(
		CODEPAGE='65001', -- ������� �������� ��� ����������� ������ ������� ��������
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n'
	)
PRINT 'PATIENT_PERSONAL_INFO'
BULK INSERT dbo.patient_personal_info
	FROM 'C:\Users\������\Documents\SQL Server Management Studio\���� ������ �� ���� ��������\DataFillers\Patient_personal_info_Filler.txt'
	WITH
	(
		CODEPAGE='65001', -- ������� �������� ��� ����������� ������ ������� ��������
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n'
	)
PRINT 'PATIENT_INSURANCE_NUMBER'
BULK INSERT dbo.patient_insurance_number
	FROM 'C:\Users\������\Documents\SQL Server Management Studio\���� ������ �� ���� ��������\DataFillers\Patient_insurance_number_Filler.txt'
	WITH
	(
		CODEPAGE='65001', -- ������� �������� ��� ����������� ������ ������� ��������
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n'
	)
PRINT 'OPERATION'
BULK INSERT dbo.operation
	FROM 'C:\Users\������\Documents\SQL Server Management Studio\���� ������ �� ���� ��������\DataFillers\Operation_Filler.txt'
	WITH
	(
		CODEPAGE='65001', -- ������� �������� ��� ����������� ������ ������� ��������
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n'
	)
PRINT 'OPERATION_PATIENT'
BULK INSERT dbo.operation_patient
	FROM 'C:\Users\������\Documents\SQL Server Management Studio\���� ������ �� ���� ��������\DataFillers\Operation_patient_Filler.txt'
	WITH
	(
		CODEPAGE='65001', -- ������� �������� ��� ����������� ������ ������� ��������
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n'
	)
PRINT 'PATIENT'
BULK INSERT dbo.patient
	FROM 'C:\Users\������\Documents\SQL Server Management Studio\���� ������ �� ���� ��������\DataFillers\Patient_Filler.txt'
	WITH
	(
		CODEPAGE='65001', -- ������� �������� ��� ����������� ������ ������� ��������
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n'
	)
PRINT 'PATIENT_HISTORY'
BULK INSERT dbo.patient_history
	FROM 'C:\Users\������\Documents\SQL Server Management Studio\���� ������ �� ���� ��������\DataFillers\Patient_history_Filler.txt'
	WITH
	(
		CODEPAGE='65001', -- ������� �������� ��� ����������� ������ ������� ��������
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n'
	)