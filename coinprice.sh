#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Santhosh veer
#   website:   https://santhoshveer.com
#   file:      coinprice.sh
#   created:   09.02.2018
#   revision:  30.03.2018
#   version:   0.2
# -----------------------------------------------------------------------------
# Requirements:
#   curl, jq
#
# Description:
#   Coinprice - Cryptocurrency price using Coinmarketcap website api.
#
# -----------------------------------------------------------------------------

# File name
SCRIPTNAME=$(basename "$0")

# Help Message
help(){
  echo -e "\\n"
  echo "Usage :  $SCRIPTNAME

Run this Script

$ bash coinprice.sh
- it will Display top 100 coins ID Name
- Enter the coin id name and get its Rankings, Prices, Market cap and More

    Options:
    -h   Display this help message

"
}

# Options
while getopts ":h" flag;
 do
    case "$flag" in
    h)
     help
     exit 0
    ;;
  \?)
    echo "Command Not Found" >&2
    exit 1
  ;;
     *)
    esac
  done
  shift $((OPTIND-1))

# Coinprice ID
echo -e "\\n"
echo "TOP 100 Coin ID's"

echo "-----------------"

# cURL Request
curl -s --request GET \
    --url "https://api.coinmarketcap.com/v1/ticker/" \ | jq -r '["RANK","COIN IDS"], ["--","--------"], (.[] | [.rank, .id]) | @tsv'


# Get Price Details
echo -e "\\n"
echo -n "Enter the Coin ID Name : "
read -r coinname

  # If no URL you will see this Alert message
  if [[ ! $coinname ]]; then
    echo -e "\\n"
    echo -e "\\033[1;31m Error input is Missing \\033[0m \\n"
    exit 1
  fi

# Change all spaces in the title to "%20" for the URL
Fcoinname=${coinname// /%20}

echo -e "\\n"
echo -e "\\033[1;32m [+] Fetching the Coin Details... \\033[0m"


# cURL Request
curl -s --request GET \
    --url "https://api.coinmarketcap.com/v1/ticker/$Fcoinname/" \ | jq

exit 0
