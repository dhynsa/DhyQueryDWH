-- product_cd with metrics -- to complete we need to add sub-channel and channel
select h.stat_year, h.stat_mth, h.type_code, h.spec_id, p.product_cd, h.currency_cd, 
       sum (decode(d.stat_code, 'ACTLCOMMINC', d.value,0)) "Actual Commission Income",
       sum (decode(d.stat_code, 'ACTLGWP', d.value,0))     "Actual GWP",
       sum (decode(d.stat_code, 'NOPOLSOLD', d.value,0))   "Policies Sold"
  from edw_dwh_core.statistics sh, edw_dwh_core.statistics_header h, 
       edw_dwh_core.statistics sd, edw_dwh_core.statistics_detail d,
       edw_dwh_core.specification s, edw_dwh_core.product p
 where sh.stats_id = h.stats_id
   and sd.stats_id = d.stats_id
   and s.spec_id = p.spec_id
   and s.spec_id = h.spec_id
   and s.source_sys_cd = '05_PRODUCT.PRODUCT_CODE'
   and to_char(p.end_date, 'DD-MON-YYYY') = '01-JAN-9999'
   and sh.source_sys_cd = '04_DMTM_HSBC_Load_File'
   and sd.source_sys_cd = '04_DMTM_HSBC_Load_File'
  -- and to_char(h.end_date, 'DD-MON-YYYY') = '01-JAN-9999' -- BUG
group by h.stat_year, h.stat_mth, h.type_code, h.spec_id, p.product_cd, h.currency_cd
order by h.stat_year, h.stat_mth, h.type_code, p.product_cd, h.currency_cd



alter session set current_schema = DWH_CORE;