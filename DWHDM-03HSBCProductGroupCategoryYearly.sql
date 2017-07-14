
ALTER SESSION SET CURRENT_SCHEMA=DWH_DM;
  --DIM_HSBC_PRD_GRP
    --1. Count the number of records in the file. It should match with active records of the table. 

select * from DIM_HSBC_PRD_GRP

select count (distinct PRODUCT_CD) from DIM_HSBC_PRD_GRP;

select COUNT(1) from DIM_HSBC_PRD_GRP where Product_cd IN (    
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
'Credit Care Plus' );
    
    --2. Match 10 records from file to this table. 
select * from DIM_HSBC_PRD_GRP where Product_cd IN (    
'BASE_SHCP', --
'BASE_SHSNW',
'BASE_CPRA',
'BASE_OPCI',
'BASE_SHRE',
'BASE_SHFC',
'BASE_FRC50',
'BASE_CLLGC',
'BASE_HSCIP',
'BASE_ASFA', --
'Credit Care Plus' ); --