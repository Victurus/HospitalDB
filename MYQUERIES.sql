/* Helper
	SELECT - выборка данных их таблици в определённой БД в определённой схеме БД(dbo)

	SELECT * FROM [SCHEMA_NAME].[TABLE_NAME]

	запросить все атрибуты и все кортежи из таблицы

	SELECT [TABLE_ALIAS].ID, ...
	FROM [SCHEMA_NAME].[TABLE_NAME] AS [TABLE_ALIAS]

	Задание псевдонима для таблицы. Это упрощает процесс написания запроса выборки данных.
	Ключевое слово AS можно опустить.

	Можно и просто перечислять поля(если это запрос из одной таблицы)

	SELECT DISTINCT [TABLE_ALIAS].Col1, [TABLE_ALIAS].Col2, [TABLE_ALIAS].Col3
	FROM [SCHEMA_NAME].[TABLE_NAME] [TABLE_ALIAS]

	DISTINCT - означает отбрасывание строк дубликатов

	Задание псевдонимов для столбцов запроса

	SELECT 
			-- Даёмимя вычисляемому столбцу
			 Second_name + ' ' + First_name + ' ' + Patronimyc_name AS ФИО,
			-- использование двойных кавычек, так как используется пробел
			Hire_date AS "Дата приема",
			-- использование квадратных скобок, ввиду пробела
			Birthday AS [Дата рождения],
			-- слово AS не обязательно
			dbo.doctor.Insurance_individual_account_number СНИЛС
	FROM dbo.doctor 

	В данном случае в первой строке если одно из полей будет NULL то и всё будет NULL (это трёхзначная логика)
	Решение такое:

	SELECT 
		 -- как было
		Second_name + ' ' + First_name + ' ' + Patronimyc_name AS ФИО,
		-- при помощи ISNULL(поле,'если поле NULL то выведена будет эта строка')
		ISNULL(Second_name,'') + ' ' + ISNULL(First_name,'') + ' ' + ISNULL(Patronimyc_name,'') AS ФИО,
		CONCAT(Second_name, ' ', First_name, ' ', Patronimyc_name)AS ФИО
	FROM dbo.doctor

	SELECT 
		'Дата приёма'=Hire_date,  -- помимо "..." и [...] можно использовать '...'
		[Дата рождения]=Birthday,
		СНИЛС=dbo.doctor.Insurance_individual_account_number
	FROM dbo.doctor
	
	Арифметические операции те же что и в С++ приоритет, как в математике(но не забываем про 3-хзначную логику)

	Помимо функции ISNULL ещё есть функция COALESCE:

	COALESCE(expr1, expr2, expr3, ...) -- возвращает первое не NULL значение из списка значений

	Операции объединения

	Есть пять - 5, типов соединения JOIN
	1.       JOIN - левая_таблица       JOIN правая_таблица ON условия_соединения
	2. LEFT  JOIN - левая_таблица LEFT  JOIN правая_таблица ON условия_соединения
	3. RIGHT JOIN - левая_таблица RIGHT JOIN правая_таблица ON условия_соединения
	4. FULL  JOIN - левая_таблица FULL  JOIN правая_таблица ON условия_соединения
	5. CROSS JOIN - левая_таблица CROSS JOIN правая_таблица

	+-------------------------------------------------------------------------------------+
	| Краткий    | Полный       | Описание                                                |
	| синтаксис  | синтаксис    |                                                         |
	+-------------------------------------------------------------------------------------+
	| JOIN       | INNER JOIN   | Из строк левой_таблицы и правой_таблицы объединяются и  |
	|            |              | возвращаются только те строки, по которым выполняются   |
	|            |              | условия_соединения.                                     |
	+-------------------------------------------------------------------------------------+
	| LEFT JOIN  | LEFT OUTER   | Возвращаются все строки левой_таблицы(ключевое слово    |
	|            | JOIN         | LEFT). Данными правой_таблицы дополняются только те     |
	|            |              | строки левой_таблицы, для которых выполняются условия_  |
	|            |              | соединения. Для недостающих данных вместо строк правой_ |
	|            |              | таблицы втавляются NULL-значения.                       |
	+-------------------------------------------------------------------------------------+
	| RIGHT JOIN | RIGHT OUTER  | Возвращаются все строки правой_таблицы(ключевое слово   |
	|            | JOIN         | RIGHT). Данными левой_таблицы дополняются только те     |
	|            |              | строки правой_таблицы, для которых выполняются условия_ |
	|            |              | соединения. Для недостающих данных вместо строк левой_  |
	|            |              | таблицы втавляются NULL-значения.                       |
	+-------------------------------------------------------------------------------------+
	| FULL JOIN  | FULL OUTER   | Возвращаются все строки левой_таблицы и правой_таблицы. |
	|            | JOIN         | Если для строк левой_таблицы и правой_таблицы           |
	|            |              | выполняются условия_соединения, то они объединяются в   |
	|            |              | одну строку. Для строк, для которых не выполняются      |
	|            |              | условия_соединения, NULL-значения вставляются на место  |
	|            |              | левой_таблицы, либо на место правой_таблицы, в          |
	|            |              | зависимости от того данных какой таблицы в строке не    |
	|            |              | имеется.                                                |
	+-------------------------------------------------------------------------------------+
	| CROSS JOIN | -            | Объединение каждой строки левой_таблицы со всеми        |
	|            |              | строками правой_таблицы. Этот вид соединения иногда     |
	|            |              | называют декартовым произведением.                      |
	+-------------------------------------------------------------------------------------+

	Кусочек даты

	SELECT DATEPART(datepart, '2007-10-30 12:15:32.1234567 +05:10') AS [Часть даты]

	,где datepart может принимать следующие значения

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

	Связь таблиц при помощи WHERE условия

	SELECT d.ID, d.First_name, d.Mobile_number
	FROM dbo.doctor d
	WHERE DATEPART(MONTH, d.Birthday) = DATEPART(MONTH, SYSDATETIME())
		AND DATEPART(DAY, d.Birthday) = DATEPART(DAY, SYSDATETIME())

	При помощи WHERE можно писать запросы аналогичные JOIN, но из-за этого могут
	возникнуть трудности при чтении кода другим программистом, в связи с чем лучше 
	писать всё явно и однозначно.

	Операция UPDATE

	UPDATE dbo.region
	SET dbo.region.Name = UPPER(SUBSTRING(r.Name, 1, 1)) + LOWER(SUBSTRING(r.Name, 2, LEN(r.Name) - 1))
	FROM dbo.region r, inserted i 
	WHERE r.ID=i.ID

	/\/\/\/\/\ - это пример изменения данных таблицы на основе данных другой таблицы, вот так вот

	UPDATE [обновляемая таблица]
	SET [обновляемое пол(е,я)] = [значение на основании данных некой составной таблицы]
	FROM [имя таблицы(некой составной)], [может быть ещё таблица], (... может быть много таблиц)
	WHERE [УСЛОВИЕ]
*/

USE Hospitals
GO

-- Включение статистики
SET STATISTICS IO ON
SET STATISTICS TIME ON

-- Выборка всех комнат из всех больниц с их спецификациями
SELECT 
	r.Name AS [Наименование комнаты], 
	h.Name AS [Название больницы], 
	o.Name AS [Название отдела], 
	s.Name AS [Назначение комнаты],
	r.Free_beds AS [Свободные кровати]
FROM dbo.room r
     JOIN dbo.hospital h   ON h.ID=r.HospitalID
LEFT JOIN dbo.otdel o      ON o.ID=r.OtdelID
RIGHT JOIN dbo.specialize s ON s.ID=r.SpecializeID 

-- Выборка больниц с датой основания и районом
SELECT 
	h.Name AS [Название больницы], 
	h.Date_of_foundation AS [Дата основания], 
	r.Name AS [Район основания]
FROM dbo.hospital h
FULL JOIN dbo.region r ON r.ID=h.RegionID

-- Выборка докторов по фамилии Ребус
SELECT 
	CONCAT(d.Second_name,' ', d.First_name,' ',d.Patronimyc_name) AS [ФИО],
	CONCAT(SUBSTRING(d.Mobile_number, 1, 2),' ', SUBSTRING(d.Mobile_number, 3, 3),' ',SUBSTRING(d.Mobile_number, 6, 3), ' ', SUBSTRING(d.Mobile_number, 9, 2), ' ', SUBSTRING(d.Mobile_number, 11, 2)) AS [Мобильный телефон],
	CONCAT(SUBSTRING(d.Home_number, 1, 2),' - ', SUBSTRING(d.Home_number, 3, 2),' - ',SUBSTRING(d.Home_number, 5, 2)) AS [Домашний телефон],
	CONCAT(SUBSTRING(d.Additional_number, 1, 2),' ', SUBSTRING(d.Additional_number, 3, 3),' ',SUBSTRING(d.Additional_number, 6, 3), ' ', SUBSTRING(d.Additional_number, 9, 2), ' ', SUBSTRING(d.Additional_number, 11, 2)) AS [Дополнительный],
	IIF(d.Criminal_conviction = 1, 'Есть', 'Нет') AS [Судимость],
	d.Addres AS [Адрес]
FROM dbo.doctor d
WHERE d.Second_name LIKE '%Ребус%'

-- Выборка из таблицы докторов. Просмотр, у кого какой стандартный оклад. 3 вида подобного запроса
SELECT 
	CONCAT(d.Second_name,' ', d.First_name,' ',d.Patronimyc_name) AS [ФИО],
	hp.Salary AS [Заработная плата]
FROM dbo.doctor d
JOIN dbo.hospital_profession hp ON hp.ID=d.Hospital_professionID
-- Хороший, но громоздкий запрос
SELECT 
	ISNULL(d.Second_name,'') + ' ' + ISNULL(d.First_name,'') + ' ' + ISNULL(d.Patronimyc_name,'') AS [ФИО],
	hp.Salary AS [Заработная плата]
FROM dbo.doctor d
JOIN dbo.hospital_profession hp ON hp.ID=d.Hospital_professionID
-- Плохой запрос, не у всех есть, к примеру, отчество. Тогда значение этого поля 
-- будет NULL, а по правилам трёхзначной логики всё поле ФИО будет NULL.
SELECT 
	d.Second_name + ' ' + d.First_name + ' ' + d.Patronimyc_name AS [ФИО],
	hp.Salary AS [Заработная плата]
FROM dbo.doctor d
JOIN dbo.hospital_profession hp ON hp.ID=d.Hospital_professionID

-- Пересчёт сколько нужно заплатить
SELECT 
	CONCAT(d.Second_name,' ', d.First_name,' ',d.Patronimyc_name) AS [ФИО],
	hp.Salary + COALESCE(CONVERT(INT, hp.Bonus_salary), 0) AS [Полная зарплата]
FROM dbo.doctor d
RIGHT JOIN dbo.hospital_profession hp ON hp.ID=d.Hospital_professionID

-- Выборка пациентов со страховкой, с их докторами и диагнозами
SELECT 
	CONCAT(ppi.Second_name,' ', ppi.First_name,' ',ppi.Patronimyc_name) AS [ФИО пациента],
	CONCAT(d.Second_name,' ', d.First_name,' ',d.Patronimyc_name) AS [ФИО лечащего доктора],
	p.Admission_diagnosis AS [Диагноз при поступлении],
	p.Clinical_diagnosis AS  [Клинический диагноз]
FROM dbo.patient p
JOIN dbo.patient_personal_info ppi ON ppi.ID=p.Patient_personal_infoID
JOIN dbo.doctor d ON d.ID=p.DoctorID
WHERE p.Med_fear_pay=1

-- С днём рождения - поздравление в виде премии
SELECT 
	CONCAT(d.Second_name,' ', d.First_name,' ',d.Patronimyc_name) AS [ФИО],
	d.Mobile_number AS [Мобильный номер],
	10000 AS [Премия на день рождения],
	CONVERT(INT, hp.Salary) + CONVERT(INT, hp.Bonus_salary) + 10000 AS [Полная зарплата]
	FROM dbo.doctor d
	JOIN dbo.hospital_profession hp ON hp.ID=d.Hospital_professionID
	WHERE DATEPART(MONTH, d.Birthday) = DATEPART(MONTH, SYSDATETIME()) AND 
		  DATEPART(DAY, d.Birthday) = DATEPART(DAY, SYSDATETIME())     AND
		  d.Termination_date IS NOT NULL

-- Пациент операция
SELECT 
	CONCAT(ppi.Second_name,' ', ppi.First_name,' ',ppi.Patronimyc_name) AS [ФИО пациента],
	o.Name AS [Наименование операции]
FROM dbo.patient p
LEFT JOIN dbo.operation_patient op ON op.Patient_personal_infoID=p.Patient_personal_infoID
JOIN dbo.patient_personal_info ppi ON ppi.ID=p.Patient_personal_infoID
JOIN dbo.operation o ON o.ID=op.ID

SELECT 
	UPPER(SUBSTRING(s.Name, 1, 1)) + SUBSTRING(s.Name, 2, LEN(s.Name) - 1) AS [Специализация]
FROM dbo.specialize s

SELECT 
	CONCAT(d.Second_name,' ', d.First_name,' ',d.Patronimyc_name) AS [ФИО]
FROM dbo.doctor d 
WHERE DATEPART(YEAR, d.Birthday) > 1970

SELECT 
	CONCAT(d.Second_name,' ', d.First_name,' ',d.Patronimyc_name) AS [ФИО]
FROM dbo.doctor d
WHERE EXISTS (SELECT * FROM dbo.patient_personal_info ppi WHERE ppi.ID=d.ID)

-- Возможная пермия за стаж, в зависимости от того, как год прошол
SELECT
	d.ID,
	CONCAT(d.Second_name,' ', d.First_name,' ',d.Patronimyc_name) AS [ФИО доктора],
	hp.Name AS [Наименование профессии],
	hp.Salary AS [Исходная зарплата],
	CASE
		WHEN d.Experience > 5  THEN 5000
		WHEN d.Experience > 10 THEN 10000
		WHEN d.Experience > 15 THEN 15000
		ELSE 0
	END [Премия за стаж],
	hp.Bonus_salary AS [Обычная премия],
	CONVERT(INT, hp.Salary) + CONVERT(INT, hp.Bonus_salary) + 
	CASE
		WHEN d.Experience > 5  THEN 5000
		WHEN d.Experience > 10 THEN 10000
		WHEN d.Experience > 15 THEN 15000
		ELSE 0
	END [Полная заработная плата]
FROM dbo.doctor d LEFT JOIN dbo.hospital_profession hp ON d.Hospital_professionID = hp.ID
WHERE d.Termination_date IS NOT NULL
ORDER BY 
	[Полная заработная плата]

-- Это примеры LEFT JOIN и WHERE реализаций одного и того же запроса
SELECT 
	d.ID, 
	CONCAT(d.Second_name,' ', d.First_name,' ',d.Patronimyc_name) AS [ФИО доктора],
	hp.ID AS [id профессии],
	d.Hospital_professionID
FROM dbo.doctor d LEFT JOIN dbo.hospital_profession hp ON d.Hospital_professionID=hp.ID
ORDER BY 
	d.ID 

SELECT 
	d.ID, 
	CONCAT(d.Second_name,' ', d.First_name,' ',d.Patronimyc_name) AS [ФИО доктора],
	hp.ID AS [id профессии],
	d.Hospital_professionID
FROM dbo.doctor d, dbo.hospital_profession hp 
WHERE d.Hospital_professionID=hp.ID

-- Просмотр пациентов у которых высокая температура
SELECT 
	CONCAT(ppi.Second_name,' ', ppi.First_name,' ',ppi.Patronimyc_name) AS [ФИО],
	ph.Temperature AS [Температура],
	ph.Preasure AS [Давление],
	ph.Visit_day AS [День осмотра],
	ph.Complaint AS [Жалобы]
FROM dbo.patient p LEFT JOIN dbo.patient_personal_info ppi ON p.Patient_personal_infoID=ppi.ID
	 LEFT JOIN dbo.patient_history ph ON ph.Patient_personal_infoID=ppi.ID
GROUP BY ph.ID,ppi.Second_name,ppi.First_name,ppi.Patronimyc_name,ph.Temperature, ph.Preasure, ph.Complaint, ph.Visit_day
HAVING CONVERT(INT, ph.Temperature) > 36

SELECT 
	SUM(CONVERT(INT, hp.Salary) + CONVERT(INT, hp.Bonus_salary)) AS [На опладу зарплаты сотрудникам необходимо выделить]
FROM dbo.doctor d LEFT JOIN dbo.hospital_profession hp ON d.Hospital_professionID=hp.ID

-- Выборка докторов у которых есть пациенты
SELECT 
	CONCAT(d.Second_name,' ', d.First_name,' ',d.Patronimyc_name) AS [ФИО доктора],
	d.Mobile_number AS [Мобильный телефон]
FROM dbo.doctor d
WHERE EXISTS(SELECT * FROM dbo.patient p WHERE d.ID=p.DoctorID)

-- Посмотрим у кого из врачей имеется судимость
SELECT 
	CONCAT(d.Second_name,' ', d.First_name,' ',d.Patronimyc_name) AS [ФИО доктора],
	d.Addres AS [Адрес],
	IIF(d.Criminal_conviction=1, 'Есть', 'Нет') AS [Судимость]
FROM dbo.doctor d

-- У кого из пациентов есть страховка
SELECT 
	CONCAT(ppi.Second_name,' ', ppi.First_name,' ',ppi.Patronimyc_name) AS [ФИО пациента],
	ppi.Addres AS [Адрес],
	IIF(ppi.Criminal_conviction=1, 'Есть', 'Нет') AS [Судимость],
	IIF(p.Med_fear_pay=1, 'Да', 'Нет') AS [Мед страх платит?],
	IIF(ppi.Criminal_conviction=1 AND p.Med_fear_pay=1, 'Везде успел', 'Надеюсь не судим') AS [Особое мнение]
FROM dbo.patient_personal_info ppi RIGHT JOIN dbo.patient p ON p.Patient_personal_infoID=ppi.ID

-- вложенный запрос
-- получить список всех пациентов всех "Нормальных" регионов, у которых есть врачи и страховка
SELECT 
	CONCAT(ppi.Second_name,' ', ppi.First_name,' ',ppi.Patronimyc_name) AS [ФИО пациента],
	ppi.Mobile_number AS [Мобильный номер],
	ppi.Taxpayer_id_number AS [ИНН],
	p.DoctorID 
FROM dbo.patient p 
LEFT JOIN dbo.patient_personal_info ppi ON ppi.ID = p.Patient_personal_infoID
WHERE 
p.DoctorID IN (SELECT d.ID FROM dbo.doctor d) AND 
p.Med_fear_pay = 1                            AND
p.RoomID IN (SELECT r.ID FROM dbo.room r WHERE r.HospitalID IN 
			(SELECT h.ID FROM dbo.hospital h WHERE h.RegionID IN 
			(SELECT r.ID FROM dbo.region r WHERE r.Name LIKE '%Нормальный%')))
								  

-- все люди находящиеся в данный момент в больнице, и кто они
SELECT 
	CONCAT(d.Second_name,' ',d.First_name,' ',d.Patronimyc_name) AS [ФИО], 
	d.Mobile_number AS [МОБИЛЬНЫЙ ТЕЛЕФОН], 
	IIF(1 = 1, 'ДОКТОР', 'ПАЦИЕНТ') AS [КТО] 
FROM dbo.doctor d 
UNION -- ВОТ ОН ЮНИОН -- !!!
SELECT 
	CONCAT(ppi.Second_name,' ',ppi.First_name,' ',ppi.Patronimyc_name) AS [ФИО], 
	ppi.Mobile_number AS [МОБИЛЬНЫЙ ТЕЛЕФОН], 
	IIF(1 = 0, 'ДОКТОР', 'ПАЦИЕНТ') AS [КТО] 
	FROM dbo.patient_personal_info ppi
ORDER BY [ФИО]
GO

-- порог зарплат
DECLARE @SALARY INT = 70000;
PRINT 'Есть те кто, получает более ' + CONVERT(VARCHAR, @SALARY) + '?'
IF @SALARY < SOME (SELECT CONVERT(INT, hp.Salary) FROM dbo.hospital_profession hp)
	PRINT 'Да,  :)'
ELSE
	PRINT 'Нет, :('

DECLARE @SALARY_SMALLEST INT = 10000;
PRINT 'Все ли, получают более ' + CONVERT(VARCHAR, @SALARY_SMALLEST) + '?'
IF @SALARY_SMALLEST < ALL (SELECT CONVERT(INT, hp.Salary) FROM dbo.hospital_profession hp)
	PRINT 'Да,  :)'
ELSE
	PRINT 'Нет, :('

-- SELECT * FROM dbo.hospital_profession hp WHERE CONVERT(INT, hp.Salary) < 10000

-- сильно температурящие люди и их доктора
DECLARE @TEMPERATURE INT = 36;
PRINT 'У кого температура больше ' + CONVERT(VARCHAR, @TEMPERATURE) + '?'
IF @TEMPERATURE > SOME (SELECT CONVERT(INT, ph.Temperature) FROM dbo.patient_history ph)
	SELECT
		CONCAT(ppi.Second_name,' ', ppi.First_name,' ',ppi.Patronimyc_name) AS [ФИО пациента],
		ph.Temperature AS [Температура], 
		ph.Complaint AS [Жалобы],
		CONCAT(d.Second_name,' ',d.First_name,' ',d.Patronimyc_name) AS [ФИО доктора]
	FROM dbo.patient_history ph
	LEFT JOIN dbo.patient_personal_info ppi ON ppi.ID = ph.Patient_personal_infoID
	LEFT JOIN dbo.doctor d ON d.ID = ph.DoctorID
	WHERE ph.Temperature > @TEMPERATURE
ELSE
	PRINT 'Нет таких! Ура, на нурафене сыкономим!' 

-- больные в комнатах
SELECT 
	* 
FROM dbo.patient p, dbo.room r
WHERE p.RoomID = r.ID

SELECT * FROM dbo.room r
where r.Name like '%%'