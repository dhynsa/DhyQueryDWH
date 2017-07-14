party_id with metrics, to complete we need to get the sub-channel or banks
select h.stat_year, h.stat_mth, h.type_code, h.party_id, h.currency_cd, 
    sum (decode(d.type_code, 'TTLBNKSTFF', d.value,0)) "Total Bank Staff" 
from edw_dwh_core.statistics sh, edw_dwh_core.statistics_header h, 
 edw_dwh_core.statistics sd, edw_dwh_core.statistics_detail d
where sh.stats_id = h.stats_id
 and sd.stats_id = d.stats_id
 --and to_char(p.end_date, 'DD-MON-YYYY') = '01-JAN-9999'
 and sh.source_sys_cd = '06_BTPN_BRANCH_STAFF_COUNT'
 and sd.source_sys_cd = '06_BTPN_BRANCH_STAFF_COUNT'
 and to_char(h.end_date, 'DD-MON-YYYY') = '01-JAN-9999' 
 and to_char(d.end_date, 'DD-MON-YYYY') = '01-JAN-9999' 
group by h.stat_year, h.stat_mth, h.type_code, h.party_id, h.currency_cd


select Pol_No, A.Fund_Id, Short_Name as Fund_Code, Apportionment
from AGMT_FUND_RLSHIP A
left join FUND_DEFINITION B on a.Fund_id = B.Fund_id
inner join insurance_contract C on A.agmt_id = C.Agmt_id and trunc(C.end_date) = '1jan9999'
where trunc(A.end_date) = '1jan9999'
and C.POL_NO = '000006037989';

