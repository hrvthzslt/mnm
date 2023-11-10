#!/usr/bin/env sh

#
# create config if it doesn't exist and read it.
#
create_config() {
    mkdir ~/.config 2>/dev/null ; touch ~/.config/mnm.conf 2>/dev/null
    printf "path=~/notes\ndirectories=%s" "\"notes daily\"" > ~/.config/mnm.conf
    echo "Config file created at ~/.config/mnm.conf"
}

read_config() {
    # shellcheck source=./mnm.conf
    . ~/.config/mnm.conf
}

if [ -f ~/.config/mnm.conf ]; then read_config; else create_config; read_config; fi

#
# create directories if they don't exist.
#
for directory in $directories; do
    [ -d "$path/$directory" ] || mkdir -p "$path/$directory" 2>/dev/null
done

# 
# Hep text
#
help() {
    echo "usage: n [-h] [-c]"
    echo "  -h      display help"
    echo "  -c      create note to a selected folder"
    echo "  -s      search all notes, and open selected one"
    echo "  -d      search notes in directory, and open selected one"
    exit 1
}

#
# Create note
#
get_note_file_name() {
    echo "$(date +%Y%m%d)_$(echo "$1" | tr '[:upper:]' '[:lower:]' | tr ' ' '_' | tr -d '\n').md"
}

create_markdown_file() {
    touch "$1"
    {
        echo "---"
        echo "date: $(date +%Y-%m-%d)"
        echo "---"
        printf "\n"
        echo "# $(echo "$2" | sed 's/.*/\L&/; s/[a-z]*/\u&/g')"
        printf "\n"
    } > "$1"
}

create_note() {
    directory=$(echo "$directories" | tr " " "\n" | fzf)
    echo "Enter note name: "
    read -r name
    filename=$(get_note_file_name "$name")
    filepath="$path/$directory/$filename"
    [ ! -f "$filepath" ] && create_markdown_file "$filepath" "$name"
    $EDITOR "$filepath"
}

search_in_path() {
    found_file_path=$(rg '' "$1" | fzf --delimiter=/ --with-nth -1 | cut -d":" -f1;)
    [ -z "$found_file_path" ] && exit 1
    $EDITOR "$found_file_path"
}

search_note() {
    search_in_path "$path"
}

search_directory() {
    directory=$(echo "$directories" | tr " " "\n" | fzf)
    search_in_path "$path/$directory"
}

case $1 in
    -h)
        help
        ;;
    -c)
        create_note
        ;;
    -s)
        search_note
        ;;
    -d)
        search_directory
        ;;
    *)
        help
        ;;
esac

exit 0
