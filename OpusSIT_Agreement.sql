
select * from AZLI_NBFM_SUB_DOC_COMP;

--AGREEMENT
  --AGREEMENT
   --1. Check if the count of  (source_sys_cd = 'OPIL.AZLI_NBFM_SUB_DOC_COMP') combination matches the OPUS.
select count(1) from AZLI_NBFM_SUB_DOC_COMP;

    --2. Check the combination BUS_CODE with REFERENCE_NUMBER for first 10 records 
select * from AZLI_NBFM_SUB_DOC_COMP
where REFERENCE_NO IN (
'00129138',
'0000000001',
'0000000003',
'0000000006',
'0000166935',
'0000474781',
'0000474810',
'0000476807',
'0000559569',
'0000559576',
'0000559643');


 --DOCUMENT
select * from AZLI_NBFM_SUB_DOC;
select count(1) from AZLI_NBFM_SUB_DOC;
select distinct doc_code from AZLI_NBFM_SUB_DOC;

 --DOCUMENT_DETAIL
select * from  AZLI_NBFM_SUB_DOC;


select * from  AZLI_NBFM_SUB_DOC 
where DOC_CODE IN
(
'D059',
'D060',
'D061',
'D062',
'D063',
'D064',
'D065',
'D066',
'D067',
'D068');

select * from AZLI_NBFM_SUB_DOC_COMP_DTL;

select count(1) from AZLI_NBFM_SUB_DOC_COMP_DTL;


 
  --INSURANCE_PROPOSAL
  select * from AZLI_NBFM_SUB_DOC_COMP;
select REFERENCE_NO, FYP_IDR, FYP_USD from AZLI_NBFM_SUB_DOC_COMP
where REFERENCE_NO IN
   (
   '0011996430',
   '0011074513',
   '0011074484',
   '0011074446',
   '0011074477',
   '0011060715',
   '5002969271',
   '0011576469',
   '0011064146',
   '0011725211');
   
   
--check issue




