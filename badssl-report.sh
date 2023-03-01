#!/bin/bash

function run_tests(){
    declare -A ssl_urls
    ssl_urls=( ["sha256"]="https://sha256.badssl.com"
            ["tls-v1-1"]="https://tls-v1-1.badssl.com:1011"
            ["cbc"]="https://cbc.badssl.com/"
            ["rc4-md5"]="https://rc4-md5.badssl.com/"
            ["rc4"]="https://rc4.badssl.com/"
            ["3des"]="https://3des.badssl.com"
            ["null"]="https://null.badssl.com/")

    echo "type status-code result"
    for certificateType in "${!ssl_urls[@]}"; do 
        # running curl
        url_response=$(curl -s -I --head --fail "${ssl_urls[$certificateType]}" 2>/dev/null -w "%{http_code}\n" | tail -n 1);
        status=$([ "$url_response" == "200" ] && echo "GOOD" || echo "BAD")
        echo "$certificateType $url_response $status";  
    done
}

run_tests | column -t