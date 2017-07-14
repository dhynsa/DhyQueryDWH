--LEDWH-248 [FIXED]
select r.*
from DWH_CORE.CATEGORY_DETAIL r, DWH_CORE.CATEGORY c
where r.CAT_ID = c.CAT_ID
and c.source_sys_cd = '05_PRODUCT.PROD_CATEGORY'
and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999';
select COUNT(1) 
from DWH_CORE.CATEGORY_DETAIL r, DWH_CORE.CATEGORY c
where r.CAT_ID = c.CAT_ID
and c.source_sys_cd = '05_PRODUCT.PROD_CATEGORY'
and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999';

select r.*
from DWH_CORE.CATEGORY_DETAIL r, DWH_CORE.CATEGORY c
where r.CAT_ID = c.CAT_ID
and c.source_sys_cd = '05_PRODUCT.PROD_TYPE'
and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999';
select COUNT(1) 
from DWH_CORE.CATEGORY_DETAIL r, DWH_CORE.CATEGORY c
where r.CAT_ID = c.CAT_ID
and c.source_sys_cd = '05_PRODUCT.PROD_TYPE'
and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999';

select r.*
from DWH_CORE.CATEGORY_DETAIL r, DWH_CORE.CATEGORY c
where r.CAT_ID = c.CAT_ID
and c.source_sys_cd = '05_PRODUCT.PRODUCT_LOB'
and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999';
select COUNT(1) 
from DWH_CORE.CATEGORY_DETAIL r, DWH_CORE.CATEGORY c
where r.CAT_ID = c.CAT_ID
and c.source_sys_cd = '05_PRODUCT.PRODUCT_LOB'
and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999';

select r.*
from DWH_CORE.CATEGORY_DETAIL r, DWH_CORE.CATEGORY c
where r.CAT_ID = c.CAT_ID
and c.source_sys_cd = '05_PRODUCT.LOB_CATEGORY'
and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999';
select COUNT(1) 
from DWH_CORE.CATEGORY_DETAIL r, DWH_CORE.CATEGORY c
where r.CAT_ID = c.CAT_ID
and c.source_sys_cd = '05_PRODUCT.LOB_CATEGORY'
and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999';


--LEDWH-229[FIXED]
select * from DWH_CORE.PARTY WHERE source_sys_cd = '01_CHANNEL_MASTER.CHANNEL_CD';

--LEDWH-230[FIXED]
SELECT code, name, descr FROM DWH_CORE.ORGANIZATION 
WHERE source_sys_cd = '01_CHANNEL_MASTER.SUBCHANNEL_CD'
and to_char(END_DATE,'DD-MON-YYYY') = '01-JAN-9999'
AND CODE IN (
'AZID',
'Spring',
'Eagle',
'Azindo',
'ANZ',
'RBS',
'MITRANIAGA',
'BTPN',
'BCI',
'CIMBNIAGA');

--LEDWH-231[FIXED]
SELECT code, descr, name FROM DWH_CORE.ORGANIZATION 
WHERE source_sys_cd = '01_CHANNEL_MASTER.SUBCHANNEL_CD'; 

--LEDWH-232[re-opened]
select subchannel_cd from DWH_CORE.CHANNEL;

--LEDWH-243[FIXED]
SELECT * FROM DWH_CORE.PARTY_SPEC_RLSHIP;

--LEDWH-253[FIXED]
select * from DWH_CORE.specification
where bus_code in ('BASE_SHCP', 'BASE_SHSNW','BASE_CPRA','BASE_OPCI','BASE_SHRE');


--LEDWH-254[FIXED]
alter session set current_schema = DWH_CORE;
select * from product where spec_id in (
select spec_id from specification
where bus_code in ('BASE_SHCP', 'BASE_SHSNW','BASE_CPRA','BASE_OPCI','BASE_SHRE', 'BASE_SHFC', 'BASE_FRC50', 'BASE_CLLGC', 'BASE_HSCIP','BASE_ASFA', 'Credit Care Plus')
);

select product_cd, name, incept_date, termn_type from product where spec_id in (
select spec_id from specification
where bus_code in (
'BASE_SHCP', 
'BASE_SHSNW',
'BASE_CPRA',
'BASE_OPCI',
'BASE_SHRE', 
'BASE_SHFC', 
'BASE_FRC50', 
'BASE_CLLGC', 
'BASE_HSCIP',
'BASE_ASFA', 
'Credit Care Plus'));

--LEDWH-242[FIXED]
select COUNT(1) 
from dwh_core.party_rlship r, dwh_core.party c, dwh_core.party sch 
where r.left_party_id = c.party_id
and r.right_party_id = sch.party_id
and c.source_sys_cd = '05_Product.Company_cd'
and sch.source_sys_cd = '05_Product.Company_lob'
and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999';

select r.*
from dwh_core.party_rlship r, dwh_core.party c, dwh_core.party sch 
where r.left_party_id = c.party_id
and r.right_party_id = sch.party_id
and c.source_sys_cd = '05_Product.Company_cd'
and sch.source_sys_cd = '05_Product.Company_lob'
and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999';

--LEDWH-240 - SOLVE JUST WILLIAM SIDE
SELECT DISTINCT source_sys_cd FROM DWH_CORE.ORGANIZATION
--company_cd
SELECT * FROM DWH_CORE.ORGANIZATION WHERE source_sys_cd = '05_Product.Company_cd';
SELECT COUNT(ORZN_ID), COUNT(DISTINCT ORZN_ID) FROM DWH_CORE.ORGANIZATION 
WHERE source_sys_cd = '05_Product.Company_cd'
and to_char(END_DATE,'DD-MON-YYYY') = '01-JAN-9999';
--company_lob
SELECT * FROM DWH_CORE.ORGANIZATION WHERE source_sys_cd = '05_Product.Company_lob';
SELECT COUNT(ORZN_ID), COUNT(DISTINCT ORZN_ID) FROM DWH_CORE.ORGANIZATION 
WHERE source_sys_cd = '05_Product.Company_lob'
and to_char(END_DATE,'DD-MON-YYYY') = '01-JAN-9999';

--LEDWH-268[FIXED]
select appl_no, fyp_idr, fyp_usd from DWH_CORE.INSURANCE_PROPOSAL
where appl_no IN
(
'0011996430',
'0011074513',
'0011074484',
'0011074446',
'0011074477',
'0011060715',
'5002969271',
'0011576469',
'0011064146',
'0011725211');

--LEDWH-241[FIXED]
select distinct NATURE from DWH_CORE.PARTY_RLSHIP;


--LEDWH-249[FIXED]
select r.*
from DWH_CORE.CATEGORY_DETAIL r, DWH_CORE.CATEGORY c
where r.CAT_ID = c.CAT_ID
and c.BUS_CODE IN(
'CONVENTIONAL',
'SYARIAH',
'TRADITIONAL',
'HEALTH',
'Unit Link',
'Pension',
'Life',
'Health',
'Saving',
'Group' )

alter session set current_schema = DWH_CORE;

--LEDWH-288[FIXED]
select * from AGMT_CONTACT_RLSHIP

--LEDWH-250[FIXED]
SELECT * FROM DWH_CORE.STATISTICS WHERE SOURCE_SYS_CD = '04_DMTM_HSBC_Load_File';


SELECT r.*
from DWH_CORE.STATISTICS_HEADER r, DWH_CORE.STATISTICS C
where r.STATS_ID = c.STATS_ID
and c.SOURCE_SYS_CD = '04_DMTM_HSBC_Load_File'
AND TRUNC(R.END_DATE) = '1 JAN 9999';

SELECT count(1) from DWH_CORE.STATISTICS_HEADER r, DWH_CORE.STATISTICS C
where r.STATS_ID = c.STATS_ID
and c.SOURCE_SYS_CD = '04_DMTM_HSBC_Load_File'
AND TRUNC(R.END_DATE) = '1 JAN 9999';

--LEDWH-232[doesn't matter order so CLOSED]
select * from DWH_CORE.CHANNEL;

The mapping is incorrectly done to Company_Cd source column rather than Company_LOB.
The below query should give: life rather than AZ
select * 
from organization o, party p
where o.party_id = p.party_id
and o.type_code = 'CMPNYLOB'
and to_char(o.end_date, 'DD-MON-YYYY') = '01-JAN-9999'
and p.source_sys_cd = '05_Product.Company_lob';

select * from DWH_CORE.party_spec_rlship
select count(1) from DWH_CORE.party_spec_rlship
but there are 327 product_code in the product_master file. The DIM_PRODUCT will not be created properly if all the records are not present in DWH_CORE.party_spec_rlship table