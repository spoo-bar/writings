$FILEPATH=".\_posts\2024-04-09-i-breathe.md"
$APIKEY="$env:APIKEY"
$BTCHEIGHT=Invoke-WebRequest -Uri "https://rest.cryptoapis.io/blockchain-data/bitcoin/mainnet/blocks/last/1" -Headers @{"Content-Type"="application/json"; "X-API-Key"="$APIKEY"} -Method Get | ConvertFrom-Json | Select-Object -ExpandProperty data | Select-Object -ExpandProperty items | Select-Object -ExpandProperty height 
$IBREATHECONTENT = [System.IO.File]::ReadAllText($FILEPATH).Replace("[BLOCKHEIGHT]","$BTCHEIGHT")
[System.IO.File]::WriteAllText($FILEPATH, $IBREATHECONTENT)