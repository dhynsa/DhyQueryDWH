--DATA MART
ALTER SESSION SET CURRENT_SCHEMA= DWH_DM;

--DIM_POLICY
-- Note:SQLServer Only can running this query - LIFE-DW
  Select * from dbo.Policy_Records where PR_SOURCE = 'O'
 
  --1. Count policy_no in this table and match with the LifeDW Policy_Records table with Source <> 'H'
  --2. Check 10 Policy for specific approved date,10 Policy of Receive_Date, 10 policy of Entry_Date, 10 Policy of Prod_date, 10 policy of Approve_date. Match the count, sum of amount fileds and other fields.
  
  
--PARAM_DATE


-- 6. DIM_ASN_PRD_ANP_RNG
  --1. Count the number of records with active records in this table.
select * from DIM_ASN_PRD_ANP_RNG;
select count (1) from DIM_ASN_PRD_ANP_RNG;
  --2. Match 10 records.
select * from DIM_ASN_PRD_ANP_RNG where product_cd IN (
'BASE_ASBA',
'BASE_ASMFP',
'BASE_ASPOA',
'BASE_MYEDU',
'BASE_MYF50',
'BASE_MYF55',
'BASE_MYF60',
'BASE_MYPRO',
'BASE_RASP',
'BASE_RLNFA');

-- 24. FCT_ASN_AGNT_DEDUCT_VAL
  --1. Count the number of records in the file. It should match with active records of the table.
select * from FCT_ASN_AGNT_DEDUCT_VAL; 
select count(1) from FCT_ASN_AGNT_DEDUCT_VAL;

  --2. Match 10 records from file to this table. Get the Account Closing Date from DIM_DATE. 
select * from FCT_ASN_AGNT_DEDUCT_VAL where agent_code IN (
'00837585',
'00881153',
'00897881',
'00848573',
'00885606',
'00834726',
'00838589',
'00864348',
'00871169',
'00835881')

-- 25.FCT_ASN_MDRT_CNT
  --1. Count the number of records in the file. It should match with active records of the table. 
select * from FCT_ASN_MDRT_CNT;
select * from FCT_ASN_MDRT_CNT where monthno = '201612' order by 4;
select count(1) from FCT_ASN_MDRT_CNT where monthno = '201612';
--RESULT: 6
select * from DIM_DATE;
select count(1) from DIM_DATE;
select * from dim_date where monthno = '201612' order by 2;
  --2. Match 10 records from file to this table. Get the Account Closing Date from DIM_DATE. 
  
select r.*
 from DIM_DATE r,  FCT_ASN_MDRT_CNT c
 where r.monthno = c.monthno
   and c.account_closing_dt = '20161231'
   

select * from FCT_ASN_MDRT_CNT where monthno = '201612' order by 4;


-- 26.FCT_ASN_YYYYMDRT_VAL
select * from FCT_ASN_YYYYMDRT_VAL;
  --1. Count agent_code and distinct account code in the file. It should match with the active records.
select count(1) from FCT_ASN_YYYYMDRT_VAL;
--RESULT: 26886 - SAME WITH USER TABLE (Excel)
select distinct agent_code from FCT_ASN_YYYYMDRT_VAL;
select count (distinct agent_code) from FCT_ASN_YYYYMDRT_VAL;

select distinct MDRT_STATUS from FCT_ASN_YYYYMDRT_VAL;
select count (distinct MDRT_STATUS) from FCT_ASN_YYYYMDRT_VAL;
  --2. Match 10 records from file to this table. 
select * from FCT_ASN_YYYYMDRT_VAL where agent_code IN (
'00835691',
'00880639',
'00847118',
'00837510',
'00892931',
'00897879',
'00905884',
'00861907',
'00746350',
'00900411')

-- 37.FCT_SOA_DEDUCT_OTHR
select * from FCT_SOA_DEDUCT_OTHR;

select * from FCT_SOA_DEDUCT_OTHR where SUBCHANNEL_CD = 'B-EAGLE 3';

  --1. Match Count for each channel, each month and year
select count(1) from FCT_SOA_DEDUCT_OTHR;
select distinct subchannel_cd from FCT_SOA_DEDUCT_OTHR;
select count (distinct subchannel_cd) from FCT_SOA_DEDUCT_OTHR;

select distinct product_cd from FCT_SOA_DEDUCT_OTHR;
select count (distinct product_cd) from FCT_SOA_DEDUCT_OTHR;


select distinct monthno from FCT_SOA_DEDUCT_OTHR;
select count (distinct monthno) from FCT_SOA_DEDUCT_OTHR;

select subchannel_cd, agent_code, agent_name, referal_code, referal_name, referal_branch, policy_no, product_cd, product_name, trans_type, currency, year_num,commision, monthno 
from FCT_SOA_DEDUCT_OTHR where SUBCHANNEL_CD = 'B-EAGLE 3'; 


  --2. Match 10 records from source and target for two different months for each channel
select subchannel_cd, agent_code, agent_name, referal_code, referal_name, referal_branch, policy_no, product_cd, product_name, trans_type, currency, year_num,commision, monthno 
from FCT_SOA_DEDUCT_OTHR where policy_no IN (
'FERS0-016000',
'NJONU-016000',
'TANKN-016000',
'VONSE-116000',
'000030099283',
'MAILM-016000')


--44-XREF_BTPN_POLICY_SERV_AGENT
select * from XREF_BTPN_POLICY_SERV_AGENT;
  --1. For the year/month, check the count of distinct policies, servicing agent code, bank partner. It should match
 select count (distinct policy_no), count (distinct serv_agent_code), count (distinct subchannel_cd) from XREF_BTPN_POLICY_SERV_AGENT;
  --2. Match 20 records from source and target select distinct policy_no from XREF_BTPN_POLICY_SERV_AGENT;
select * from XREF_BTPN_POLICY_SERV_AGENT where policy_no IN (
'000046096960',
'000046126320',
'000046168769',
'000046170100',
'000046170756',
'000046379526',
'000046457880',
'000046494152',
'000046508971',
'000046629433',
'000046743925',
'000046773328',
'000046807490',
'000046917359',
'000047003778',
'000047050335',
'000047111971',
'000047251043',
'000044218429',
'000044511528')


-- 28. FCT_MTHLY_BRANCH_AGG
select * from FCT_MTHLY_BRANCH_AGG where subchannel_cd = 'BTPN';

select distinct REF_BRANCH_CD from FCT_MTHLY_BRANCH_AGG where subchannel_cd = 'BTPN';
      
select distinct subchannel_cd from FCT_MTHLY_BRANCH_AGG;

-- 20. FCT_ACCOUNT_BALANCE
alter session set current_schema = dwh_dm;
select * from FCT_ACCOUNT_BALANCE
select count(1) from FCT_ACCOUNT_BALANCE;

-- 23. FCT_APPL_SUTRA
select * from FCT_APPL_SUTRA where appl_subchannel_cd = 'ANZ';

select distinct appl_subchannel_cd from FCT_APPL_SUTRA