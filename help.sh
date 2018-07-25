#------------------------------
# vars
#------------------------------

# file
FILE="package.json"
FILE_JSON=`cat $FILE`

# colors
BLACK=235
LIME=106
RESET="\033[0m"
FG="\033[38;5;"
FGB="\033[1;38;5;"
BG="\033[48;5;"

#------------------------------
# functions
#------------------------------

print_heading() {
    printf "%b%b %s %b\n" "${BG}${BLACK}m" "${FGB}${LIME}m" "$1" "$RESET"
}

main() {
    print_heading "available commands ..."
    if hash jq 2>/dev/null; then
		echo $FILE_JSON | jq '.scripts | to_entries[] | .key | " - npm run " + select(test("^(?!help)"))' -r;
    else
        echo '  JQ is required please run:';
        echo '	sudo apt install jq';
    fi
}

main
