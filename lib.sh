# Fetches a password from the user, such that it is never displayed
# to the terminal
# @param void
# @global PASSWORD - this will be set after the function finishes
function getPasswordFromUser()
{
    while [ -z "$PASSWORD" ]
    do
        echo "Please enter a password:"
        read -s PASSWORD1
        echo "Please re-enter the password to confirm:"
        read -s PASSWORD2

        if [ "$PASSWORD1" = "$PASSWORD2" ]; then
            PASSWORD=$PASSWORD1
        else
            # Output error message in red
            red='\033[0;31m'
            NC='\033[0m' # No Color
            echo ""
            echo -e "${red}Passwords did not match!${NC}"
        fi
    done
}


# Fetches a password from the user, such that it is never displayed
# to the terminal
# @param 1 - optional - name of function to execute on refusal
# @param 2 - optional - name of function to execute on approval
# @global CONFIRM_QUESTION - define this before executing the function
#                            if you want to change confirmation question.
function confirm()
{
    if [ -z "$CONFIRM_QUESTION" ]; then
        CONFIRM_QUESTION="Are you sure? (y/n)"
    fi

    read -p "$CONFIRM_QUESTION " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        # User confirmed
        $2;
    else
        # User denied
    $1;
    fi
}
