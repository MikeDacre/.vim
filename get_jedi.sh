#! /bin/sh
#
# get_jedi.sh
# Copyright (C) 2015 dacre <dacre@esmeralda>
#
# Distributed under terms of the MIT license.
#

INSTALL_DIR="?"
pip3 install --install-option="--prefix=$INSTALL_DIR" jedi
