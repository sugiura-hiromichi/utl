--  NOTE: create tables

-- Creating the GOODS table
CREATE TABLE IF NOT EXISTS GOODS (
    -- connecting GOODS table & SKU table as an foreign key
    GOODS_CODE VARCHAR PRIMARY KEY,
    GOODS_NAME VARCHAR NOT NULL,
    GOODS_TYPE INTEGER NOT NULL,
    STOCK_MANAGEMENT_TYPE INTEGER NOT NULL,
    STD_COST_PRICE INTEGER,
    SHORT_DESCRIPTION VARCHAR,
    SALE_START_DATE VARCHAR,
    SALE_END_DATE VARCHAR,
    VALID_FLG VARCHAR NOT NULL,
    UPDATE_USER_NAME VARCHAR NOT NULL,
    USER_UPDATE_DATETIME VARCHAR DEFAULT CURRENT_TIMESTAMP
);

-- Creating the SKU table
CREATE TABLE IF NOT EXISTS SKU (
    SKU_CODE VARCHAR PRIMARY KEY,
    GOODS_CODE VARCHAR NOT NULL,
    SPEC1_CODE VARCHAR NOT NULL,
    SPEC2_CODE VARCHAR NOT NULL,
    STD_COST_PRICE INTEGER,
    VALID_FLG VARCHAR NOT NULL,
    UPDATE_USER_NAME VARCHAR NOT NULL,
    USER_UPDATE_DATETIME VARCHAR DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (GOODS_CODE) REFERENCES GOODS (GOODS_CODE),
    FOREIGN KEY (SPEC1_CODE) REFERENCES SPEC1 (SPEC1_CODE),
    FOREIGN KEY (SPEC2_CODE) REFERENCES SPEC2 (SPEC2_CODE)
);

-- Creating the SPEC1 table
CREATE TABLE IF NOT EXISTS SPEC1 (
    SPEC1_CODE VARCHAR PRIMARY KEY,
    SPEC1_NAME VARCHAR,
    UPDATE_USER_NAME VARCHAR,
    USER_UPDATE_DATETIME VARCHAR DEFAULT CURRENT_TIMESTAMP
);

-- Creating the SPEC2 table
CREATE TABLE IF NOT EXISTS SPEC2 (
    SPEC2_CODE VARCHAR PRIMARY KEY,
    SPEC2_NAME VARCHAR,
    UPDATE_USER_NAME VARCHAR,
    USER_UPDATE_DATETIME VARCHAR DEFAULT CURRENT_TIMESTAMP
);

DELETE FROM SKU;
DELETE FROM SPEC1;
DELETE FROM SPEC2;
DELETE FROM GOODS;

--  NOTE: insert sample data

-- Inserting data into SPEC1 table
INSERT INTO SPEC1 (
    SPEC1_CODE, SPEC1_NAME, UPDATE_USER_NAME, USER_UPDATE_DATETIME
)
VALUES
('A00', '白', 'SYSTEM', '2024-07-22 08:27:30'),
('A01', '黒', 'SYSTEM', '2024-07-22 08:27:30'),
('A02', '赤', 'SYSTEM', '2024-07-22 08:27:30');

-- Inserting data into SPEC2 table
INSERT INTO SPEC2 (
    SPEC2_CODE, SPEC2_NAME, UPDATE_USER_NAME, USER_UPDATE_DATETIME
)
VALUES
('B01', 'S', 'SYSTEM', '2024-07-22 08:35:09'),
('B02', 'M', 'SYSTEM', '2024-07-22 08:35:09'),
('B03', 'L', 'SYSTEM', '2024-07-22 08:35:09');

-- Inserting the sample data into the GOODS table
INSERT INTO GOODS (
    GOODS_CODE,
    GOODS_NAME,
    GOODS_TYPE,
    STOCK_MANAGEMENT_TYPE,
    STD_COST_PRICE,
    SHORT_DESCRIPTION,
    SALE_START_DATE,
    SALE_END_DATE,
    VALID_FLG,
    UPDATE_USER_NAME,
    USER_UPDATE_DATETIME
)
VALUES
(
    'P001',
    'フリルブラウスRock',
    2,
    1,
    4100,
    NULL,
    '2022-01-02',
    NULL,
    '1',
    'SYSTEM',
    '2024-07-18 06:58:01'
),
(
    'P002',
    'フリルハイネックブラウス',
    1,
    1,
    3500,
    NULL,
    '2023-01-01',
    '2024-08-01',
    '0',
    'SYSTEM',
    '2024-07-18 06:58:01'
),
(
    'P003',
    'オフショルダーブラウス',
    1,
    1,
    2500,
    NULL,
    '2023-01-01',
    NULL,
    '1',
    'SYSTEM',
    '2024-07-18 06:58:01'
),
(
    'P004',
    'Vネックカットソー',
    1,
    0,
    3500,
    NULL,
    '2022-01-03',
    NULL,
    '1',
    'SYSTEM',
    '2024-07-18 06:58:01'
),
(
    'P005',
    'カラーピグメントカットソー',
    1,
    1,
    2400,
    NULL,
    '2022-01-04',
    NULL,
    '1',
    'SYSTEM',
    '2024-07-18 06:58:01'
),
(
    'P006',
    'ボーダーカットソー',
    1,
    1,
    3500,
    NULL,
    '2023-01-01',
    NULL,
    '0',
    'SYSTEM',
    '2024-07-18 06:58:01'
),
(
    'P007',
    '半袖鹿の子ポロシャツ',
    1,
    1,
    3000,
    NULL,
    '2023-01-01',
    NULL,
    '0',
    'SYSTEM',
    '2024-07-18 06:58:01'
),
(
    'P008',
    'ラインチビポロシャツ',
    1,
    0,
    3500,
    NULL,
    '2022-01-05',
    '2024-06-01',
    '0',
    'SYSTEM',
    '2024-06-01 06:58:01'
),
(
    'P009',
    'リブタンクトップ',
    1,
    1,
    3000,
    NULL,
    '2022-01-06',
    '2024-07-30',
    '0',
    'SYSTEM',
    '2024-07-30 06:58:01'
),
(
    'P010',
    'ロング タンク トップ',
    1,
    1,
    3100,
    NULL,
    '2022-01-01',
    NULL,
    '1',
    'SYSTEM',
    '2024-07-18 06:58:01'
);


-- Inserting the sample data into the SKU table
INSERT INTO SKU (
    SKU_CODE,
    GOODS_CODE,
    SPEC1_CODE,
    SPEC2_CODE,
    STD_COST_PRICE,
    VALID_FLG,
    UPDATE_USER_NAME,
    USER_UPDATE_DATETIME
)
VALUES
(
    'P001A00B01',
    'P001',
    'A00',
    'B01',
    4000,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P001A00B02',
    'P001',
    'A00',
    'B02',
    3980,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P001A00B03',
    'P001',
    'A00',
    'B03',
    3980,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P001A01B01',
    'P001',
    'A01',
    'B01',
    4050,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P001A01B02',
    'P001',
    'A01',
    'B02',
    4050,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P001A01B03',
    'P001',
    'A01',
    'B03',
    4050,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P001A02B01',
    'P001',
    'A02',
    'B01',
    4050,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P001A02B02',
    'P001',
    'A02',
    'B02',
    4050,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P001A02B03',
    'P001',
    'A02',
    'B03',
    4050,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P003A00B01',
    'P003',
    'A00',
    'B01',
    1980,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P003A00B02',
    'P003',
    'A00',
    'B02',
    2300,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P003A00B03',
    'P003',
    'A00',
    'B03',
    1980,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P003A01B01',
    'P003',
    'A01',
    'B01',
    2300,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P003A01B02',
    'P003',
    'A01',
    'B02',
    2300,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P003A01B03',
    'P003',
    'A01',
    'B03',
    2300,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P003A02B01',
    'P003',
    'A02',
    'B01',
    2300,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P003A02B02',
    'P003',
    'A02',
    'B02',
    2300,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P003A02B03',
    'P003',
    'A02',
    'B03',
    2300,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P004A00B01',
    'P004',
    'A00',
    'B01',
    3300,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P004A00B02',
    'P004',
    'A00',
    'B02',
    3350,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P004A00B03',
    'P004',
    'A00',
    'B03',
    3400,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P004A01B01',
    'P004',
    'A01',
    'B01',
    3350,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P004A01B02',
    'P004',
    'A01',
    'B02',
    3000,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P004A01B03',
    'P004',
    'A01',
    'B03',
    2980,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P004A02B01',
    'P004',
    'A02',
    'B01',
    3350,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P004A02B02',
    'P004',
    'A02',
    'B02',
    3350,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P004A02B03',
    'P004',
    'A02',
    'B03',
    3350,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P005A00B01',
    'P005',
    'A00',
    'B01',
    2000,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P005A00B02',
    'P005',
    'A00',
    'B02',
    2350,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P005A00B03',
    'P005',
    'A00',
    'B03',
    2350,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P005A01B01',
    'P005',
    'A01',
    'B01',
    2350,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P005A01B02',
    'P005',
    'A01',
    'B02',
    2350,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P005A01B03',
    'P005',
    'A01',
    'B03',
    2350,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P005A02B01',
    'P005',
    'A02',
    'B01',
    2350,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P005A02B02',
    'P005',
    'A02',
    'B02',
    2350,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P005A02B03',
    'P005',
    'A02',
    'B03',
    2350,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P010A00B01',
    'P010',
    'A00',
    'B01',
    3000,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P010A00B02',
    'P010',
    'A00',
    'B02',
    3010,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P010A00B03',
    'P010',
    'A00',
    'B03',
    3050,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P010A01B01',
    'P010',
    'A01',
    'B01',
    3050,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P010A01B02',
    'P010',
    'A01',
    'B02',
    3000,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P010A01B03',
    'P010',
    'A01',
    'B03',
    3050,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P010A02B01',
    'P010',
    'A02',
    'B01',
    3050,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P010A02B02',
    'P010',
    'A02',
    'B02',
    3050,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
),
(
    'P010A02B03',
    'P010',
    'A02',
    'B03',
    3050,
    '1',
    'SYSTEM',
    '2024-08-23 00:00:00'
);
