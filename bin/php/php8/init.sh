center_string() {
    local input="$1"
    local width="$2"
    local padding_char="${3:- }"  # Default padding character is space

    local input_length=${#input}
    local total_padding=$(( (width - input_length) / 2 ))
    local abc=$((input_length % 2))

    local left_padding=""
    local right_padding=""
    for ((i = 0; i < total_padding; i++)); do
        left_padding="${left_padding}${padding_char}"
        if [[ $abc = 0 && $i = $((total_padding - 1)) ]]; then
            right_padding="${right_padding}"
        else
            right_padding="${right_padding}${padding_char}"
        fi
    done

    printf "%s%s%s" "$left_padding" "$input" "$right_padding"

}

print_block(){
    for i in 1 2 
    do
        echo "|                                                                                              |"
    done
}

print_line() {
    echo "$(center_string '_' 102 '_')"
    echo "|$(center_string ' ' 100 ' ')|"
    echo "|$(center_string ' ' 100 ' ')|"
    centered_string=$(center_string "$1" 100 " ")
    echo "|$centered_string|"
    echo "|$(center_string ' ' 100 ' ')|"
    echo "|$(center_string '_' 100 '_')|"
}

print_line "$PROJECT Init script start"

if [ ! -d "$PROJECT/website" ] ; then
    print_line "cloning $PROJECT from git $GIT_REPO to /data/$PROJECT"
    git clone --single-branch --branch $GIT_BRANCH $GIT_REPO $PROJECT
    cp .env $PROJECT/website/.env
    cd $PROJECT/website && composer install && php artisan config:cache && php artisan view:clear && php artisan route:clear && composer dump-autoload && php artisan vue-i18n-custom:generate && php artisan migrate && chown -R www-data. . 
    print_line "$PROJECT setup finished"
else
    print_line "skiping $PROJECT setup folder /data/$PROJECT already exists"
    print_line "if you want to reinitialise the project manually remove the folder /$PROJECT"
fi

print_line "$PROJECT Init script end"