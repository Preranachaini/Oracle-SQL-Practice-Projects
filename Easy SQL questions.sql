SELECT * FROM patients;

select first_name, last_name, weight from patients where weight = (select min(weight) from patients);

select max(weight) from patients;

select count(*) from patients where gender = 'M' ;

select first_name, last_name, birth_date from patients where birth_date = '1981-05-28';

select a.patient_id, a.first_name, a.last_name, b.attending_doctor_id, c.first_name, c.last_name from patients a 
join admissions b on a.patient_id = b.patient_id
join doctors c on b.attending_doctor_id = c.doctor_id
where b.diagnosis = 'Headache';



----Show first name, last name, and gender of patients whose gender is 'M'
select first_name, last_name, gender from patients where gender ='M';

-- Show first name and last name of patients who does not have allergies. (null)
select first_name, last_name from patients where allergies is null;

-- Show first name of patients that start with the letter 'C'
select first_name from patients where first_name like 'C%';

-- Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
select first_name, last_name from patients where weight between 100 and 120;

--Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
update patients 
set allergies = 'NKA'
where allergies is null;

--Show first name and last name concatinated into one column to show their full name.
select concat(first_name,' ',last_name) patient_name from patients;

--Show first name, last name, and the full province name of each patient.
-- Example: 'Ontario' instead of 'ON'
select a.first_name, a.last_name, b.province_name from patients a , province_names b
where a.province_id = b.province_id;

-- Show how many patients have a birth_date with 2010 as the birth year.
select	count(*) total_patienst from patients where year(birth_date) = 2010;

-- Show the first_name, last_name, and height of the patient with the greatest height.
select first_name, last_name, height from patients where height = (select(max(height)) from patients);

-- Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000
select * from patients where patient_id in (1,45,534,879,1000);

--Show the total number of admissions
select count(*) from admissions;

-- Show all the columns from admissions where the patient was admitted and discharged on the same day.
select * from admissions where admission_date = discharge_date;

-- Show the patient id and the total number of admissions for patient_id 579.
select count(*) count_P, a.patient_id from patients a, admissions b where a.patient_id = b.patient_id and b.patient_id = 579;


