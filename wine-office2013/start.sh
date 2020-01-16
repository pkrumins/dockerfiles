#!/bin/bash
#

main () {
    local app="$1"

    if [[ -z "$app" ]]; then
        app="word"
    fi

    if [[ "$app" == "word" ]]; then
        WINEARCH=win32 wine 'c:/program files/microsoft office/office15/winword.exe'
    elif [[ "$app" == "excel" ]]; then
        WINEARCH=win32 wine 'c:/program files/microsoft office/office15/excel.exe'
    fi
}

main "$@"

