alter session set current_schema = DWH_CORE;

--TRANSACTIONS
  --CODE
select * from CODE;

 select COUNT (1) from CODE;
 
 select * from CODE WHERE CODE_TYPE_ID = '1';

 select COUNT (1) from CODE where CODE_TYPE_ID = '1';
 
 
 
 select * from CODE WHERE CODE_TYPE_ID = '2';

 select COUNT (1) from CODE where CODE_TYPE_ID = '2';
 
    --1. Check the count of active records from opus and this table
select c.* 
  from code c, code_type ct
 where c.code_type_id = ct.code_type_id
   and c.code_type_id = '1'

select count(1) 
  from code c, code_type ct
 where c.code_type_id = ct.code_type_id
   and c.code_type_id = '1'   
--RESULT: 28

select c.* 
  from code c, code_type ct
 where c.code_type_id = ct.code_type_id
   and c.code_type_id = '2'

select count(2) 
  from code c, code_type ct
 where c.code_type_id = ct.code_type_id
   and c.code_type_id = '2'   
--RESULT: 174   
   
    --2. Check 10 rows of the above and see that the source and target table matches
select c.* 
  from code c, code_type ct
 where c.code_type_id = ct.code_type_id
   and CODE_LBL IN (
   'FLPREM',
   'FLSUPFEE',
   'FLTOPUP',
   'FRL',
   'FSWCORR',
   'FLMTYCHGSP',
   'FLPOLFEERP',
   'FLPOLFEESP',
   'FLPRMFY',
   'FLPRMRY')
   
  
  --CODE_TYPE
    --1. Check the count of active recrods from opus and this table
select * from CODE_TYPE;

select count(1) from CODE_TYPE;


  --FINANCIAL_TRANSACTION
    --1. Check the count of active recrods from opus and this table
Select * from FINANCIAL_TRANSACTION;


  --FIN_TOPUP_TRANSACTION
    --1. Check the count of active recrods from opus and this table
Select * from FIN_TOPUP_TRANSACTION;

