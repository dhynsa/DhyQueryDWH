alter session set current_schema = DWH_CORE;
--EXCHANGE RATE
  --EXCHANGE_RATE
    --1. Check the count of active recrods from opus and this table
select *
from EXCHANGE_RATE;

select count(1)
from EXCHANGE_RATE;

    --2. Check 10 rows of the above and see that the source and target table matches
select *
from EXCHANGE_RATE where sell_rate IN (
'2500',
'5150',
'8525',
'7600',
'10095',
'10010',
'10015',
'10035',
'9975',
'10030');


select * from EXCHANGE_RATE where status = 'P'



select count (status) from EXCHANGE_RATE where status = 'A';