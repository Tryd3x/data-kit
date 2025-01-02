with recursive -- Declares CTE as recursive
 -- CTE name followed by column names
  consec_num (i, con_num)  as (
    -- Initialize variables
    -- (i, con_num) = (0, 0)
    select 0, 0 -- This will be printed as first row
    
    union ALL -- Vertically stack rows
    
    -- Update variables
    -- (i, con_num) = (i+1, i+1+con_num)
    select i+1, i+1+con_num -- #3 : Update variable
    from consec_num -- #1 : Fetch initial variable value
    where i<5 -- #2 : Check condition
  )
  select i, con_num -- Choose which variables to display
  from consec_num