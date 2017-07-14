alter session set current_schema = DWH_CORE;

select * from agreement;

Select distinct source_sys_cd from agreement;

--AGREEMENT
  --AGREEMENT
    --1. Check if the count of  (source_sys_cd = 'OPIL.AZLI_NBFM_SUB_DOC_COMP') combination matches the OPUS.

select * from agreement where source_sys_cd = 'OPIL.AZLI_NBFM_SUB_DOC_COMP'

select count(1) from agreement where source_sys_cd = 'OPIL.AZLI_NBFM_SUB_DOC_COMP'  

    --2. Check the combination BUS_CODE with REFERENCE_NUMBER for first 10 records 

select * from agreement 
where source_sys_cd = 'OPIL.AZLI_NBFM_SUB_DOC_COMP'
and bus_code IN (
'0000000001',
'0000000003',
'0000000006',
'0000166935',
'0000474781',
'0000474810',
'0000476807',
'0000559569',
'0000559576',
'0000559643')

--?
select * from agreement 
where source_sys_cd = 'OPIL.AZLI_NBFM_SUB_DOC_COMP'
and bus_code = '00129138'
--?


  --DOCUMENT
    --1. type_code should not blank, type_code should 'DOCDTL'
select * from document;
select count(1) from document;
select * from document where type_code = ' ';

    --2. source_sys_cd should not blank
select * from document where source_sys_cd ='OPIL.AZLI_NBFM_SUB_DOC';
select * from document where source_sys_cd =' ';

    --3. bus_code should not blank
select * from document where BUS_CODE =' ';

    --4. No duplicate data grouping by bus_code
select distinct bus_code from document;


  --DOCUMENT_DETAIL
    --1. type_code should not blank, type_code should 'DOC'
select * from document_detail;
select count(1) from document_detail;

select dd.* 
  from document_detail dd, document d
 where dd.doc_id = d.doc_id
   and d.type_code = 'DOCDTL'

    --2. start_date should not blank
select dd.* 
  from document_detail dd, document d
 where dd.doc_id = d.doc_id
   and d.type_code = 'DOCDTL'
   and dd.start_date >= to_date('22-MAY-17', 'DD-MON-YY')
   
    --3. end_date should not blank
select dd.* 
  from document_detail dd, document d
 where dd.doc_id = d.doc_id
   and d.type_code = 'DOCDTL'
   and dd.end_date >= to_date('01-JAN-99', 'DD-MON-YY')
   
    --4. No duplicate data grouping by doc_cd
select distinct dd.doc_cd 
  from document_detail dd, document d
 where dd.doc_id = d.doc_id
    
    --5. Doc_id should link with doc_id on table document
select dd.* 
  from document_detail dd, document d
 where dd.doc_id = d.doc_id
 
 select dd.* 
  from document_detail dd, document d
 where dd.doc_id = d.doc_id
 and doc_cd in
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


     --DOC_AGMT_RLSHIP
      --1. nature should not blank, nature should 'HASDOCUMENT'
select * from DOC_AGMT_RLSHIP where NATURE = 'HASDOCUMENT';

select COUNT(1) from DOC_AGMT_RLSHIP where NATURE = 'HASDOCUMENT';  

      --2. start_date should not blank
select * from DOC_AGMT_RLSHIP WHERE to_char(START_DATE,'DD-MON-YYYY') = '00-00-0000'  

      --3. end_date should not blank
select * from DOC_AGMT_RLSHIP WHERE to_char(END_DATE,'DD-MON-YYYY') = '00-00-0000' 

      --4. agmt_id should not blank
select * from DOC_AGMT_RLSHIP WHERE agmt_id = '';

      --5. agmt_id should link with agmt_id on table agreement where source_sys_cd = 'OPIL.AZLI_NBFM_SUB_DOC_COMP' and agreement.type_code = 'PROPOSAL'
select dr.* 
  from doc_agmt_rlship dr, agreement a
 where dr.agmt_id = a.agmt_id
   and a.source_sys_cd = 'OPIL.AZLI_NBFM_SUB_DOC_COMP'
   and a.type_code = 'PROPOSAL';
   
select count(1) 
  from doc_agmt_rlship dr, agreement a
 where dr.agmt_id = a.agmt_id
   and a.source_sys_cd = 'OPIL.AZLI_NBFM_SUB_DOC_COMP'
   and a.type_code = 'PROPOSAL';

      --6. doc_id should link with doc_id on table document
select dr.* 
  from doc_agmt_rlship dr, document d
 where dr.doc_id = d.doc_id;

select count(1) 
  from doc_agmt_rlship dr, document d
 where dr.doc_id = d.doc_id;
 
 
--CHECK ISSUE
select count(1) 
  from doc_agmt_rlship dr, agreement a
 where dr.agmt_id = a.agmt_id
   and a.source_sys_cd = 'OPIL.AZLI_NBFM_SUB_DOC_COMP'
   and a.type_code = 'PROPOSAL';

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
 
 
 
 
 
  --INSURANCE_PROPOSAL
select * from INSURANCE_PROPOSAL
    --1. type_code should not blank, type_code should 'PROPOSAL'
select * from INSURANCE_PROPOSAL where type_code = ' ';

    --2. start_date should not blank
select * from INSURANCE_PROPOSAL WHERE to_char(START_DATE,'DD-MON-YYYY') = ' ';  

    --3. end_date should not blank
select * from INSURANCE_PROPOSAL WHERE to_char(END_DATE,'DD-MON-YYYY') = ' ';  

    --4. agmt_id should not blank
select * from INSURANCE_PROPOSAL WHERE AGMT_ID = ' ';

    --5. agmt_id should link with agmt_id on table agreement where source_sys_cd = 'OPIL.AZLI_NBFM_SUB_DOC_COMP' and agreement.type_code = 'PROPOSAL'
select ip.* 
  from INSURANCE_PROPOSAL ip, agreement a
 where ip.agmt_id = a.agmt_id
   and a.source_sys_cd = 'OPIL.AZLI_NBFM_SUB_DOC_COMP'
   and a.type_code = 'PROPOSAL';
   
select count(1) 
  from INSURANCE_PROPOSAL ip, agreement a
 where ip.agmt_id = a.agmt_id
   and a.source_sys_cd = 'OPIL.AZLI_NBFM_SUB_DOC_COMP'
   and a.type_code = 'PROPOSAL';

    --6. No duplicate data grouping by appl_no
select distinct appl_no  from INSURANCE_PROPOSAL ip, agreement a
 where ip.agmt_id = a.agmt_id
   and a.source_sys_cd = 'OPIL.AZLI_NBFM_SUB_DOC_COMP'
   and a.type_code = 'PROPOSAL';

select count(distinct appl_no)  from INSURANCE_PROPOSAL ip, agreement a
 where ip.agmt_id = a.agmt_id
   and a.source_sys_cd = 'OPIL.AZLI_NBFM_SUB_DOC_COMP'
   and a.type_code = 'PROPOSAL'; 
--RESULT: ANY DUPLICATE APPL_NO   
   
    --7. Please random check for serveral appl_no and make sure FYP_IDR and FYP_USD is correct. (see mahesh sheet in excel sit consolidated)
select appl_no, fyp_idr, fyp_usd from INSURANCE_PROPOSAL
 where appl_no IN
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


  --INSURANCE_ROLE
    --1.  Row count of active insurance_role where type_code = 'POLHOLD' must be equal with total record of active insurance_contract
select * from INSURANCE_ROLE; 
select count (1) from INSURANCE_ROLE where type_code = 'POLHOLD';   
select * from INSURANCE_CONTRACT;   
select count (1) from INSURANCE_CONTRACT;
--RESULT: equal = 1332306

    --2.  the start_date should not blank
select * from INSURANCE_ROLE where to_char(START_DATE,'DD-MON-YYYY') = ' '; 

    --3.  the end_date should not blank
select * from INSURANCE_ROLE where to_char(END_DATE,'DD-MON-YYYY') = ' ';

    --4.  all agmt_id(end_date='1Jan9999') on insurance_contract should link with agmt_id on insurance_role (type_code = 'POLHOLD' and end_date='1Jan9999')
   
select ic.* 
  from insurance_contract ic, insurance_role ir
 where ic.agmt_id = ir.agmt_id
   and ir.type_code = 'POLHOLD'
   and ir.end_date >= to_date('01-JAN-1999', 'DD-MON-YYYY')    
   and ic.end_date >= to_date('01-JAN-1999', 'DD-MON-YYYY')    

select count(*)
  from insurance_contract ic, insurance_role ir
 where ic.agmt_id = ir.agmt_id
   and ir.type_code = 'POLHOLD'
   and ir.end_date >= to_date('01-JAN-1999', 'DD-MON-YYYY')    
   and ic.end_date >= to_date('01-JAN-1999', 'DD-MON-YYYY')    
    
    --5.  Party_id on insurance_role where  type_code = 'POLHOLD' should not blank
select * from insurance_role 
where type_code = 'POLHOLD'
and party_id = '';

    --6.  Party_id on insurance_role where  type_code = 'POLHOLD' should match with party_id on PARTY Table
    select * from party;
select ir.* 
  from insurance_role ir, party p
 where ir.party_id = p.party_id
   and ir.type_code = 'POLHOLD'
   

    --7.  Party_id for type_code = 'PERS' should link with table PERSON (where trunc(end_date) = '1jan9999' ) and table PERSON_DETAIL (where trunc(end_date) = '1jan9999' )
select * from party p
INNER JOIN person ps
on p.party_id = ps.party_id
INNER JOIN person_detail pd
on ps.party_id = pd.party_id and p.party_id = ps.party_id
where p.type_code = 'PERS'
and ps.end_date >= to_date('01-JAN-1999', 'DD-MON-YYYY')    
and pd.end_date >= to_date('01-JAN-1999', 'DD-MON-YYYY')   


    --8.  Party_id for type_code = 'ORGN' should link with table ORGANIZATION (where trunc(end_date) = '1jan9999' )
select * from organization;
select o.*
from organization o, insurance_role ir
where o.party_id = ir.party_id 
and o.type_code = 'ORGN'
and to_char(o.END_DATE,'DD-MON-YYYY') = '01-JAN-9999'


select count(1)
from organization o, insurance_role ir
where o.party_id = ir.party_id 
and o.type_code = 'ORGN'
and to_char(o.END_DATE,'DD-MON-YYYY') = '01-JAN-9999'

    --9.  No dulipcate data on insurance_role where  type_code = 'POLHOLD' and trunc(end_date) = '1jan9999' grouping by agmt_id 
select ir.*
from insurance_role ir
inner join insurance_contract ic
on  ir.agmt_id = ic.agmt_id
where ir.type_code = 'POLHOLD'
and to_char (ir.end_date, 'DD-MON-YYYY') = '01-JAN-1999'


--for this test please fillter insurance_role where type_code = 'LIFEASRD'
    --1.  the start_date should not blank
select * from insurance_role
where type_code = 'LIFEASRD'
and to_char (START_DATE, 'DD-MON-YYYY') = ' ';
    
    --2.  the end_date should not blank
select * from insurance_role
where type_code = 'LIFEASRD'
and to_char (END_DATE, 'DD-MON-YYYY') = ' ';

    --3.  agmt_id on Insurance_contract should match with agmt_id on insurance_role where type_code = 'LIFEASRD' and trunc(end_date)='1jan9999'
select * from insurance_contract
select * from insurance_role where type_code = 'LIFEASRD'

select ic.*
from insurance_contract ic
inner join insurance_role ir
on  ic.agmt_id = ir.agmt_id
where ir.type_code = 'LIFEASRD'
and to_char(ir.END_DATE,'DD-MON-YYYY') = '01-JAN-9999'

    --4.  Party_id on insurance_role where  type_code = 'LIFEASRD' should not blank
select * from insurance_role
where type_code = 'LIFEASRD'
and party_id = ' '

    --5.  Party_id on insurance_role where  type_code = 'LIFEASRD' should match with party_id on PARTY Table            
select count(1) from insurance_role where type_code = 'LIFEASRD'

select ir.*
from insurance_role ir
inner join party p
on  ir.party_id = p.party_id
where ir.type_code = 'LIFEASRD'

select count(1)
from insurance_role ir
inner join party p
on  ir.party_id = p.party_id
where ir.type_code = 'LIFEASRD'

    --6.  Party_id for type_code = 'PERS' should link with table PERSON (where trunc(end_date) = '1jan9999' ) and table PERSON_DETAIL (where trunc(end_date) = '1jan9999' )
select * from party p
INNER JOIN person ps
on p.party_id = ps.party_id
INNER JOIN person_detail pd
on ps.party_id = pd.party_id and p.party_id = ps.party_id
where p.type_code = 'PERS'
and ps.end_date >= to_date('01-JAN-1999', 'DD-MON-YYYY')    
and pd.end_date >= to_date('01-JAN-1999', 'DD-MON-YYYY')   

    --7.  Party_id for type_code = 'ORGN' should link with table ORGANIZATION (where trunc(end_date) = '1jan9999' )
--
select or.*
from  organization or, party p
where or.party_id = p.party_id
and p.type_code = 'ORGN'
and to_char (or.end_date, 'DD-MON-YYYY') = '01-JAN-1999'
--

    --8.  No duplicate data on insurance_role where  type_code = 'LIFEASRD' and trunc(end_date) = '1jan9999' grouping by agmt_id (should inner join with insurance_contract, because table ins_contract_detail also having 'LIFEASRD' on Insurance_Role)
select ir.*
from insurance_role ir
inner join insurance_contract ic
on  ir.agmt_id = ic.agmt_id
where ir.type_code = 'LIFEASRD'
and to_char (ir.end_date, 'DD-MON-YYYY') = '01-JAN-1999'



