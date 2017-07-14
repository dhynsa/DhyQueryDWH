select 'GRP_TRANS_CODE' as Type_Code, 'GROUP TRANSACTION CODES' as Name, 'POLICY GROUP TRANSACTION CODES' as Descr
from dual;

select 'TRANS_CODE' as Type_Code, 'TRANSACTION CODES' as Name, 'POLICY TRANSACTION CODES' as Descr
from dual;

select distinct Group_Trans_code as Code_Lbl, Group_Trans_code as Name, Group_Trans_code as Descr
FROM AZLI_UNT_TRANS_TYPE_REF
UNION
select distinct Group_Trans_code as Code_Lbl, Group_Trans_code as Name, Group_Trans_code as Descr
from AZLI_TR_TRANS_TYPE_REF
where Group_Trans_Code not in (select Group_Trans_Code from AZLI_UNT_TRANS_TYPE_REF);


select distinct trans_code as Code_Lbl, description as Name, description as Descr
FROM AZLI_UNT_TRANS_TYPE_REF
UNION
select distinct trans_code as Code_Lbl, description as Name, description as Descr
from AZLI_TR_TRANS_TYPE_REF
where trans_code not in (select trans_code from AZLI_UNT_TRANS_TYPE_REF);


--

select distinct Group_Trans_code as Code_Lbl, Group_Trans_code as Name, Group_Trans_code as Descr
FROM AZLI_UNT_TRANS_TYPE_REF
UNION
select distinct Group_Trans_code as Code_Lbl, Group_Trans_code as Name, Group_Trans_code as Descr
from AZLI_TR_TRANS_TYPE_REF
where Group_Trans_Code not in (select Group_Trans_Code from AZLI_UNT_TRANS_TYPE_REF)
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
   'FLPRMRY');
---



  --FINANCIAL_TRANSACTION
  
SELECT   a.policy_ref as policy_no,
                   a.trans_date, 
                   a.trans_source_id  || '-' || c.unitize_batch_id || '-' || c.unitize_trans_id as trans_no,                   
                   a.trans_code, 
                   a.processed_date,
                   Greatest(DECODE(b.amount_type,'U', b.total_amount*l.unit_price, 'P', c.allocated_amount, b.total_amount),0)  * NVL(e.trans_sign,1) as Amount,
                   a.trans_date as unit_date,                   
                   l.unit_price,
                   c.allocation_rate as alloc_rate,
                   c.unallocated_amount * NVL(e.trans_sign,1) as unalloc_prem,
                   c.unit as no_units,
                   c.unitize_batch_id as process_batch,
                   f.contract_currency as currency,
                   nvl(b.cover_year,0)  as alloc_year,
                   decode(c.allocation_rate, 0, (c.unallocated_amount * NVL(e.trans_sign,1)), ((1 - c.allocation_rate)/c.allocation_rate * (c.allocated_amount * NVL(e.trans_sign,1)))  + (c.allocated_amount * NVL(e.trans_sign,1))) as Premium,
                   e.group_trans_code as GP_Trans_code,
                   sysdate as import_date,
                   b.fund_code,  
                   g.long_name as Fund_Desc,
                   c.allocated_amount * NVL(e.trans_sign,1) as alloc_prem,
                   a.userid as user_name,
                   k.collection_date as last_collect_date,
                   c.appr_rate as alloc_per_fund,
                   b.Cover_no,
                   b.cover_code as Cover_Cd,
                   b.Investment_Type as Invest_Type,
                   b.From_Date as Bus_From_date,
                   b.To_date as Bus_To_Date                                     
--                   '' as Opus_Date,                   
--                   '' as trans_time,
--                   '' as trans_code_fl,
--                   0 as tu_fee, 
--                   0 as additional_benefit      
FROM azli_unt_source a
inner join azli_unt_source_detail b on a.trans_source_id = b.trans_source_id and a.trans_code = b.trans_code 
inner join azli_unt_unitization c on b.trans_source_id = c.trans_source_id
                and b.trans_code = c.trans_code and b.cover_code = c.cover_code and B.from_date = c.from_date
                and b.cover_no = c.cover_no and b.fund_code = c.fund_code
                and b.investment_type = DECODE (b.investment_type, 0, b.investment_type,  c.investment_type)    
inner join azli_unt_trans_type_ref e on a.trans_code = e.trans_code
inner join AZLI_POLICY_CONTRACTS d on a.contract_id = d.contract_id 
inner join ocp_policy_contracts f on d.contract_id = f.contract_id 
inner join ocp_policy_bases h on f.contract_id =h.contract_id and h.action_code <> 'D' and h.top_indicator = 'Y'
inner join AZLI_VAL_FUND_DEFINITION g on b.fund_code = g.fund_short_name
left join (SELECT val_from_date, val_to_date, c.effective_start_date, c.valid_upto, c.fund_short_name as fund_code,         
                        'B' as Pricing_Type,         
                        case when b.unitize_basis = 'AP' then b.bid_price_ob_round        
                                when b.unitize_basis = 'EX' then b.bid_price_bb_round        
                        END as Unit_Price        
            FROM AZLI_VAL_FUND_VAL_HEADER a, AZLI_VAL_FUND_VAL_DETAIL b, AZLI_VAL_FUND_DEFINITION c        
            WHERE a.fund_val_batch_id = b.fund_val_batch_id        
            AND a.fund_id = b.fund_id        
            AND a.fund_id = c.fund_id
            AND b.approve_status = Azli_Pkge_Constant.statusapproved        
            UNION ALL        
            SELECT val_from_date, val_to_date, c.effective_start_date, c.valid_upto, c.fund_short_name as fund_code,         
                        'O' as Pricing_Type,         
                        case when b.unitize_basis = 'AP' then b.offer_price_ob_round        
                                when b.unitize_basis = 'EX' then b.offer_price_bb_round        
                        END as Unit_Price        
            FROM AZLI_VAL_FUND_VAL_HEADER a, AZLI_VAL_FUND_VAL_DETAIL b, AZLI_VAL_FUND_DEFINITION c        
            WHERE a.fund_val_batch_id = b.fund_val_batch_id        
            AND a.fund_id = b.fund_id        
            AND a.fund_id = c.fund_id
            AND b.approve_status = Azli_Pkge_Constant.statusapproved        
            ) l on b.fund_code = l.fund_code AND e.pricing_method = l.pricing_type 
                    AND a.trans_date between  l.val_from_date AND l.val_to_date
                    and a.trans_date between l.effective_start_date AND NVL (l.valid_upto, a.trans_date )
left join (SELECT a.policy_ref as policy_no, a.trans_date, b.cover_code, a.trans_code, max(f.coll_date) as collection_date
            FROM azli_unt_source a
            inner join azli_unt_source_detail b on a.trans_source_id = b.trans_source_id and a.trans_code = b.trans_code 
            inner join azli_unt_unitization c on b.trans_source_id = c.trans_source_id
                            and b.trans_code = c.trans_code and b.cover_code = c.cover_code and B.from_date = c.from_date
                            and b.cover_no = c.cover_no and b.fund_code = c.fund_code
                            and b.investment_type = DECODE (b.investment_type, 0, b.investment_type,  c.investment_type)    
            inner join azli_unt_trans_type_ref e on a.trans_code = e.trans_code
            inner join azli_comp_extract_detl f on a.policy_ref = f.policy_ref and a.trans_date = f.trans_date
                            and e.group_trans_code in ('PREM','TOPUPREG')
                            and f.trans_type = (CASE WHEN a.trans_code LIKE 'CNC%' THEN 'CB'
                                WHEN f.policy_status LIKE 'FREELOOK%' THEN 'CB'
                                ELSE 'BC' END)
                    AND NVL (f.comm_type, 'PRM') = (CASE WHEN b.cover_code LIKE 'TUR%' THEN 'RTP'
                                        WHEN b.cover_code LIKE 'BASE%' AND a.trans_code LIKE 'TU%S%' THEN 'STP'
                                        ELSE 'PRM' END)
            --where a.policy_ref = '000025698606'
            group by  a.policy_ref, a.trans_date, b.cover_code, a.trans_code) k on a.policy_ref = k.policy_no AND a.trans_Date = k.trans_date AND b.cover_code = k.cover_code AND a.trans_code = k.trans_code
--where a.policy_ref = '000025698606'
UNION
SELECT a.policy_ref policy_no,                     
                   a.trans_date,
                   TO_CHAR(a.TRANS_SOURCE_ID) as TRANS_NO, 
                   a.trans_code, 
                   a.processed_date, 
                   --B.Total_Amount * NVL(h.trans_sign,1) as Total_Amount,
                   B.Total_Amount as Total_Amount,
                   a.trans_date unit_date,
                   1 as Unit_Price,
                   b.ALLOCATION_RATE as Alloc_Rate,
                   0 as unalloc_prem,
                   B.total_amount as no_units,
                   0 as process_batch,
                   f.contract_currency as currency,
                   nvl(b.cover_year,0) alloc_year,
                   decode(b.ALLOCATION_RATE, 0, 0, ((1 - b.ALLOCATION_RATE)/ b.ALLOCATION_RATE * (B.total_amount ))  + (B.total_amount )) as Premium,
                   h.group_trans_code as GP_Trans_Code,
                   sysdate as import_date,
                   B.fund_code,
                   g.long_name as Fund_Desc,
                   --B.total_amount * NVL(h.trans_sign,1) as alloc_prem,
                   B.total_amount as alloc_prem,
                   a.userid user_name,
                   k.collection_date as Last_Collect_Date,
                   B.APPR_RATE as alloc_per_fund,
                   b.Cover_no,
                   b.cover_code as Cover_Cd,
                   b.Investment_Type as Invest_Type,
                   b.From_Date as Bus_From_Date,
                   b.To_date as Bus_To_Date                                                       
FROM azli_tr_source@link2prod a
inner join azli_tr_source_DETAIL@link2prod B on a.TRANS_SOURCE_ID = B.TRANS_SOURCE_ID and a.trans_code = B.trans_code              
inner join AZLI_POLICY_CONTRACTS d on a.contract_id = d.contract_id
inner join AZLI_TR_TRANS_TYPE_REF e on a.trans_code = e.trans_code
inner join ocp_policy_contracts f on d.contract_id = f.contract_id and f.Product_ID=204
inner join ocp_policy_bases h on f.contract_id =h.contract_id and h.action_code <> 'D' and h.top_indicator = 'Y'
left join AZLI_VAL_FUND_DEFINITION g on b.fund_code = g.fund_short_name
left join azli_tr_trans_type_ref h on a.trans_code = h.trans_code
left join (SELECT a.policy_ref as policy_no, a.trans_date, b.cover_code, max(f.coll_date) as collection_date
            FROM azli_tr_source@link2prod a
            inner join azli_tr_source_DETAIL@link2prod b on a.trans_source_id = b.trans_source_id and a.trans_code = b.trans_code 
            inner join AZLI_POLICY_CONTRACTS d on a.contract_id = d.contract_id
            inner join stage.AZLI_TR_TRANS_TYPE_REF e on a.trans_code = e.trans_code
            inner join azli_comp_extract_detl f on a.policy_ref = f.policy_ref and a.trans_date = f.trans_date
                            and e.group_trans_code in ('PREM','TOPUPREG')
                            and f.trans_type = (CASE WHEN a.trans_code LIKE 'CNC%' THEN 'CB'
                                WHEN f.policy_status LIKE 'FREELOOK%' THEN 'CB'
                                ELSE 'BC' END)
                    AND NVL (f.comm_type, 'PRM') = (CASE WHEN b.cover_code LIKE 'TUR%' THEN 'RTP'
                                        WHEN b.cover_code LIKE 'BASE%' AND a.trans_code LIKE 'TU%S%' THEN 'STP'
                                        ELSE 'PRM' END)
            where a.policy_ref = '000021476770'
            group by  a.policy_ref, a.trans_date, b.cover_code)k on a.policy_ref = k.policy_no AND a.trans_Date = k.trans_date AND b.cover_code = k.cover_code



--FIN_TOPUP_TRANSACTION

select Policy_Ref as Pol_No,
        Event_Date,
        User_Id as Bus_User_Id,
        TopUp_Amount as TopUp_Amt,
        Percent_Allocation as Per_Alloc,
        Status as Status_Cd,
        Contest_Type_Code,
        Topup_Type
from azli_topup_trans