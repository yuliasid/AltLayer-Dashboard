WITH Withdrawals AS (
    SELECT 
        "to" AS address,
        date_trunc('day', evt_block_time) AS day,
        SUM(value / 1e18) AS value_in_ether,
        CASE 
            WHEN "from" = 0x54945180db7943c0ed0fee7edab2bd24620256bc THEN 'cbETH'
            WHEN "from" = 0x1bee69b7dfffa4e2d53c2a2df135c388ad25dcd2 THEN 'rETH'
            WHEN "from" = 0x93c4b944d05dfe6df7645a86cd2206016c51564d THEN 'stETH'
            WHEN "from" = 0x57ba429517c3473B6d34CA9aCd56c0e735b94c02 THEN 'osETH'
            WHEN "from" = 0x0Fe4F44beE93503346A3Ac9EE5A26b130a5796d6 THEN 'swETH'
            WHEN "from" = 0x13760F50a9d7377e4F20CB8CF9e4c26586c658ff THEN 'AnkrETH'
            WHEN "from" = 0x7CA911E83dabf90C90dD3De5411a10F1A6112184 THEN 'wBETH'
            WHEN "from" = 0x9d7eD45EE2E8FC5482fa2428f15C971e6369011d THEN 'EthX'
            WHEN "from" = 0xa4C637e0F704745D182e4D38cAb7E7485321d059 THEN 'OETH'
            ELSE 'Unknown'
        END AS token_symbol,
        COUNT(*) AS withdrawal_count
    FROM 
        erc20_ethereum.evt_Transfer
    WHERE
        "from" IN (0x54945180db7943c0ed0fee7edab2bd24620256bc,
             0x1bee69b7dfffa4e2d53c2a2df135c388ad25dcd2,
             0x93c4b944d05dfe6df7645a86cd2206016c51564d,
             0x57ba429517c3473B6d34CA9aCd56c0e735b94c02,
             0x0Fe4F44beE93503346A3Ac9EE5A26b130a5796d6,
             0x13760F50a9d7377e4F20CB8CF9e4c26586c658ff,
             0x7CA911E83dabf90C90dD3De5411a10F1A6112184,
             0x9d7eD45EE2E8FC5482fa2428f15C971e6369011d,
             0xa4C637e0F704745D182e4D38cAb7E7485321d059)
    GROUP BY "to", date_trunc('day', evt_block_time), 
    CASE 
            WHEN "from" = 0x54945180db7943c0ed0fee7edab2bd24620256bc THEN 'cbETH'
            WHEN "from" = 0x1bee69b7dfffa4e2d53c2a2df135c388ad25dcd2 THEN 'rETH'
            WHEN "from" = 0x93c4b944d05dfe6df7645a86cd2206016c51564d THEN 'stETH'
            WHEN "from" = 0x57ba429517c3473B6d34CA9aCd56c0e735b94c02 THEN 'osETH'
            WHEN "from" = 0x0Fe4F44beE93503346A3Ac9EE5A26b130a5796d6 THEN 'swETH'
            WHEN "from" = 0x13760F50a9d7377e4F20CB8CF9e4c26586c658ff THEN 'AnkrETH'
            WHEN "from" = 0x7CA911E83dabf90C90dD3De5411a10F1A6112184 THEN 'wBETH'
            WHEN "from" = 0x9d7eD45EE2E8FC5482fa2428f15C971e6369011d THEN 'EthX'
            WHEN "from" = 0xa4C637e0F704745D182e4D38cAb7E7485321d059 THEN 'OETH'
            ELSE 'Unknown'
        END 
)
SELECT
    address,
    day,
    token_symbol,
    value_in_ether,
    withdrawal_count
FROM Withdrawals
WHERE withdrawal_count > 1
ORDER BY address, day;
