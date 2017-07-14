--05 Product
  --SEQ1.SPECIFICATION
select * from EDW_DWH_CORE.SPECIFICATION;
    --1. Check count of distinct product code present in source is present in the specification table
select count (distinct SPEC_ID) from EDW_DWH_CORE.SPECIFICATION WHERE SOURCE_SYS_CD = '05_PRODUCT.PRODUCT_CODE';
--RESULT: It's not the same with source Product_MasterV5. (Total V5 = 333, Spec table=368)

  --SEQ2.PRODUCT
    --1. check if the count of ACTIVE distinct/non-distinct PRODUCT_CODE matches with source. 
    --See that SQL includes the anchor table, to check if spec_id is present in the party table.
--distinct
SELECT * FROM EDW_DWH_CORE.PRODUCT 
WHERE source_sys_cd = '05_PRODUCT.PRODUCT_CODE'
  and to_char(END_DATE,'DD-MON-YYYY') = '01-JAN-9999'
--and
select count (distinct PRODUCT_ID) from EDW_DWH_CORE.PRODUCT 
WHERE SOURCE_SYS_CD = '05_PRODUCT.PRODUCT_CODE'and to_char(END_DATE,'DD-MON-YYYY') = '01-JAN-9999';
--OR
SELECT COUNT(PRODUCT_CD), COUNT(DISTINCT PRODUCT_CD) FROM EDW_DWH_CORE.PRODUCT 
WHERE source_sys_cd = '05_PRODUCT.PRODUCT_CODE'
  and to_char(END_DATE,'DD-MON-YYYY') = '01-JAN-9999'
--RESULT: 350


    --2. For 10 records check if the product cd, product name,  product long name and PRODUCT_MARKETING_TYPE,   matches with source
SELECT * FROM EDW_DWH_CORE.PRODUCT 
WHERE source_sys_cd = '05_PRODUCT.PRODUCT_CODE'
  --and to_char(END_DATE,'DD-MON-YYYY') = '01-JAN-9999'
  and PRODUCT_CD IN (
'GADAI PRO SYARIAH',
'CREDIT_LIFE_MORTGAGE',
'BASE_MARLK',
'BASE_MSD',
'EZ000012',
'EZ000013',
'MAXI VIOLET',
'EZ000008',
'EZ000015',
'GSC')

SELECT * FROM EDW_DWH_CORE.PRODUCT 
WHERE source_sys_cd = '05_PRODUCT.PRODUCT_CODE'
  --and to_char(END_DATE,'DD-MON-YYYY') = '01-JAN-9999'
  and PRODUCT_CD IN ('CREDIT_LIFE_MORTGAGE')
  
SELECT * FROM EDW_DWH_CORE.PRODUCT 
--WHERE source_sys_cd = '05_PRODUCT.PRODUCT_CODE'
  --and to_char(END_DATE,'DD-MON-YYYY') = '01-JAN-9999'
  where PRODUCT_CD IN ('MAXI VIOLET')
  

  --SEQ3.PARTY
    --1. Check the count of distinct Company_Cd is present in the party table.
SELECT * FROM EDW_DWH_CORE.PARTY WHERE TYPE_CODE = 'ORGN';
SELECT PARTY_ID, BUS_CODE, SOURCE_SYS_CD FROM EDW_DWH_CORE.PARTY WHERE SOURCE_SYS_CD = 'PARTY_DWH_Company_Cd_05_product';
select count (distinct party_id) from EDW_DWH_CORE.PARTY WHERE source_sys_cd = 'PARTY_DWH_Company_Cd_05_product';
--RESULT: 3 -> wrong result, it should be 1 = AZ
    --2. Check the count of distinct COMPANY_LOB in party table.
SELECT PARTY_ID, BUS_CODE, SOURCE_SYS_CD FROM EDW_DWH_CORE.PARTY WHERE SOURCE_SYS_CD = 'PARTY_DWH_Company_lob_05_product';
select count (distinct party_id) from EDW_DWH_CORE.PARTY WHERE source_sys_cd = 'PARTY_DWH_Company_lob_05_product';  
--RESULT: 2 -> wrong result, it should be 1 = Life

  --SEQ4.ORGANIZATION
    --1. Check if the count of ACTIVE distinct/non-distinct Company_Cd  matches with source.
SELECT * FROM EDW_DWH_CORE.ORGANIZATION WHERE TYPE_CODE = 'CMPNYCD';
SELECT DISTINCT source_sys_cd FROM EDW_DWH_CORE.ORGANIZATION 
SELECT * FROM EDW_DWH_CORE.ORGANIZATION WHERE source_sys_cd = '05_Product.Company_cd';

SELECT COUNT(ORZN_ID), COUNT(DISTINCT ORZN_ID) FROM EDW_DWH_CORE.ORGANIZATION 
WHERE source_sys_cd = '05_Product.Company_cd'
and to_char(END_DATE,'DD-MON-YYYY') = '01-JAN-9999'
--RESULT: 3 -> wrong result, it should be 1=AZ


    --2. Check if the count of distinct/non-distinct COMPANY_LOB in ORGANIZATION table matches with source. 
SELECT DISTINCT source_sys_cd FROM EDW_DWH_CORE.ORGANIZATION 
SELECT * FROM EDW_DWH_CORE.ORGANIZATION WHERE source_sys_cd = '05_Product.Company_lob';

SELECT COUNT(ORZN_ID), COUNT(DISTINCT ORZN_ID) FROM EDW_DWH_CORE.ORGANIZATION 
WHERE source_sys_cd = '05_Product.Company_lob'
and to_char(END_DATE,'DD-MON-YYYY') = '01-JAN-9999'
--RESULT: 3 -> wrong result, it should be 1=LIFE

    --3. Check 10 records company_cd, Company_Lob
SELECT * FROM EDW_DWH_CORE.ORGANIZATION WHERE TYPE_CODE = 'CMPNYLOB';

SELECT * FROM EDW_DWH_CORE.ORGANIZATION 
WHERE source_sys_cd = '05_Product.Company_lob'
  and CODE IN (
'life'
)  


  --SEQ5.PARTY_RLSHIP
select * from EDW_DWH_CORE.PARTY
select distinct source_sys_cd from EDW_DWH_CORE.PARTY
--select * from EDW_DWH_CORE.PARTY WHERE source_sys_cd = '05_Product.Company_cd';
select * from EDW_DWH_CORE.PARTY WHERE source_sys_cd = 'PARTY_DWH_Company_Cd_05_product';
--select * from EDW_DWH_CORE.PARTY WHERE source_sys_cd = '05_Product.Company_lob';
select * from EDW_DWH_CORE.PARTY WHERE source_sys_cd = 'PARTY_DWH_Company_lob_05_product';
select * from EDW_DWH_CORE.PARTY_RLSHIP WHERE NATURE = 'HASLOB';
select * from EDW_DWH_CORE.PARTY_RLSHIP
select distinct NATURE from EDW_DWH_CORE.PARTY_RLSHIP

    --Check if the ACTIVE count of (company_cd, company_lob) matches with the source
select COUNT(1) 
 from edw_dwh_core.party_rlship r, edw_dwh_core.party c, edw_dwh_core.party sch 
 where r.left_party_id = c.party_id
   and r.right_party_id = sch.party_id
   and c.source_sys_cd = 'PARTY_DWH_Company_Cd_05_product'
   and sch.source_sys_cd = 'PARTY_DWH_Company_lob_05_product'
   and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999'
   
select r.*
 from edw_dwh_core.party_rlship r, edw_dwh_core.party c, edw_dwh_core.party sch 
 where r.left_party_id = c.party_id
   and r.right_party_id = sch.party_id
   and c.source_sys_cd = 'PARTY_DWH_Company_Cd_05_product'
   and sch.source_sys_cd = 'PARTY_DWH_Company_lob_05_product'
   and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999'
   
   
  --SEQ6.PARTY_SPEC_RLSHIP
SELECT * FROM EDW_DWH_CORE.PARTY_SPEC_RLSHIP
  
  --SEQ7.CATEGORY
SELECT * FROM EDW_DWH_CORE.PRODUCT
SELECT DISTINCT TYPE_CODE, SOURCE_SYS_CD FROM EDW_DWH_CORE.CATEGORY 
--05_PRODUCT.PROD_CATEGORY, 05_PRODUCT.PRODUCT_LOB, 05_PRODUCT.PROD_TYPE, 05_PRODUCT.LOB_CATEGORY

    --1. check if the count of distinct/non-distinct PROD_CATEGORY matches with source file
SELECT * FROM EDW_DWH_CORE.CATEGORY WHERE source_sys_cd = '05_PRODUCT.PROD_CATEGORY';

SELECT COUNT(CAT_ID), COUNT(DISTINCT CAT_ID) FROM EDW_DWH_CORE.CATEGORY 
WHERE source_sys_cd = '05_PRODUCT.PROD_CATEGORY'
--and to_char(END_DATE,'DD-MON-YYYY') = '01-JAN-9999'

    --2. check if the count of distinct/non-distinct PROD_TYPE matches with source file
SELECT * FROM EDW_DWH_CORE.CATEGORY WHERE source_sys_cd = '05_PRODUCT.PROD_TYPE';

SELECT COUNT(CAT_ID), COUNT(DISTINCT CAT_ID) FROM EDW_DWH_CORE.CATEGORY 
WHERE source_sys_cd = '05_PRODUCT.PROD_TYPE'

    --3. check if the count of distinct/non-distinct PRODUCT_LOB matches with source file
SELECT * FROM EDW_DWH_CORE.CATEGORY WHERE source_sys_cd = '05_PRODUCT.PRODUCT_LOB';

SELECT COUNT(CAT_ID), COUNT(DISTINCT CAT_ID) FROM EDW_DWH_CORE.CATEGORY 
WHERE source_sys_cd = '05_PRODUCT.PRODUCT_LOB'

    --4. check if the count of distinct/non-distinct LOB_CATEGORY matches with source file
SELECT * FROM EDW_DWH_CORE.CATEGORY WHERE source_sys_cd = '05_PRODUCT.LOB_CATEGORY';

SELECT COUNT(CAT_ID), COUNT(DISTINCT CAT_ID) FROM EDW_DWH_CORE.CATEGORY 
WHERE source_sys_cd = '05_PRODUCT.LOB_CATEGORY'

    --5. check top 10 rows for each of the category
SELECT * FROM EDW_DWH_CORE.CATEGORY where SOURCE_SYS_CD IN
('05_PRODUCT.LOB_CATEGORY',
'05_PRODUCT.PRODUCT_LOB',
'05_PRODUCT.PROD_TYPE',
'05_PRODUCT.PROD_CATEGORY')

SELECT * FROM EDW_DWH_CORE.CATEGORY where BUS_CODE = 'HEALTH'

SELECT * FROM EDW_DWH_CORE.CATEGORY where BUS_CODE = 'Health'

SELECT * FROM EDW_DWH_CORE.CATEGORY where BUS_CODE = 'GROUP'

SELECT * FROM EDW_DWH_CORE.CATEGORY where BUS_CODE = 'Group'

SELECT * FROM EDW_DWH_CORE.CATEGORY where BUS_CODE = 'Individual'

SELECT * FROM EDW_DWH_CORE.CATEGORY where BUS_CODE = 'Syariah'

SELECT * FROM EDW_DWH_CORE.CATEGORY where BUS_CODE = 'Conventional'

SELECT * FROM EDW_DWH_CORE.CATEGORY where BUS_CODE = 'Life'

SELECT * FROM EDW_DWH_CORE.CATEGORY where BUS_CODE = 'Pension'

SELECT * FROM EDW_DWH_CORE.CATEGORY where BUS_CODE = 'UNIT LINK'

  --SEQ8.CATEGORY_DETAIL
SELECT * FROM EDW_DWH_CORE.CATEGORY
SELECT * FROM EDW_DWH_CORE.CATEGORY_DETAIL;
SELECT * FROM EDW_DWH_CORE.CATEGORY_DETAIL WHERE TYPE_CODE = 'PRODCAT';

    --1. check if the count of ACTIVE distinct/non-distinct PROD_CATEGORY matches with source file
select r.*
 from EDW_DWH_CORE.CATEGORY_DETAIL r, EDW_DWH_CORE.CATEGORY c
 where r.CAT_DET_ID = c.CAT_ID
   and c.source_sys_cd = '05_PRODUCT.PROD_CATEGORY'
    and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999'

select COUNT(1) 
 from EDW_DWH_CORE.CATEGORY_DETAIL r, EDW_DWH_CORE.CATEGORY c
 where r.CAT_DET_ID = c.CAT_ID
   and c.source_sys_cd = '05_PRODUCT.PROD_CATEGORY'
    and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999'
--RESULT = 7  -> It should display 4 = CONVENTIONAL, Conventional, SYARIAH, Syariah => Remove HEALTH, UNIT LINK, TRADITIONAL

    --2. check if the count of ACTIVE distinct/non-distinct PROD_TYPE matches with source file
select r.*
 from EDW_DWH_CORE.CATEGORY_DETAIL r, EDW_DWH_CORE.CATEGORY c
 where r.CAT_DET_ID = c.CAT_ID
   and c.source_sys_cd = '05_PRODUCT.PROD_TYPE'
    and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999'

select COUNT(1) 
 from EDW_DWH_CORE.CATEGORY_DETAIL r, EDW_DWH_CORE.CATEGORY c
 where r.CAT_DET_ID = c.CAT_ID
   and c.source_sys_cd = '05_PRODUCT.PROD_TYPE'
    and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999'
--RESULT = 9  -> It should display 6 = Traditional, TRADITIONAL, HEALTH, Health, UNIT LINK, Unit Link => Remove PENSION, LIFE, SAVING & double HEALTH, instead Health

    --3. check if the count of ACTIVE distinct/non-distinct PRODUCT_LOB matches with source file
select r.*
 from EDW_DWH_CORE.CATEGORY_DETAIL r, EDW_DWH_CORE.CATEGORY c
 where r.CAT_DET_ID = c.CAT_ID
   and c.source_sys_cd = '05_PRODUCT.PRODUCT_LOB'
    and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999'

select COUNT(1) 
 from EDW_DWH_CORE.CATEGORY_DETAIL r, EDW_DWH_CORE.CATEGORY c
 where r.CAT_DET_ID = c.CAT_ID
   and c.source_sys_cd = '05_PRODUCT.PRODUCT_LOB'
    and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999'
--RESULT = 6  -> It should display 4 = Life, Health, Pension, Saving => remove GROUP & INDIVIDUAL

    --4. check if the count of ACTIVE distinct/non-distinct LOB_CATEGORY matches with source file
select r.*
 from EDW_DWH_CORE.CATEGORY_DETAIL r, EDW_DWH_CORE.CATEGORY c
 where r.CAT_DET_ID = c.CAT_ID
   and c.source_sys_cd = '05_PRODUCT.LOB_CATEGORY'
    and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999'

select COUNT(1) 
 from EDW_DWH_CORE.CATEGORY_DETAIL r, EDW_DWH_CORE.CATEGORY c
 where r.CAT_DET_ID = c.CAT_ID
   and c.source_sys_cd = '05_PRODUCT.LOB_CATEGORY'
    and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999'
--RESULT = 4  -> It should display 2 = Group, Individual => remove B2C, B2B

    --5. check top 10 rows for each of the category
select r.*
 from EDW_DWH_CORE.CATEGORY_DETAIL r, EDW_DWH_CORE.CATEGORY c
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
   
  --SEQ9.SPEC_CAT_RLSHIP
SELECT DISTINCT SOURCE_SYS_CD FROM EDW_DWH_CORE.CATEGORY;
SELECT * FROM EDW_DWH_CORE.CATEGORY where SOURCE_SYS_CD = '05_PRODUCT.PROD_CATEGORY';
SELECT * FROM EDW_DWH_CORE.CATEGORY where CAT_ID = '1';
SELECT * FROM EDW_DWH_CORE.CATEGORY where CAT_ID = '2';
SELECT * FROM EDW_DWH_CORE.CATEGORY where SOURCE_SYS_CD = '05_PRODUCT.PROD_TYPE';
SELECT * FROM EDW_DWH_CORE.CATEGORY where SOURCE_SYS_CD = '05_PRODUCT.PRODUCT_LOB';
SELECT * FROM EDW_DWH_CORE.CATEGORY where SOURCE_SYS_CD = '05_PRODUCT.LOB_CATEGORY';

select * from EDW_DWH_CORE.SPECIFICATION;
SELECT DISTINCT SOURCE_SYS_CD FROM EDW_DWH_CORE.SPECIFICATION;
select * from EDW_DWH_CORE.SPEC_CAT_RLSHIP WHERE NATURE = 'INCLD';

      --1. check if the count of distinct/non-distinct (product, PROD_CATEGORY) combination matches with source file
select r.*
 from EDW_DWH_CORE.SPEC_CAT_RLSHIP r, EDW_DWH_CORE.CATEGORY c 
 --EDW_DWH_CORE.CATEGORY sch
 where r.SPEC_CAT_RLS_ID = c.CAT_ID
 and c.source_sys_cd = '05_PRODUCT.PROD_CATEGORY'
 
 select COUNT(1)
 from EDW_DWH_CORE.SPEC_CAT_RLSHIP r, EDW_DWH_CORE.CATEGORY c 
 --EDW_DWH_CORE.CATEGORY sch
 where r.SPEC_CAT_RLS_ID = c.CAT_ID
 and c.source_sys_cd = '05_PRODUCT.PROD_CATEGORY'
 
 --RESULT: Same with category 7 product_Category, but actually it should be 4 product_category
 
      --2. check if the count of distinct/non-distinct (product, PROD_TYPE) combination  matches with source file
select r.*
 from EDW_DWH_CORE.SPEC_CAT_RLSHIP r, EDW_DWH_CORE.CATEGORY c 
 --EDW_DWH_CORE.CATEGORY sch
 where r.SPEC_CAT_RLS_ID = c.CAT_ID
 and c.source_sys_cd = '05_PRODUCT.LOB_CATEGORY'
 
 select COUNT(1)
 from EDW_DWH_CORE.SPEC_CAT_RLSHIP r, EDW_DWH_CORE.CATEGORY c 
 --EDW_DWH_CORE.CATEGORY sch
 where r.SPEC_CAT_RLS_ID = c.CAT_ID
 and c.source_sys_cd = '05_PRODUCT.LOB_CATEGORY'      
 
 --RESULT: Same with category 9 product_Type, but actually it should be 6 product_type

      --3. check if the count of distinct/non-distinct (proudct, PRODUCT_LOB) combination matches with source file
select r.*
 from EDW_DWH_CORE.SPEC_CAT_RLSHIP r, EDW_DWH_CORE.CATEGORY c 
 --EDW_DWH_CORE.CATEGORY sch
 where r.SPEC_CAT_RLS_ID = c.CAT_ID
 and c.source_sys_cd = '05_PRODUCT.PRODUCT_LOB'
 
 select COUNT(1)
 from EDW_DWH_CORE.SPEC_CAT_RLSHIP r, EDW_DWH_CORE.CATEGORY c 
 --EDW_DWH_CORE.CATEGORY sch
 where r.SPEC_CAT_RLS_ID = c.CAT_ID
 and c.source_sys_cd = '05_PRODUCT.PRODUCT_LOB'      
 
 --RESULT: Same with category 6 product_LOB, but actually it should be 4 product_LOB
 
      --4. check if the count of distinct/non-distinct (proudct, LOB_CATEGORY) combination matches with source file
select r.*
 from EDW_DWH_CORE.SPEC_CAT_RLSHIP r, EDW_DWH_CORE.CATEGORY c 
 --EDW_DWH_CORE.CATEGORY sch
 where r.SPEC_CAT_RLS_ID = c.CAT_ID
 and c.source_sys_cd = '05_PRODUCT.LOB_CATEGORY'
 
 select COUNT(1)
 from EDW_DWH_CORE.SPEC_CAT_RLSHIP r, EDW_DWH_CORE.CATEGORY c 
 --EDW_DWH_CORE.CATEGORY sch
 where r.SPEC_CAT_RLS_ID = c.CAT_ID
 and c.source_sys_cd = '05_PRODUCT.LOB_CATEGORY'      
 
 --RESULT: Same with category 4 product_LOB_Category, but actually it should be 2 product_LOB_Category
 
      --5. check top 10 rows for each of the (proudct, the above category) combination matches with source file
select r.*
 from EDW_DWH_CORE.SPEC_CAT_RLSHIP r, EDW_DWH_CORE.CATEGORY c
 where r.SPEC_CAT_RLS_ID = c.CAT_ID
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
   
--RESULT: Different CAT_ID in SPEC_CAT_RLSHIP
   
SELECT * FROM EDW_DWH_CORE.CATEGORY where CAT_ID = '1';  
SELECT * FROM EDW_DWH_CORE.SPECIFICATION where SPEC_ID = '1';
SELECT * FROM EDW_DWH_CORE.SPEC_CAT_RLSHIP where CAT_ID = '1'; 



