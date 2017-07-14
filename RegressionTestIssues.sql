--LEDWH-229
select * from DWH_CORE.PARTY WHERE source_sys_cd = '01_CHANNEL_MASTER.CHANNEL_CD';

--LEDWH-230
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

--LEDWH-231
SELECT code, descr, name FROM DWH_CORE.ORGANIZATION 
WHERE source_sys_cd = '01_CHANNEL_MASTER.SUBCHANNEL_CD' 

--LEDWH-232
select subchannel_cd from DWH_CORE.CHANNEL;

--LEDWH-233
select count (distinct SPEC_ID) from DWH_CORE.SPECIFICATION 
WHERE SOURCE_SYS_CD = '05_PRODUCT.PRODUCT_CODE';

select * from DWH_CORE.SPECIFICATION 
WHERE SOURCE_SYS_CD = '05_PRODUCT.PRODUCT_CODE';

--LEDWH-234 [CLOSED]
SELECT * FROM DWH_CORE.PRODUCT 
WHERE source_sys_cd = '05_PRODUCT.PRODUCT_CODE'
and to_char(END_DATE,'DD-MON-YYYY') = '01-JAN-9999'
and PRODUCT_CD IN ('CREDIT_LIFE_MORTGAGE')

--LEDWH-235 [CLOSED]
SELECT * FROM DWH_CORE.PRODUCT 
WHERE source_sys_cd = '05_PRODUCT.PRODUCT_CODE'
and to_char(END_DATE,'DD-MON-YYYY') = '01-JAN-9999'
and PRODUCT_CD IN ('PAYUNG PLUS', 'CREDIT_LIFE_MORTGAGE')

--LEDWH-236 [CLOSED]
SELECT * FROM DWH_CORE.PRODUCT 
WHERE source_sys_cd = '05_PRODUCT.PRODUCT_CODE'
and to_char(END_DATE,'DD-MON-YYYY') = '01-JAN-9999'
and PRODUCT_CD IN ('CREDIT_LIFE_MORTGAGE')

--LEDWH-237 [CLOSED]
SELECT distinct source_sys_cd FROM DWH_CORE.PARTY
SELECT * FROM DWH_CORE.PARTY where source_sys_cd = '05_Product.Company_cd'
SELECT * FROM DWH_CORE.PARTY where source_sys_cd = '05_Product.Company_lob'

--LEDWH-238 [CLOSED]
SELECT PARTY_ID, BUS_CODE, SOURCE_SYS_CD FROM DWH_CORE.PARTY WHERE SOURCE_SYS_CD = '05_Product.Company_cd';

--LEDWH-239 [CLOSED]
SELECT PARTY_ID, BUS_CODE, SOURCE_SYS_CD FROM DWH_CORE.PARTY WHERE SOURCE_SYS_CD = '05_Product.Company_lob';

--LEDWH-240
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

--LEDWH-241
select distinct NATURE from DWH_CORE.PARTY_RLSHIP
select * from DWH_CORE.PARTY_RLSHIP

--LEDWH-242
select r.*
from DWH_CORE.PARTY_RLSHIP r, DWH_CORE.PARTY c, DWH_CORE.PARTY sch 
where r.left_party_id = c.party_id
and r.right_party_id = sch.party_id
and c.source_sys_cd = '05_Product.Company_cd'
and sch.source_sys_cd = '05_Product.Company_lob'
and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999';

select COUNT(1) 
from dwh_core.party_rlship r, dwh_core.party c, dwh_core.party sch 
where r.left_party_id = c.party_id
and r.right_party_id = sch.party_id
and c.source_sys_cd = '05_Product.Company_cd'
and sch.source_sys_cd = '05_Product.Company_lob'
and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999';

--LEDWH-243
SELECT * FROM DWH_CORE.PARTY_SPEC_RLSHIP

--LEDWH-244 [CLOSED]
SELECT * FROM DWH_CORE.CATEGORY WHERE source_sys_cd = '05_PRODUCT.PROD_CATEGORY';
SELECT COUNT(CAT_ID), COUNT(DISTINCT CAT_ID) FROM DWH_CORE.CATEGORY 
WHERE source_sys_cd = '05_PRODUCT.PROD_CATEGORY';

--LEDWH-245 [CLOSED]
SELECT * FROM DWH_CORE.CATEGORY WHERE source_sys_cd = '05_PRODUCT.PROD_TYPE';
SELECT COUNT(CAT_ID), COUNT(DISTINCT CAT_ID) FROM DWH_CORE.CATEGORY 
WHERE source_sys_cd = '05_PRODUCT.PROD_TYPE';

--LEDWH-246 [CLOSED]
SELECT * FROM DWH_CORE.CATEGORY WHERE source_sys_cd = '05_PRODUCT.PRODUCT_LOB';
SELECT COUNT(CAT_ID), COUNT(DISTINCT CAT_ID) FROM DWH_CORE.CATEGORY 
WHERE source_sys_cd = '05_PRODUCT.PRODUCT_LOB';

--LEDWH-247 [CLOSED]
SELECT * FROM DWH_CORE.CATEGORY WHERE source_sys_cd = '05_PRODUCT.LOB_CATEGORY';
SELECT COUNT(CAT_ID), COUNT(DISTINCT CAT_ID) FROM DWH_CORE.CATEGORY 
WHERE source_sys_cd = '05_PRODUCT.LOB_CATEGORY';

--LEDWH-248
select r.*
from DWH_CORE.CATEGORY_DETAIL r, DWH_CORE.CATEGORY c
where r.CAT_DET_ID = c.CAT_ID
and c.source_sys_cd = '05_PRODUCT.PROD_CATEGORY'
and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999';
select COUNT(1) 
from DWH_CORE.CATEGORY_DETAIL r, DWH_CORE.CATEGORY c
where r.CAT_DET_ID = c.CAT_ID
and c.source_sys_cd = '05_PRODUCT.PROD_CATEGORY'
and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999';

select r.*
from DWH_CORE.CATEGORY_DETAIL r, DWH_CORE.CATEGORY c
where r.CAT_DET_ID = c.CAT_ID
and c.source_sys_cd = '05_PRODUCT.PROD_TYPE'
and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999';
select COUNT(1) 
from DWH_CORE.CATEGORY_DETAIL r, DWH_CORE.CATEGORY c
where r.CAT_DET_ID = c.CAT_ID
and c.source_sys_cd = '05_PRODUCT.PROD_TYPE'
and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999';

select r.*
from DWH_CORE.CATEGORY_DETAIL r, DWH_CORE.CATEGORY c
where r.CAT_DET_ID = c.CAT_ID
and c.source_sys_cd = '05_PRODUCT.PRODUCT_LOB'
and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999';
select COUNT(1) 
from DWH_CORE.CATEGORY_DETAIL r, DWH_CORE.CATEGORY c
where r.CAT_DET_ID = c.CAT_ID
and c.source_sys_cd = '05_PRODUCT.PRODUCT_LOB'
and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999';

select r.*
from DWH_CORE.CATEGORY_DETAIL r, DWH_CORE.CATEGORY c
where r.CAT_DET_ID = c.CAT_ID
and c.source_sys_cd = '05_PRODUCT.LOB_CATEGORY'
and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999';
select COUNT(1) 
from DWH_CORE.CATEGORY_DETAIL r, DWH_CORE.CATEGORY c
where r.CAT_DET_ID = c.CAT_ID
and c.source_sys_cd = '05_PRODUCT.LOB_CATEGORY'
and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999';



--LEDWH-249
select r.*
from DWH_CORE.CATEGORY_DETAIL r, DWH_CORE.CATEGORY c
where r.CAT_DET_ID = c.CAT_ID
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


