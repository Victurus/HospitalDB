/* Примечание по созданию индексов
CREATE INDEX IDX_Employees_Name ON Employees(Name)
CREATE UNIQUE NONCLUSTERED INDEX UQ_Employees_EmailDesc ON Employees(Email DESC)

## Упощённое создание индекса ##

CREATE [ UNIQUE ] [ CLUSTERED | NONCLUSTERED ] INDEX index_name   
    ON <object> ( column [ ASC | DESC ] [ ,...n ] )   
    [ INCLUDE ( column_name [ ,...n ] ) ]  
    [ WHERE <filter_predicate> ]  [ ; ]
 
<object> ::=  
{  
    [ database_name. [ schema_name ] . | schema_name. ]   
    table_or_view_name  
}  
*/
USE Hospitals
GO
/*
  Список таблиц
  dbo.region
  dbo.hospital
  dbo.otdel
  dbo.specialize
  dbo.room
  dbo.hospital_profession
  dbo.insurance_org
  dbo.doctor
  dbo.doctor_insurance_number
  dbo.patient_personal_info
  dbo.patient_insurance_number
  dbo.operation
  dbo.operation_patient
  dbo.patient
  dbo.patient_history

  Как изменять ограничения
  ALTER TABLE dbo.doctor DROP CONSTRAINT PK_doctor
  ALTER TABLE dbo.doctor ADD CONSTRAINT PK_doctor PRIMARY KEY NONCLUSTERED (ID)
*/

CREATE NONCLUSTERED INDEX IDX_roomID
ON dbo.room (HospitalID, ID)
INCLUDE (Name,OtdelID,SpecializeID, Free_beds)
GO

DROP INDEX IDX_roomID
ON dbo.room
GO

CREATE NONCLUSTERED INDEX IDX_hospital
ON dbo.hospital(Name, RegionID)
INCLUDE(Date_of_foundation)

DROP INDEX IDX_hospital
ON dbo.hospital

CREATE CLUSTERED INDEX IDX_fio_c 
ON dbo.doctor(Second_name, First_name, Patronimyc_name)

DROP INDEX IDX_fio_c
ON dbo.doctor
GO

CREATE NONCLUSTERED INDEX IDX_fio_nc
ON dbo.doctor(Hospital_professionID, Termination_date)
INCLUDE (Mobile_number, First_name, Second_name, Patronimyc_name)
WHERE Termination_date IS NOT NULL;
GO

DROP INDEX IDX_fio_nc
ON dbo.doctor
GO

CREATE NONCLUSTERED INDEX IDX_fio_nc_other
ON dbo.doctor(Hospital_professionID, Termination_date)
INCLUDE (ID,First_name, Second_name, Patronimyc_name, Experience)
WHERE Termination_date IS NOT NULL;
GO

DROP INDEX IDX_fio_nc_other
ON dbo.doctor
GO

CREATE CLUSTERED INDEX IDX_fio 
ON dbo.patient_personal_info(Second_name, First_name, Patronimyc_name)
GO

DROP INDEX IDX_fio
ON dbo.patient_personal_info
GO

CREATE UNIQUE NONCLUSTERED INDEX IDX_patient
ON dbo.patient(OtdelID, DoctorID, Patient_personal_infoID, RoomID)
INCLUDE (Day_of_entry, Day_of_discharge, Admission_diagnosis, Clinical_diagnosis, Med_fear_pay)
WHERE Med_fear_pay = 1
GO

DROP INDEX IDX_patient
ON dbo.patient
GO

CREATE UNIQUE NONCLUSTERED INDEX IDX_Taxpayer_id_number
ON dbo.doctor(Taxpayer_id_number)
INCLUDE(Second_name, First_name, Patronimyc_name, Mobile_number)

DROP INDEX IDX_Taxpayer_id_number
ON dbo.doctor
GO

CREATE NONCLUSTERED INDEX IDX_patient_piID 
ON dbo.operation_patient(Patient_personal_infoID)
GO

DROP INDEX IDX_patient_piID
ON dbo.operation_patient
GO

CREATE NONCLUSTERED INDEX IDX_patient_piID 
ON dbo.patient_history(Patient_personal_infoID,DoctorID, Temperature)
INCLUDE(Complaint)
GO

DROP INDEX IDX_patient_piID
ON dbo.patient_history
GO

CREATE UNIQUE NONCLUSTERED INDEX IDX_patient_other
ON dbo.patient(OtdelID, DoctorID, Patient_personal_infoID, RoomID)
INCLUDE (Day_of_entry, Day_of_discharge, Admission_diagnosis, Clinical_diagnosis, Med_fear_pay)
GO

DROP INDEX IDX_patient_other
ON dbo.patient