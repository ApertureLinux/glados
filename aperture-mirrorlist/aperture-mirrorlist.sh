#!/bin/bash

add_repos(){
    #Adding GLADOS
    local conf=/etc/pacman.conf

    if ! grep -q '^[ \t]*#?[ \t]*\[glados\]' "$conf"; then
        sed -i '/^#\?\s*\[community\]/!b;:a;n;/./ba;a\\[glados\]\nInclude=/etc/pacman.d/aperture-mirrorlist\n' "$conf"
    fi
}

post_install(){
    add_repos
}
