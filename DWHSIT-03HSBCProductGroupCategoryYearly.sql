--03 HSBC Product group Category yearly
  --SEQ1.CATEGORY
    --No test necessary
SELECT DISTINCT SOURCE_SYS_CD FROM DWH_CORE.CATEGORY;
SELECT * FROM DWH_CORE.CATEGORY WHERE SOURCE_SYS_CD = '03_HSBC_PRODUCT_GROUP_CATEGORY_YEARLY.PRODUCT_GROUP';
SELECT * FROM DWH_CORE.CATEGORY WHERE SOURCE_SYS_CD = '03_HSBC_PRODUCT_GROUP_CATEGORY_YEARLY.PRODUCT_CATEGORY';

SELECT * FROM DWH_CORE.CATEGORY WHERE SOURCE_SYS_CD = '03_HSBC_PRODUCT_GROUP_CATEGORY_YEARLY.HSBCSHRYAGRP'


select distinct source_sys_cd from dwh_core.product 
select * from dwh_core.product where source_sys_cd = '03_HSBC_PRODUCT_GROUP_CATEGORY_YEARLY'

select distinct source_sys_cd from DWH_CORE.Statistics;
select * from DWH_CORE.Statistics where source_sys_cd = '04_DMTM_HSBC_Load_File';

select * from DWH_CORE.Specification 
where source_sys_cd = '05_PRODUCT.PRODUCT_CODE'
and bus_code in ('BASE_SHCP', 'BASE_SHSNW','BASE_CPRA','BASE_OPCI','BASE_SHRE', 'BASE_SHFC', 'BASE_FRC50', 'BASE_CLLGC', 'BASE_HSCIP','BASE_ASFA', 'Credit Care Plus');

  --SEQ2.CATEGORY_DETAIL
SELECT * FROM DWH_CORE.CATEGORY_DETAIL

    --1. Check count of distinct Product Group matches with source
SELECT * FROM CATEGORY_DETAIL where cat_id in (
select cat_id from category
 where SOURCE_SYS_CD = '03_HSBC_PRODUCT_GROUP_CATEGORY_YEARLY.PRODUCT_GROUP');

SELECT count(1) FROM CATEGORY_DETAIL where cat_id in (
select cat_id from category
 where SOURCE_SYS_CD = '03_HSBC_PRODUCT_GROUP_CATEGORY_YEARLY.PRODUCT_GROUP');
--RESULT: 6

    --2. Check the count of distinct Product Category matches with source
SELECT * FROM CATEGORY_DETAIL where cat_id in (
select cat_id from category
 where SOURCE_SYS_CD = '03_HSBC_PRODUCT_GROUP_CATEGORY_YEARLY.PRODUCT_CATEGORY');

SELECT count(1) FROM CATEGORY_DETAIL where cat_id in (
select cat_id from category
 where SOURCE_SYS_CD = '03_HSBC_PRODUCT_GROUP_CATEGORY_YEARLY.PRODUCT_CATEGORY');
--RESULT: 4

    --3. take sample of 10 records above and check if it matches with source
  select * from category_detail where name in  ('CARE INVEST', 'OPTIMA CARE INVEST', 'RP FUTURE CARE (IDR)', 'RP PROTECTION (CREDIT SHIELD)');
    
  --SEQ3.SPECIFICATION
    --No test necessary

  --SEQ4.PRODUCT
select * from DWH_CORE.PRODUCT where source_sys_cd =  '03_HSBC_PRODUCT_GROUP_CATEGORY_YEARLY'
select distinct source_sys_cd from DWH_CORE.PRODUCT
select distinct product_cd from DWH_CORE.PRODUCT

SELECT DISTINCT SOURCE_SYS_CD FROM DWH_CORE.SPECIFICATION
select * from DWH_CORE.Specification where source_sys_cd = '05_PRODUCT';

select * from DWH_CORE.spec_cat_rlship
SELECT r.*
 from dwh_core.SPEC_CAT_RLSHIP r, dwh_core.specification c
 where r.spec_id = c.spec_id
  and c.source_sys_cd = '05_PRODUCT'

SELECT r.*
 from dwh_core.category_detail r, dwh_core.category c --dwh_core.category sh -- dwh_core.category d, 
 where r.cat_id = c.cat_id
  and c.source_sys_cd = '03_HSBC_PRODUCT_GROUP_CATEGORY_YEARLY.PRODUCT_GROUP'
  --and sh.source_sys_cd = '03_HSBC_PRODUCT_GROUP_CATEGORY_YEARLY.PRODUCT_CATEGORY'
  --and c.source_sys_cd = '03_HSBC_PRODUCT_GROUP_CATEGORY_YEARLY.HSBCSHRYAGRP'

SELECT r.*
 from dwh_core.product r, dwh_core.specification c
 where r.spec_id = c.spec_id
  and c.source_sys_cd = '05_PRODUCT';

alter session set current_schema = DWH_CORE;

select * from product where spec_id in (
select spec_id from specification
 where bus_code in ('BASE_SHCP', 'BASE_SHSNW','BASE_CPRA','BASE_OPCI','BASE_SHRE', 'BASE_SHFC', 'BASE_FRC50', 'BASE_CLLGC', 'BASE_HSCIP','BASE_ASFA', 'Credit Care Plus')
)

select * from specification
 where bus_code in ('BASE_SHCP', 'BASE_SHSNW','BASE_CPRA','BASE_OPCI','BASE_SHRE')

    --1. Check 10 active records of Proudct Code, Allocation, Inception Date, Termination type is matching betweeen file and table
--
select Product_Cd, Name, Descr, Incept_Date, Termn_Type, Source_sys_cd from product where spec_id in (
select spec_id from specification
 where bus_code in ('BASE_SHCP', 'BASE_SHSNW','BASE_CPRA','BASE_OPCI','BASE_SHRE', 'BASE_SHFC', 'BASE_FRC50', 'BASE_CLLGC', 'BASE_HSCIP','BASE_ASFA', 'Credit Care Plus')
);
--  

  --SEQ5.SPEC_CAT_RLSHIP
SELECT * FROM DWH_CORE.SPEC_CAT_RLSHIP;

SELECT * FROM DWH_CORE.CATEGORY WHERE SOURCE_SYS_CD = '03_HSBC_PRODUCT_GROUP_CATEGORY_YEARLY.PRODUCT_GROUP';
SELECT * FROM DWH_CORE.CATEGORY WHERE SOURCE_SYS_CD = '03_HSBC_PRODUCT_GROUP_CATEGORY_YEARLY.PRODUCT_CATEGORY';

SELECT DISTINCT SOURCE_SYS_CD FROM DWH_CORE.SPECIFICATION
select * from DWH_CORE.Specification where source_sys_cd = '05_PRODUCT';

    --1. Check the count of active (product code, product group) matches with the source

SELECT r.*
 from dwh_core.SPEC_CAT_RLSHIP r, dwh_core.category c
 where r.cat_id = c.CAT_ID
  and c.source_sys_cd = '03_HSBC_PRODUCT_GROUP_CATEGORY_YEARLY.PRODUCT_GROUP'
  
SELECT COUNT(1)
 from dwh_core.SPEC_CAT_RLSHIP r, dwh_core.category c
 where r.cat_id = c.CAT_ID
  and c.source_sys_cd = '03_HSBC_PRODUCT_GROUP_CATEGORY_YEARLY.PRODUCT_GROUP'

    --2. Check the count of active (Product code, Proudct Category) matches with the source
SELECT r.*
 from dwh_core.SPEC_CAT_RLSHIP r, dwh_core.category c
 where r.cat_id = c.CAT_ID
  and c.source_sys_cd = '03_HSBC_PRODUCT_GROUP_CATEGORY_YEARLY.PRODUCT_CATEGORY'

SELECT COUNT(1)
 from dwh_core.SPEC_CAT_RLSHIP r, dwh_core.category c
 where r.cat_id = c.CAT_ID
  and c.source_sys_cd = '03_HSBC_PRODUCT_GROUP_CATEGORY_YEARLY.PRODUCT_CATEGORY'
    
    --3. Check 10 records and see that it is present in source and table
select * from SPEC_CAT_RLSHIP where spec_id in (
select spec_id from Specification
 where bus_code in ('BASE_SHCP', 'BASE_SHSNW','BASE_CPRA','BASE_OPCI','BASE_SHRE', 'BASE_SHFC', 'BASE_FRC50', 'BASE_CLLGC', 'BASE_HSCIP','BASE_ASFA', 'Credit Care Plus')
and alloc in ('0.25','0.75', '100'));  

