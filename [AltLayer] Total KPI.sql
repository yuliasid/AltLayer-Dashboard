SELECT
    COUNT(DISTINCT tx."from") AS total_unique_wallets,
    MIN(CASE WHEN evt.value > 0 THEN evt.value / 1e18 ELSE NULL END) AS min_claimed_amount,
    MAX(evt.value / 1e18) AS max_claimed_amount,
    SUM(evt.value / 1e18) AS total_alt_claimed
FROM
    ethereum.transactions AS tx
JOIN
    erc20_ethereum.evt_Transfer AS evt
ON
    tx.hash = evt.evt_tx_hash
WHERE
    tx."to" = 0xb58a659Eee982Fe4E6Ce0c2C37EBD0F7E8224D7E -- ALT smart contract
    AND CAST(tx.data AS VARCHAR) LIKE '0x304c2c03%' --OR CAST(tx.data AS VARCHAR) LIKE '0xa9059cbb%') -- Transfer method
    AND tx.block_time >= TIMESTAMP '2024-01-25 00:00:00';
