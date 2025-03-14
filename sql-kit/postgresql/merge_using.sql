-- MERGE...USING...WHEN..THEN
-- => Performs Insert/Update/Delete 
-- Merge source_table into target_table based on CONDITION `S.id=T.id`
-- If CONDITION is true, MATCHED = true
-- If CONDITION is false, MATCHED = false

MERGE INTO target_table AS S
USING source_table AS T
    ON S.id = T.id
    WHEN MATCHED THEN
        -- Perform Update/Delete
    WHEN NOT MATCHED THEN
        -- perform Insert