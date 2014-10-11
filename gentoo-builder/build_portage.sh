#!/bin/bash

printf "Pending updates\n\n"
nice -n 10 emerge --ignore-default-opts --pretend --verbose --update world

echo "------------------------------------------------------------------------------"
printf "Building binary packages\n\n"
FEATURES="-ccache -distcc" nice -n 5 emerge --ask n --color y --tree --load-average 1.8 --update --newuse --deep --buildpkg --binpkg-respect-use --getbinpkg world
