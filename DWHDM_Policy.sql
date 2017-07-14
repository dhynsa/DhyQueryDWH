
ALTER SESSION SET CURRENT_SCHEMA=DWH_DM;

  --DIM_POL_STAT_GRP
    --1. Count the number of records in the file and the table
 select * from DIM_POL_STAT_GRP;
 select count(1) from DIM_POL_STAT_GRP;
 
    --2. Check if all the columns (EXCEPT GROUPS) in the file is same as in this table.
select policy_status_cat, policy_status_cd, policy_status_desc, policy_status_grp, policy_status_subgrp from DIM_POL_STAT_GRP;