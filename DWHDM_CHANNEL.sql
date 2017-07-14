--DATAMART
ALTER SESSION SET CURRENT_SCHEMA=DWH_DM
  --DIM_CHANNEL
    --1. Count the number of records in the file and active records of the table.
select * from DIM_CHANNEL;    
select count (distinct SUBCHANNEL_ID) from DIM_CHANNEL;

    --2. Match 10 records from Channel Master Table. The Table SubChannel Desc is source's Subchannel display name from Channel Master table. 
SELECT * FROM DIM_CHANNEL 
WHERE SUBCHANNEL_CD IN (
'BTPN',
'HSBC',
'Maybank',
'ANZ',
'EKONOMI',
'BCI',
'BMI',
'BUMIPUTERA',
'CITIBANK',
'DANAMON')


    --3. Match 10 records from Bank Parter table for the three fields.
SELECT * FROM DIM_CHANNEL
WHERE SUBCHANNEL_CD in(
'BTPN',
'HSBC',
'Maybank',
'ANZ',
'EKONOMI',
'BCI',
'BMI',
'BUMIPUTERA',
'CITIBANK',
'DANAMON',
'DBS',
'NISP',
'PERMATA',
'RBS',
'SCB')
