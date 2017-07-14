Alter session set current_schema = DWH_CORE;

--20 Sales Hierarchy
  --SEQ1.PARTY
    --No need to check
--PARTY for NSH
Select * from Party;
select distinct source_sys_cd from party;
select * from party where source_sys_cd = '20_SALES_HIERARCHY.NSH';

select * from party where source_sys_cd = '20_SALES_HIERARCHY.RSM';

select * from party where source_sys_cd = '20_SALES_HIERARCHY.ASM';

  
  --SEQ2.PERSON
select * from person;

    --Sine we are not testing PARTY, make sure any query for the person has party also to check if the party_id exists in Party table.
    --1. Check the count of distinct active NSH matches with the source for August and Dec
select pn.* 
  from person pn, party p
 where pn.party_id = p.party_id
   and p.source_sys_cd = '20_SALES_HIERARCHY.NSH'
   and pn.start_date >= to_date('01-AUG-2016', 'DD-MON-YYYY')
   and pn.end_date <= to_date('31-AUG-2016', 'DD-MON-YYYY');

select pn.* 
  from person pn, party p
 where pn.party_id = p.party_id
   and p.source_sys_cd = '20_SALES_HIERARCHY.NSH'
   and pn.start_date >= to_date('01-DEC-2016', 'DD-MON-YYYY')
   and pn.end_date <= to_date('31-DEC-2016', 'DD-MON-YYYY');
   
select count(1)
  from person pn, party p
 where pn.party_id = p.party_id
   and p.source_sys_cd = '20_SALES_HIERARCHY.NSH'   
--RESULT: 9 for general

    --2. Check the count of distinct active RSM matches with the source for August and Dec
select pn.* 
  from person pn, party p
 where pn.party_id = p.party_id
   and p.source_sys_cd = '20_SALES_HIERARCHY.RSM'
   and pn.start_date >= to_date('01-AUG-2016', 'DD-MON-YYYY')
   and pn.end_date <= to_date('31-AUG-2016', 'DD-MON-YYYY');

select pn.* 
  from person pn, party p
 where pn.party_id = p.party_id
   and p.source_sys_cd = '20_SALES_HIERARCHY.RSM'
   and pn.start_date >= to_date('01-DEC-2016', 'DD-MON-YYYY')
   and pn.end_date <= to_date('31-DEC-2016', 'DD-MON-YYYY');

 
select count(1)
  from person pn, party p
 where pn.party_id = p.party_id
   and p.source_sys_cd = '20_SALES_HIERARCHY.RSM'  
--RESULT: 16 for general

    --3. Check the count of distince active ASM matches with the source for August and Dec
select pn.* 
  from person pn, party p
 where pn.party_id = p.party_id
   and p.source_sys_cd = '20_SALES_HIERARCHY.ASM'
   and pn.start_date >= to_date('01-AUG-2016', 'DD-MON-YYYY')
   and pn.end_date <= to_date('31-AUG-2016', 'DD-MON-YYYY');

select pn.* 
  from person pn, party p
 where pn.party_id = p.party_id
   and p.source_sys_cd = '20_SALES_HIERARCHY.ASM'
   and pn.start_date >= to_date('01-DEC-2016', 'DD-MON-YYYY')
   and pn.end_date <= to_date('31-DEC-2016', 'DD-MON-YYYY');

select count(1)
  from person pn, party p
 where pn.party_id = p.party_id
   and p.source_sys_cd = '20_SALES_HIERARCHY.ASM'  
--RESULT: 26 for general

    --4. For each of the above, check first 10 NSH, RSM, ASM and see if it matches with source.
select pn.* 
  from person pn, party p
 where pn.party_id = p.party_id
 and p.source_sys_cd IN ('20_SALES_HIERARCHY.NSH', '20_SALES_HIERARCHY.RSM', '20_SALES_HIERARCHY.ASM')
 and p.bus_code IN (
 'DINI ARDYA LINDA HAPZARI', 
 'IRMA SUSILAWATI SP', 
 'AMBAR RETNADI', 
 'CUT SYAFRINA', 
 'I MADE GEMARINANTA', 
 'WILLY FERNANDEZ ZEBUA', 
 'FRISKA ARINANDA DERIK WARDANI', 
 'HIMAWAN WIBISONO PHILIPUS',--
 'INTAN AMBARSARI', 
 'ANDAR YURARSO', 
 'DEWI TRESNASARI',--
 'DIAH SUHANDINI',
 'SUCI MILA SARI',
 'APRIYADI',
 'SUSILAWATI',
 'SUSILAWATY');


    --5. If August and Dec have different NSH/RSM/ASM, see the the data matches with the source.
--RESULT: Empty display for this month on last year.

  
  --SEQ3.PARTY_RLSHIP
    --1. Check the count of the ACTIVE records the relation between branch code and NSH matches with the source for August and Dec
SELECT r.*
 from party_rlship r, party c, party sch  
 where r.left_party_id = c.party_id
   and r.right_party_id = sch.party_id
   and c.source_sys_cd = 'OPIL.AZLI_DMT_ORG_UNITS'
   and sch.source_sys_cd = '20_SALES_HIERARCHY.NSH'
   and r.start_date >= to_date('01-AUG-2016', 'DD-MON-YYYY')
   and r.end_date <= to_date('31-AUG-2016', 'DD-MON-YYYY');
   
SELECT r.*
 from party_rlship r, party c, party sch  
 where r.left_party_id = c.party_id
   and r.right_party_id = sch.party_id
   and c.source_sys_cd = 'OPIL.AZLI_DMT_ORG_UNITS'
   and sch.source_sys_cd = '20_SALES_HIERARCHY.NSH'
   and r.start_date >= to_date('01-DEC-2016', 'DD-MON-YYYY')
   and r.end_date <= to_date('31-DEC-2016', 'DD-MON-YYYY');

SELECT COUNT(1)
 from party_rlship r, party c, party sch  
 where r.left_party_id = c.party_id
   and r.right_party_id = sch.party_id
   and c.source_sys_cd = 'OPIL.AZLI_DMT_ORG_UNITS'
   and sch.source_sys_cd = '20_SALES_HIERARCHY.NSH'
--RESULT:952

    --2. Check the count of the ACTIVE records the relation between branch code and RSM matches with the source for August and Dec
SELECT r.*
 from party_rlship r, party c, party sch  
 where r.left_party_id = c.party_id
   and r.right_party_id = sch.party_id
   and c.source_sys_cd = 'OPIL.AZLI_DMT_ORG_UNITS'
   and sch.source_sys_cd = '20_SALES_HIERARCHY.RSM'
   and r.start_date >= to_date('01-AUG-2016', 'DD-MON-YYYY')
   and r.end_date <= to_date('31-AUG-2016', 'DD-MON-YYYY');
   
SELECT r.*
 from party_rlship r, party c, party sch  
 where r.left_party_id = c.party_id
   and r.right_party_id = sch.party_id
   and c.source_sys_cd = 'OPIL.AZLI_DMT_ORG_UNITS'
   and sch.source_sys_cd = '20_SALES_HIERARCHY.RSM'
   and r.start_date >= to_date('01-DEC-2016', 'DD-MON-YYYY')
   and r.end_date <= to_date('31-DEC-2016', 'DD-MON-YYYY');

SELECT COUNT(1)
 from party_rlship r, party c, party sch  
 where r.left_party_id = c.party_id
   and r.right_party_id = sch.party_id
   and c.source_sys_cd = 'OPIL.AZLI_DMT_ORG_UNITS'
   and sch.source_sys_cd = '20_SALES_HIERARCHY.RSM'
--RESULT:999    

    --3. Check the count of the ACTIVE records the relation between branch code and ASM matches with the source for August and Dec
SELECT r.*
 from party_rlship r, party c, party sch  
 where r.left_party_id = c.party_id
   and r.right_party_id = sch.party_id
   and c.source_sys_cd = 'OPIL.AZLI_DMT_ORG_UNITS'
   and sch.source_sys_cd = '20_SALES_HIERARCHY.ASM'
   and r.start_date >= to_date('01-AUG-2016', 'DD-MON-YYYY')
   and r.end_date <= to_date('31-AUG-2016', 'DD-MON-YYYY');
   
SELECT r.*
 from party_rlship r, party c, party sch  
 where r.left_party_id = c.party_id
   and r.right_party_id = sch.party_id
   and c.source_sys_cd = 'OPIL.AZLI_DMT_ORG_UNITS'
   and sch.source_sys_cd = '20_SALES_HIERARCHY.ASM'
   and r.start_date >= to_date('01-DEC-2016', 'DD-MON-YYYY')
   and r.end_date <= to_date('31-DEC-2016', 'DD-MON-YYYY');

SELECT COUNT(1)
 from party_rlship r, party c, party sch  
 where r.left_party_id = c.party_id
   and r.right_party_id = sch.party_id
   and c.source_sys_cd = 'OPIL.AZLI_DMT_ORG_UNITS'
   and sch.source_sys_cd = '20_SALES_HIERARCHY.ASM'
--RESULT:779

    --4. match 10 records for each of the above.
SELECT r.*
 from party_rlship r, party c, party sch  
 where r.left_party_id = c.party_id
   and r.right_party_id = sch.party_id
   and c.source_sys_cd = 'OPIL.AZLI_DMT_ORG_UNITS'
   and sch.source_sys_cd IN ('20_SALES_HIERARCHY.NSH', '20_SALES_HIERARCHY.RSM', '20_SALES_HIERARCHY.ASM')
   and sch.bus_code IN (
 'DINI ARDYA LINDA HAPZARI', 
 'IRMA SUSILAWATI SP', 
 'AMBAR RETNADI', 
 'CUT SYAFRINA', 
 'I MADE GEMARINANTA', 
 'WILLY FERNANDEZ ZEBUA', 
 'FRISKA ARINANDA DERIK WARDANI', 
 'HIMAWAN WIBISONO PHILIPUS',--
 'INTAN AMBARSARI', 
 'ANDAR YURARSO', 
 'DEWI TRESNASARI',--
 'DIAH SUHANDINI',
 'SUCI MILA SARI',
 'APRIYADI',
 'SUSILAWATI',
 'SUSILAWATY');
    
  --SEQ4.GEOLOCATION
    --No need to check
select * from GEOLOCATION where type_code = 'BANCAGEO';
select distinct source_sys_cd from GEOLOCATION
select * from GEOLOCATION where source_sys_cd = '20_SALES_HIERARCHY.AREA'

select * from GEOLOCATION where source_sys_cd = '20_SALES_HIERARCHY.REGION'
    
  --SEQ5.COMPANYGEO
select * from COMPANYGEO
    --Sine we are not testing GEOLOCATION, make sure any query for the person has party also to check if the geo_loc_id exists in Geolocation table.
    --1. Check the count of distinct active NSH matches with the source for August and Dec
SELECT cg.*
 from COMPANYGEO cg, GEOLOCATION g  
 where cg.geo_loc_id = g.geo_loc_id
   and g.source_sys_cd = '20_SALES_HIERARCHY.AREA'
   and cg.start_date >= to_date('01-AUG-2016', 'DD-MON-YYYY')
   and cg.end_date <= to_date('31-AUG-2016', 'DD-MON-YYYY');
   
SELECT cg.*
 from COMPANYGEO cg, GEOLOCATION g  
 where cg.geo_loc_id = g.geo_loc_id
   and g.source_sys_cd = '20_SALES_HIERARCHY.AREA'
   and cg.start_date >= to_date('01-DEC-2016', 'DD-MON-YYYY')
   and cg.end_date <= to_date('31-DEC-2016', 'DD-MON-YYYY');
   
SELECT COUNT(1)
 from COMPANYGEO cg, GEOLOCATION g  
 where cg.geo_loc_id = g.geo_loc_id
   and g.source_sys_cd = '20_SALES_HIERARCHY.AREA'
--RESULT:96

    --2. Check the count of distinct active RSM matches with the source for August and Dec
SELECT cg.*
 from COMPANYGEO cg, GEOLOCATION g  
 where cg.geo_loc_id = g.geo_loc_id
   and g.source_sys_cd = '20_SALES_HIERARCHY.REGION'
   and cg.start_date >= to_date('01-AUG-2016', 'DD-MON-YYYY')
   and cg.end_date <= to_date('31-AUG-2016', 'DD-MON-YYYY');
   
SELECT cg.*
 from COMPANYGEO cg, GEOLOCATION g  
 where cg.geo_loc_id = g.geo_loc_id
   and g.source_sys_cd = '20_SALES_HIERARCHY.REGION'
   and cg.start_date >= to_date('01-DEC-2016', 'DD-MON-YYYY')
   and cg.end_date <= to_date('31-DEC-2016', 'DD-MON-YYYY');
   
SELECT COUNT(1)
 from COMPANYGEO cg, GEOLOCATION g  
 where cg.geo_loc_id = g.geo_loc_id
   and g.source_sys_cd = '20_SALES_HIERARCHY.REGION'
--RESULT:27

    --3. Check the count of distince active ASM matches with the source for August and Dec
    --4. For each of the above, check first 10 NSH, RSM, ASM and see if it matches with source.
    --5. If August and Dec have different NSH/RSM/ASM, see the the data matches with the source.
  
  --SEQ6.GEOLOC_PARTY_RLSHIP
select * from geoloc_party_rlship
    --1. Check the count of the ACTIVE records the relation between branch code and Region matches with the source for August and Dec
SELECT r.*
 from geoloc_party_rlship r, party c, geolocation sch  
 where r.party_id = c.party_id
   and r.geo_loc_id = sch.geo_loc_id
   and c.source_sys_cd = 'OPIL.AZLI_DMT_ORG_UNITS'
   and sch.source_sys_cd = '20_SALES_HIERARCHY.AREA'
   and r.start_date >= to_date('01-AUG-2016', 'DD-MON-YYYY')
   and r.end_date <= to_date('31-AUG-2016', 'DD-MON-YYYY');
   
SELECT r.*
 from geoloc_party_rlship r, party c, geolocation sch  
 where r.party_id = c.party_id
   and r.geo_loc_id = sch.geo_loc_id
   and c.source_sys_cd = 'OPIL.AZLI_DMT_ORG_UNITS'
   and sch.source_sys_cd = '20_SALES_HIERARCHY.AREA'
   and r.start_date >= to_date('01-DEC-2016', 'DD-MON-YYYY')
   and r.end_date <= to_date('31-DEC-2016', 'DD-MON-YYYY');
   
   
SELECT count(1)
 from geoloc_party_rlship r, party c, geolocation sch  
 where r.party_id = c.party_id
   and r.geo_loc_id = sch.geo_loc_id
   and c.source_sys_cd = 'OPIL.AZLI_DMT_ORG_UNITS'
   and sch.source_sys_cd = '20_SALES_HIERARCHY.AREA'
--RESULT= 755

    --2. Check the count of the ACTIVE records the relation between branch code and Area matches with the source for August and Dec
SELECT r.*
 from geoloc_party_rlship r, party c, geolocation sch  
 where r.party_id = c.party_id
   and r.geo_loc_id = sch.geo_loc_id
   and c.source_sys_cd = 'OPIL.AZLI_DMT_ORG_UNITS'
   and sch.source_sys_cd = '20_SALES_HIERARCHY.REGION'
   and r.start_date >= to_date('01-AUG-2016', 'DD-MON-YYYY')
   and r.end_date <= to_date('31-AUG-2016', 'DD-MON-YYYY');
   
SELECT r.*
 from geoloc_party_rlship r, party c, geolocation sch  
 where r.party_id = c.party_id
   and r.geo_loc_id = sch.geo_loc_id
   and c.source_sys_cd = 'OPIL.AZLI_DMT_ORG_UNITS'
   and sch.source_sys_cd = '20_SALES_HIERARCHY.REGION'
   and r.start_date >= to_date('01-DEC-2016', 'DD-MON-YYYY')
   and r.end_date <= to_date('31-DEC-2016', 'DD-MON-YYYY');
   
   
SELECT count(1)
 from geoloc_party_rlship r, party c, geolocation sch  
 where r.party_id = c.party_id
   and r.geo_loc_id = sch.geo_loc_id
   and c.source_sys_cd = 'OPIL.AZLI_DMT_ORG_UNITS'
   and sch.source_sys_cd = '20_SALES_HIERARCHY.REGION'
--RESULT= 681

    --3. match 10 records for each of the above.
SELECT r.*
 from geoloc_party_rlship r, party c, geolocation sch  
 where r.party_id = c.party_id
   and r.geo_loc_id = sch.geo_loc_id
   and c.source_sys_cd = 'OPIL.AZLI_DMT_ORG_UNITS'
   and sch.source_sys_cd IN ('20_SALES_HIERARCHY.AREA', '20_SALES_HIERARCHY.REGION')
   and c.bus_code IN (
 'DINI ARDYA LINDA HAPZARI', 
 'IRMA SUSILAWATI SP', 
 'AMBAR RETNADI', 
 'CUT SYAFRINA', 
 'I MADE GEMARINANTA', 
 'WILLY FERNANDEZ ZEBUA', 
 'FRISKA ARINANDA DERIK WARDANI', 
 'HIMAWAN WIBISONO PHILIPUS',--
 'INTAN AMBARSARI', 
 'ANDAR YURARSO', 
 'DEWI TRESNASARI',--
 'DIAH SUHANDINI',
 'SUCI MILA SARI',
 'APRIYADI',
 'SUSILAWATI',
 'SUSILAWATY');  
   