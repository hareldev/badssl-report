#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." >/dev/null && pwd )"

function run_tests(){
    json_file="badssl-endpoints.json"
    json_file_alternative_url="https://raw.githubusercontent.com/hareldev/badssl-report/main/badssl-endpoints.json"
    if [[ -f "$json_file" ]]; then
        file_content=$(cat $json_file)
    else
        file_content=$(curl -sSL --fail "${json_file_alternative_url}")
    fi

    echo "type status-code result"
    for row in $(echo "$file_content" | jq -r '.[] | @base64'); do
        _jq() {
        echo "${row}" | base64 --decode | jq -r "${1}"
        }
        
        # OPTIONAL
        # Set each property of the row to a variable
        url=$(_jq '.url')
        base_name=$(_jq '.base_name')
        description=$(_jq '.description') # for future use

        # Utilize your variables
        url_response=$(curl -s -I --head --fail --tlsv1 "${url}" 2>/dev/null -w "%{http_code}\n" | tail -n 1);
        status=$([ "$url_response" == "200" ] && echo "GOOD" || echo "BAD")
        echo "$base_name $url_response $status";  
    done
}

run_tests | column -t