select *
from AZLI_CURR_EXCHANGE_RATE;

select count(1)
from AZLI_CURR_EXCHANGE_RATE;

select *
from AZLI_CURR_EXCHANGE_RATE where selling_rate IN (
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

select distinct status from AZLI_CURR_EXCHANGE_RATE; 

select * from AZLI_CURR_EXCHANGE_RATE where status = 'P';


select * from AZLI_CURR_EXCHANGE_RATE where status = 'A';

select count (status) from AZLI_CURR_EXCHANGE_RATE where status = 'A';