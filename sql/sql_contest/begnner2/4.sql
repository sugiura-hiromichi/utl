-- 1. calculate average of STD_COST_PRICE per GOODS_CODE (SKU table)
-- 2. calculated average above should rounded off to one decimal place
-- 3. insert GOODS.STD_COST_PRICE into SKU.STD_COST_PRICE where its STD_COST_PRICE is less than
-- calcualted one

UPDATE SKU
SET
    STD_COST_PRICE = SUB.STD,
    UPDATE_USER_NAME = 'MODIFY',
    USER_UPDATE_DATETIME = '2024-08-31 00:00:00'
FROM (
    -- calculate average cost per GOODS_CODE in subquery
        SELECT
            G.STD_COST_PRICE AS STD,
            S.GOODS_CODE,
            ROUND(AVG(S.STD_COST_PRICE)) AS AVG
        FROM SKU AS S
        INNER JOIN GOODS AS G ON G.GOODS_CODE = S.GOODS_CODE
        GROUP BY S.GOODS_CODE, G.STD_COST_PRICE
    ) AS SUB
WHERE
    SUB.GOODS_CODE = SKU.GOODS_CODE AND
    SUB.AVG > SKU.STD_COST_PRICE
;

SELECT * FROM SKU;
