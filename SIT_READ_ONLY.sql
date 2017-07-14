select count from (SELECT b.DOC_ID,
c.AGMT_ID,
a.EXISTENCE EXIST_FLAG,
a.RECEIVED_DATE RECV_DATE,
a.REMARK REMARKS,
sysdate AS EXTRACT_DATE
FROM
(SELECT EXISTENCE,
RECEIVED_DATE,
REMARK,
DOC_CODE,
REFERENCE_NO
FROM AZLI_NBFM_SUB_DOC_COMP_DTL
) a,
dwh_core.DOCUMENT b,
dwh_core.AGREEMENT c
WHERE upper(a.DOC_CODE) =upper(b.BUS_CODE)
AND b.Source_Sys_Cd = 'OPIL.AZLI_NBFM_SUB_DOC'
AND upper(a.REFERENCE_NO) =upper(c.BUS_CODE)
AND c.Source_Sys_Cd = 'OPIL.AZLI_NBFM_SUB_DOC_COMP')


ALTER SESSION SET CURRENT_SCHEMA= DWH_DM


select a.channel_code, from_date, a.to_date, comp_period_id
from azli_comp_period_bancass a
inner join (select channel_code, max(TO_DATE) TO_DATE
from azli_comp_period_bancass
where payment_period = 2
group by channel_code) b on a.channel_code = b.channel_code and a.To_date = b.TO_DATE and a.payment_period= 2
order by a.channel_code