#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Santhosh veer <mailto:me@santhoshveer.com>
#   website:   https://itrendbuzz.com
#   file:      coinprice.sh
#   created:   09.02.2018
#   version:   0.1
# -----------------------------------------------------------------------------
# Requirements:
#   curl, jq
# Description:
#   Coinprice - Cryptocurrency price using Coinmarketcap website api.
# Usage:
#   Detailed usage description in the help function.
# -----------------------------------------------------------------------------
# Script:

SCRIPTNAME=$(basename "$0")

help(){
  echo "Usage :  $SCRIPTNAME

Run this Script

$ bash coinprice.sh
+ it will Display top 100 coins ID Name
+ Enter the coin id name and get its Rankings, Prices, Market cap and More

    Options:
    -h|help      Display this help message

Credits: Using CoinMarketcap API to Fetch the Price Tickers
 "
}

while getopts "h" flag;
 do
    case "$flag" in
     h)
     help
     exit 0
     ;;
     *)
    esac
  done

echo "TOP 100 Coin ID's"

echo "-----------------"

curl -s --request GET \
    --url "https://api.coinmarketcap.com/v1/ticker/" \ | jq -r '["RANK","COIN IDS"], ["--","--------"], (.[] | [.rank, .id]) | @tsv'


echo -n "Enter the Coin ID Name or Press Enter to Get all 100 coins INFO: "
read -r coinname

  # Change all spaces in the title to "%20" for the URL
  coinname=${coinname// /%20}

echo "[+] Fetching the Price Details..."


curl -s --request GET \
    --url "https://api.coinmarketcap.com/v1/ticker/$coinname/" \ | jq

exit 0
