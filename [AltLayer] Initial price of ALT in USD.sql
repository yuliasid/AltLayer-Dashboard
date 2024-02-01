--LAST price of ALT in USD 
SELECT 
    block_time,
   -- (amount_usd / (token_sold_amount_raw / 1e18)) AS price_per_alt_token
    round((amount_usd / (token_sold_amount_raw / 1e18)),3) AS price_per_alt_token
FROM 
    dex.trades
WHERE 
    token_sold_address = 0x8457CA5040ad67fdebbCC8EdCE889A335Bc0fbFB -- Smart contract of ALT
    AND project = 'uniswap'
    AND token_bought_symbol = 'USDT'
Order By block_date ASC
LIMIT 1;