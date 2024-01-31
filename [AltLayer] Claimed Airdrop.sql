--Proportion of Claimed AirDrop (Has claimed: yes || no)
WITH EigenLayerRestakers AS (
    SELECT DISTINCT address
    FROM dune.yulia_is_here.result_alt_layer_air_drop_for_eigen_layer_restakers
    WHERE restaked_points >= 720
),
AltLayerOGBadge AS (
    SELECT current_holder
    FROM (
        SELECT
            token_id,
            to AS current_holder,
            ROW_NUMBER() OVER (PARTITION BY token_id ORDER BY block_time DESC) as rn
        FROM nft.transfers
        WHERE contract_address = 0x1d9A1491924C1847e669dAFdE86341AD92A87fE2
              AND block_number <= 19022890
    ) RankedTransfers
    WHERE rn = 1
),
OhOttieNFT AS (
    SELECT current_holder
    FROM (
        SELECT
            token_id,
            to AS current_holder,
            ROW_NUMBER() OVER (PARTITION BY token_id ORDER BY block_time DESC) as rn
        FROM nft.transfers
        WHERE contract_address = 0x7FF5601B0A434b52345c57A01A28d63f3E892aC0
              AND block_number <= 19022890
    ) RankedTransfers
    WHERE rn = 1
),
EligibleAddresses AS (
    SELECT DISTINCT address
    FROM EigenLayerRestakers
    UNION
    SELECT current_holder FROM AltLayerOGBadge
    UNION
    SELECT current_holder FROM OhOttieNFT
),
ClaimedAddresses AS (
    SELECT DISTINCT tx."from" AS claimer
    FROM ethereum.transactions AS tx
    JOIN erc20_ethereum.evt_Transfer AS evt ON tx.hash = evt.evt_tx_hash
    WHERE tx."to" = 0x8457CA5040ad67fdebbCC8EdCE889A335Bc0fbFB
      AND CAST(tx.data AS VARCHAR) LIKE '0xa9059cbb%'
)
SELECT
    CASE
        WHEN CA.claimer IS NOT NULL THEN 'Yes'
        ELSE 'No'
    END AS Claimed,
    COUNT(*) AS Amount
FROM
    EligibleAddresses EA
LEFT JOIN
    ClaimedAddresses CA ON EA.address = CA.claimer
GROUP BY
    CASE
        WHEN CA.claimer IS NOT NULL THEN 'Yes'
        ELSE 'No'
    END;
