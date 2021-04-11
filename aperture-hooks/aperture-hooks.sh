#!/bin/bash

lsb_release(){
    local file=/etc/lsb-release

    if [ -z "$(grep "^DISTRIB_CODENAME=" $file)" ] ; then
        # add missing DISTRIB_CODENAME=
        echo "DISTRIB_CODENAME=rolling" >> $file
    fi
    sed -i /etc/lsb-release \
        -e 's,DISTRIB_ID=.*,DISTRIB_ID=Aperture,' \
        -e 's,DISTRIB_RELEASE=.*,DISTRIB_RELEASE=alpha,' \
        -e 's,DISTRIB_CODENAME=.*,DISTRIB_CODENAME=aperture-fixtures,' \
        -e 's,DISTRIB_DESCRIPTION=.*,DISTRIB_DESCRIPTION=\"Aperture Linux\",'

}

os_release(){  
    local file=/usr/lib/os-release

    sed -i /usr/lib/os-release \
        -e 's,NAME=.*,NAME=\"Aperture Linux\",' \
        -e 's,PRETTY_NAME=.*,PRETTY_NAME=\"Aperture Linux\",' \
        -e 's,ID=.*,ID=aperture,' \
        -e 's,ID_LIKE=.*,ID_LIKE=arch,' \
        -e 's,BUILD_ID=.*,BUILD_ID=rolling,' \
        -e 's,HOME_URL=.*,HOME_URL=\"https://aperturelinux.org/\",' \
        -e 's,DOCUMENTATION_URL=.*,DOCUMENTATION_URL=\"https://wiki.aperturelinux.org/\",' \
        -e 's,SUPPORT_URL=.*,SUPPORT_URL=\"https://forum.aperturelinux.org/\",' \
        -e 's,BUG_REPORT_URL=.*,BUG_REPORT_URL=\"https://github.com/ApertureLinux\",' \
        -e 's,LOGO=.*,LOGO=aperturelinux,'
        
    if [ -z "$(grep "^ID_LIKE=" $file)" ] && [ -n "$(grep "^ID=" $file)" ] ; then
        # add missing ID_LIKE=
        sed -i $file -e '/^ID=/a \ID_LIKE=arch'
    fi
}

post_install(){
    post_upgrade
}

post_upgrade(){
    os_release
    lsb_release

}

