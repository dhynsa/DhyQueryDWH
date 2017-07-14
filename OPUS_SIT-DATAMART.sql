--38.FCT_SOA_DETAIL -OPUS
  --1. Match Count for each channel, each month and year
  
  --2. Match 10 records from source and target for two different months for each channel

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