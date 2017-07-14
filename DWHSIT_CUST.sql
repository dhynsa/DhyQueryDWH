alter session set current_schema = DWH_CORE;

  --PERSON
    --1. type_code should not blank (need to confirm with mahesh whether this field is used on person table or not since this column doesnt exist on mapping)
select * from person where type_code = ' '

    --2. party_id should not blank
select * from person where party_id = ''

    --3. party_id should link with table Party
select ps.*
from person ps, party p
where ps.party_id = p.party_id

    --4. long_name should not blank
select * from person where long_name = ' '
--RESULT: 1 display blank







    --5. bus_code should not blank
select * from person where bus_code = ' '

    --6. gender_cd should 'MALE' OR 'FEMALE'
select distinct gender_cd from person
select * from person where gender_cd = ' '
--RESULT: Display (null), M, Unidentified, F, ' '

    --7. start_date should not blank
select * from person where to_char (start_date, 'DD-MON-YYYY') = ' '

    --8. end_date should not blank
select * from person where to_char (end_date, 'DD-MON-YYYY') = ' '    
    
    --9. random check with OPUS data for first_name, middle_name, last_name, long_name, dob,  gender_cd, marital_sts_cd, religion_cd, before_title, after_title, nationality_cd, birth_place and bus_code
select first_name, middle_name, last_name, long_name, dob, gender_cd, marital_sts_cd, religion_cd, before_title, after_title, nationality_cd, birth_place, bus_code from person
where bus_code IN
(
'254',
'255',
'256',
'257',
'258',
'259',
'260',
'261',
'262',
'263')
--RESULT: DUPLICATE?

  --PERSON_DETAIL
    --1. party_id should link with party table and the PARTY.type_code should 'PERS'
select pd.*
from person_detail pd, party p
where pd.party_id = p.party_id
and p.type_code = 'PERS';

    --2. all person_id should link with person table (the row count should be same for each source_sys_cd) 
select pd.*
from person_detail pd, person ps
where pd.person_id = ps.person_id

    --3. the party_id on person_detail should be same with party_id on person table for each person_id
select pd.*
from person_detail pd, person ps
where pd.person_id = ps.person_id
    
    --4. end_date should not blank
select * from person_detail where to_char (end_date, 'DD-MON-YYYY') = ' '

    --5. start_date should not blank 
select * from person_detail where to_char (start_date, 'DD-MON-YYYY') = ' '    

    --6. random check with opus data for occup_cd, height, weight, and smoker_flag
select occup_cd, height, weight, smoker_flag from person_detail pd
INNER JOIN person ps
on pd.person_id = ps.person_id
where ps.type_code = 'PERS'

  select occup_cd, height, weight, smoker_flag from person_detail 
  where bus_code IN
  (
'2295',
'2296',
'2297',
'2298',
'2299',
'2300',
'2301',
'2302',
'2303',
'2304');
  
  
  