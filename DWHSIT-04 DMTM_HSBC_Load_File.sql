--04 DMTM_HSBC_Load_File
  --SEQ1.STATISTICS
    --No test necessary.
SELECT * FROM DWH_CORE.STATISTICS WHERE SOURCE_SYS_CD = '04_DMTM_HSBC_Load_File';
SELECT * FROM DWH_CORE.STATISTICS WHERE BUS_CODE = '20170101';
    
  --SEQ2.STATISTICS_HEADER
SELECT * FROM DWH_CORE.PRODUCT WHERE PRODUCT_CD = 'BASE_ASFA';    

SELECT * FROM EDW_DWH_CORE.SPECIFICATION 
WHERE SOURCE_SYS_CD = '05_PRODUCT.PRODUCT_CODE';

SELECT * FROM EDW_DWH_CORE.SPECIFICATION 
WHERE SOURCE_SYS_CD = '05_PRODUCT'

SELECT * FROM EDW_DWH_CORE.SPECIFICATION 
WHERE BUS_CODE = 'BASE_ASFA'

SELECT DISTINCT TYPE_CODE FROM EDW_DWH_CORE.STATISTICS_HEADER;
SELECT * FROM EDW_DWH_CORE.STATISTICS_HEADER 
WHERE TYPE_CODE = 'DMTMHSBC'

    --1. Check for the ACTIVE product code, the record count matches with the number of records from the source files (currently there are two source files).  
    --Also join with Statistics table to make sure the stat_id is also there in anchor table. 
 SELECT r.*
 from DWH_CORE.STATISTICS_HEADER r, DWH_CORE.SPECIFICATION C
 where r.spec_id = c.spec_id
   and c.SOURCE_SYS_CD = '04_DMTM_HSBC_Load_File'
   
 SELECT COUNT(1)
 from EDW_DWH_CORE.STATISTICS_HEADER r, EDW_DWH_CORE.STATISTICS C
 where r.STATS_HDR_ID = c.STATS_ID
   and c.SOURCE_SYS_CD = '04_DMTM_HSBC_Load_File'
--RESULT: stats_id already same but count is different with source files. It should display 11 active product code same as source file instead 10
  
    
    --2. check 10 records that has matching Year, Month, Currency
SELECT STATS_HDR_ID, STAT_YEAR, STAT_MTH, CURRENCY_CD, STATS_ID FROM EDW_DWH_CORE.STATISTICS_HEADER 
WHERE TYPE_CODE = 'DMTMHSBC'   
 AND STAT_YEAR = '2016'   
 
SELECT STATS_HDR_ID, STAT_YEAR, STAT_MTH, CURRENCY_CD, STATS_ID FROM EDW_DWH_CORE.STATISTICS_HEADER 
WHERE TYPE_CODE = 'DMTMHSBC'   
 AND STAT_YEAR = '2017'   
 
 --
 SELECT r.*
 from EDW_DWH_CORE.STATISTICS_HEADER r, EDW_DWH_CORE.STATISTICS C, EDW_DWH_CORE.STATISTICS sch
 where r.STATS_HDR_ID = c.STATS_ID
   and c.SOURCE_SYS_CD = '04_DMTM_HSBC_Load_File'
   and sch.BUS_CODE IN (
   '20160601',
   '20160701')
 --
  
  --SEQ3.STATISTICS_DETAILS
    --1. Check for 10 records if the policy sold, actual commision income, Annual GWP matches with source.
SELECT DISTINCT STATS_ID FROM EDW_DWH_CORE.STATISTICS_DETAIL WHERE STAT_CODE in ( 'NOPOLSOLD', 'ACTLCOMMINC', 'ACTLGWP')

SELECT * FROM EDW_DWH_CORE.STATISTICS_DETAIL 
WHERE STAT_CODE in ( 'NOPOLSOLD') 
AND VALUE IN (
'762',
'11486600',
'57433000',
'745',
'11072400',
'10632200',
'725'
)

SELECT * FROM EDW_DWH_CORE.STATISTICS_DETAIL 
WHERE STAT_CODE in ( 'NOPOLSOLD', 'ACTLCOMMINC', 'ACTLGWP') 
AND VALUE IN (
'762'
)

    --2. If the above test pass, check if the sum of the policy sold, actual commision income, Annual GWP of Active records matches with the source. 
select h.stat_year, h.stat_mth, h.type_code, h.spec_id, p.product_cd, h.currency_cd, 
       sum (decode(d.stat_code, 'ACTLCOMMINC', d.value,0)) "Actual Commission Income",
       sum (decode(d.stat_code, 'ACTLGWP', d.value,0))     "Actual GWP",
       sum (decode(d.stat_code, 'NOPOLSOLD', d.value,0))   "Policies Sold"
  from edw_dwh_core.statistics sh, edw_dwh_core.statistics_header h, 
       edw_dwh_core.statistics sd, edw_dwh_core.statistics_detail d,
       edw_dwh_core.specification s, edw_dwh_core.product p
 where sh.stats_id = h.stats_id
   and sd.stats_id = d.stats_id
   and s.spec_id = p.spec_id
   and s.spec_id = h.spec_id
   and s.source_sys_cd = '05_PRODUCT.PRODUCT_CODE'
   and to_char(p.end_date, 'DD-MON-YYYY') = '01-JAN-9999'
   and sh.source_sys_cd = '04_DMTM_HSBC_Load_File'
   and sd.source_sys_cd = '04_DMTM_HSBC_Load_File'
  -- and to_char(h.end_date, 'DD-MON-YYYY') = '01-JAN-9999' -- BUG
group by h.stat_year, h.stat_mth, h.type_code, h.spec_id, p.product_cd, h.currency_cd
order by h.stat_year, h.stat_mth, h.type_code, p.product_cd, h.currency_cd
    
    
   --SEQ4.PRODUCT
    --1. Check for 10 records if the policy sold, actual commision income, Annual GWP matches with source.
SELECT DISTINCT Source_Sys_Cd FROM EDW_DWH_CORE.PRODUCT;
SELECT * FROM EDW_DWH_CORE.PRODUCT WHERE Source_Sys_Cd = '04_DMTM_HSBC_Load_File'

SELECT * FROM EDW_DWH_CORE.SPECIFICATION 
WHERE SOURCE_SYS_CD = '05_PRODUCT'

select r.*
 from EDW_DWH_CORE.PRODUCT r, EDW_DWH_CORE.SPECIFICATION c, EDW_DWH_CORE.SPECIFICATION sch
 where r.PRODUCT_ID = c.SPEC_ID
   and c.source_sys_cd = '05_PRODUCT'
   and sch.BUS_CODE = 'BASE_ASFA'

SELECT * FROM EDW_DWH_CORE.STATISTICS WHERE SOURCE_SYS_CD = '04_DMTM_HSBC_Load_File';

select r.*
 from EDW_DWH_CORE.PRODUCT r, EDW_DWH_CORE.STATISTICS c, 
 --EDW_DWH_CORE.STATISTICS sch
 where r.PRODUCT_ID = c.STATS_ID
   and c.source_sys_cd = '04_DMTM_HSBC_Load_File'
   --and sch.BUS_CODE = 'BASE_ASFA'


    --2. If the above test pass, check if the sum of the policy sold, actual commision income, Annual GWP of Active records matches with the source. 
select h.stat_year, h.stat_mth, h.type_code, h.spec_id, p.product_cd, h.currency_cd, 
       sum (decode(d.stat_code, 'ACTLCOMMINC', d.value,0)) "Actual Commission Income",
       sum (decode(d.stat_code, 'ACTLGWP', d.value,0))     "Actual GWP",
       sum (decode(d.stat_code, 'NOPOLSOLD', d.value,0))   "Policies Sold"
  from edw_dwh_core.statistics sh, edw_dwh_core.statistics_header h, 
       edw_dwh_core.statistics sd, edw_dwh_core.statistics_detail d,
       edw_dwh_core.specification s, edw_dwh_core.product p
 where sh.stats_id = h.stats_id
   and sd.stats_id = d.stats_id
   and s.spec_id = p.spec_id
   and s.spec_id = h.spec_id
   and s.source_sys_cd = '05_PRODUCT.PRODUCT_CODE'
   and to_char(p.end_date, 'DD-MON-YYYY') = '01-JAN-9999'
   and sh.source_sys_cd = '04_DMTM_HSBC_Load_File'
   and sd.source_sys_cd = '04_DMTM_HSBC_Load_File'
  -- and to_char(h.end_date, 'DD-MON-YYYY') = '01-JAN-9999' -- BUG
group by h.stat_year, h.stat_mth, h.type_code, h.spec_id, p.product_cd, h.currency_cd
order by h.stat_year, h.stat_mth, h.type_code, p.product_cd, h.currency_cd
    
    
   --SEQ5.SPEC_CAT_RLSHIP
    --1. Check for 10 records if the policy sold, actual commision income, Annual GWP matches with source.
SELECT * FROM EDW_DWH_CORE.SPEC_CAT_RLSHIP;

--
SELECT * FROM EDW_DWH_CORE.CATEGORY WHERE BUS_CODE='HSBCDMTM' AND Source_System_Cd = '03_HSBC_PRODUCT_GROUP_CATEGORY_YEARLY.HSBCDMTM';

SELECT * FROM EDW_DWH_CORE.CATEGORY WHERE Source_System_Cd = '03_HSBC_PRODUCT_GROUP_CATEGORY_YEARLY';
--
    
SELECT DISTINCT SOURCE_SYS_CD FROM EDW_DWH_CORE.CATEGORY

SELECT * FROM EDW_DWH_CORE.SPECIFICATION;

--
select r.*
 from EDW_DWH_CORE.SPEC_CAT_RLSHIP r, EDW_DWH_CORE.CATEGORY c, EDW_DWH_CORE.SPECIFICATION sch, 
 where r.SPEC_CAT_RLS_ID = c.CAT_ID
 and r.SPEC_CAT_RLS_ID = sch.SPEC_ID
   and c.source_sys_cd = '03_HSBC_PRODUCT_GROUP_CATEGORY_YEARLY.HSBCSHRYAGRP'
    and sch.source_sys_cd = '05_PRODUCT'
--

    --2. If the above test pass, check if the sum of the policy sold, actual commision income, Annual GWP of Active records matches with the source. 
select h.stat_year, h.stat_mth, h.type_code, h.spec_id, p.product_cd, h.currency_cd
       sum (decode(d.stat_code, 'ACTLCOMMINC', d.value,0)) "Actual Commission Income",
       sum (decode(d.stat_code, 'ACTLGWP', d.value,0))     "Actual GWP",
       sum (decode(d.stat_code, 'NOPOLSOLD', d.value,0))   "Policies Sold"
  from edw_dwh_core.statistics sh, edw_dwh_core.statistics_header h, 
       edw_dwh_core.statistics sd, edw_dwh_core.statistics_detail d,
       edw_dwh_core.specification s, edw_dwh_core.product p
 where sh.stats_id = h.stats_id
   and sd.stats_id = d.stats_id
   and s.spec_id = p.spec_id
   and s.spec_id = h.spec_id
   and s.source_sys_cd = '05_PRODUCT.PRODUCT_CODE'
   and to_char(p.end_date, 'DD-MON-YYYY') = '01-JAN-9999'
   and sh.source_sys_cd = '04_DMTM_HSBC_Load_File'
   and sd.source_sys_cd = '04_DMTM_HSBC_Load_File'
  -- and to_char(h.end_date, 'DD-MON-YYYY') = '01-JAN-9999' -- BUG
group by h.stat_year, h.stat_mth, h.type_code, h.spec_id, p.product_cd, h.currency_cd
order by h.stat_year, h.stat_mth, h.type_code, p.product_cd, h.currency_cd
       

   --SEQ6.SPECIFICATION
select h.*
  from dwh_core.statistics sh, dwh_core.statistics_header h
 where sh.stats_id = h.stats_id
   and sh.source_sys_cd = '04_DMTM_HSBC_Load_File';
   --Not necessary
   
select * from dwh_core.party_spec_rlship;   
