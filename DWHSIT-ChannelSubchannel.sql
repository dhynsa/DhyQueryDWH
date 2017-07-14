--learn
--select * from EDW_DWH_CORE.CHANNEL WHERE EXCL_FLAG= 'N';

--select count( distinct bus_code), count(bus_code) from edw_dwh_core.party where source_sys_cd = 'OPIL.AZLI_DMT_ORG_UNITS';

--select count( distinct channel_code) from EDW_DWH_CORE.CHANNEL where BANCA_RPT_FLAG= 'ACTIVE';

--select count( distinct subchannel_cd) from EDW_DWH_CORE.CHANNEL where BANCA_RPT_FLAG= 'ACTIVE';


--01-02-CHANNEL_SUBCHANNEL/BANK_PARTNER
  --SEQ1.PARTY
select * from EDW_DWH_CORE.PARTY;
select * from EDW_DWH_CORE.PARTY WHERE source_sys_cd = '01_CHANNEL_MASTER.CHANNEL_CD';
select * from EDW_DWH_CORE.PARTY WHERE source_sys_cd = '01_CHANNEL_MASTER.SUBCHANNEL_CD';

select * from EDW_DWH_CORE.PARTY where bus_code = 'BPR';

    --1. Check count of distinct Channel_Cd present in source is present in the party table
select count (distinct party_id) from EDW_DWH_CORE.PARTY WHERE source_sys_cd = '01_CHANNEL_MASTER.CHANNEL_CD';
--RESULT: Same with right source channel_master = 6 

    --2. Check count of distinct SubChannel_Cd is present in the party table 
select count (distinct party_id) from EDW_DWH_CORE.PARTY WHERE source_sys_cd = '01_CHANNEL_MASTER.SUBCHANNEL_CD';
--RESULT: Same with right source channel_master = 46 


--01-02-CHANNEL_SUBCHANNEL/BANK_PARTNER
  --SEQ2.ORGANIZATION
SELECT * FROM EDW_DWH_CORE.ORGANIZATION;

    --1. check if the count of ACTIVE distinct channel_cd matches with source. 
    --See that SQL includes the anchor table, party_id is present in the party table.
SELECT * FROM EDW_DWH_CORE.ORGANIZATION 
WHERE source_sys_cd = '01_CHANNEL_MASTER.CHANNEL_CD'
  and to_char(END_DATE,'DD-MON-YYYY') = '01-JAN-9999'
--RESULT:

    --2. same as above for subchannel_cd
SELECT * FROM EDW_DWH_CORE.ORGANIZATION 
WHERE source_sys_cd = '01_CHANNEL_MASTER.SUBCHANNEL_CD'
  and to_char(END_DATE,'DD-MON-YYYY') = '01-JAN-9999'
--RESULT

    --3. For 10 records check if the channel cd, description, display matches with source 
SELECT code, name, descr FROM EDW_DWH_CORE.ORGANIZATION 
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
'CIMBNIAGA')
--RESULT: 1. SubChannel_Cd and SubChannel_Desc are different with the right source in Channel_Master
--        2. THe order also was wrong
--order should be matched
--SELECT * FROM EDW_DWH_CORE.ORGANIZATION 
--WHERE source_sys_cd = '01_CHANNEL_MASTER.CHANNEL_CD' 
SELECT code, descr, name FROM EDW_DWH_CORE.ORGANIZATION 
WHERE source_sys_cd = '01_CHANNEL_MASTER.SUBCHANNEL_CD' 


--01-02-CHANNEL_SUBCHANNEL/BANK_PARTNER
  --SEQ3.PARTY_RLSHIP
select * from EDW_DWH_CORE.PARTY
select * from EDW_DWH_CORE.PARTY WHERE source_sys_cd = '01_CHANNEL_MASTER.CHANNEL_CD';
select * from EDW_DWH_CORE.PARTY WHERE source_sys_cd = '01_CHANNEL_MASTER.SUBCHANNEL_CD';
select * from EDW_DWH_CORE.PARTY_RLSHIP WHERE NATURE = 'HASSBCHNL';
select * from EDW_DWH_CORE.PARTY_RLSHIP

    --1. Check if the count of  (active channel_cd, active subchannel_cd) combination matches the source.
select COUNT(1) 
 from edw_dwh_core.party_rlship r, edw_dwh_core.party c, edw_dwh_core.party sch 
 where r.left_party_id = c.party_id
   and r.right_party_id = sch.party_id
   and c.source_sys_cd = '01_CHANNEL_MASTER.CHANNEL_CD'
   and sch.source_sys_cd = '01_CHANNEL_MASTER.SUBCHANNEL_CD'
   and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999'

--RESULT: Same with right source channel_master 

    --2. Check the combination for first 10 records
SELECT r.*
 from dwh_core.party_rlship r, dwh_core.party c, dwh_core.party sch 
 where r.left_party_id = c.party_id
   and r.right_party_id = sch.party_id
   and c.source_sys_cd = '01_CHANNEL_MASTER.CHANNEL_CD'
   and sch.source_sys_cd = '01_CHANNEL_MASTER.SUBCHANNEL_CD'
   and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999'    
   AND r.right_party_id IN (
'3509279',
'3509281',
'3509283',
'3509287',
'3509289',
'3509299',
'3509301',
'3509305',
'3509310',
'3509313')

--OR

SELECT r.*
 from edw_dwh_core.party_rlship r, edw_dwh_core.party c, edw_dwh_core.party sch  
 where r.left_party_id = c.party_id
   and r.right_party_id = sch.party_id
   and c.source_sys_cd = '01_CHANNEL_MASTER.CHANNEL_CD'
   and sch.source_sys_cd = '01_CHANNEL_MASTER.SUBCHANNEL_CD'
   and to_char(r.END_DATE,'DD-MON-YYYY') = '01-JAN-9999'    
    AND c.BUS_CODE IN (
'RBS',
'PERTAMINA',
'MBSS',
'AE',
'DBS',
'BCI',
'SPRING',
'CITIBANK',
'NISP',
'AZID')


--01-02-CHANNEL_SUBCHANNEL/BANK_PARTNER
  --SEQ4.CHANNEL  
select * from EDW_DWH_CORE.CHANNEL;
    --Make random check for 10 records for which the subchannel code must have same values for three columns: Exclusivity Flag(Y/N),"BANCA reporting
    --(Active / Inactive / NA)",Banca Additional Flag(A/O/N)
SELECT SUBCHANNEL_CD, EXCL_FLAG, BANCA_RPT_FLAG, BANCA_ADDL_FLAG FROM EDW_DWH_CORE.CHANNEL 
WHERE SUBCHANNEL_CD IN (
'BTPN',
'HSBC',
'MAYBANK',
'ANZ',
'EKONOMI',
'BCI',
'BMI',
'BUMIPUTERA',
'CITIBANK',
'DANAMON')
--RESULT: Same with right source channel_master


