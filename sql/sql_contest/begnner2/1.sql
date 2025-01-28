UPDATE b2_1goods
SET sale_end_date = '2024-07-31'
WHERE valid_flg = 0 AND sale_end_date IS NULL;
