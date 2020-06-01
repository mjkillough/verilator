#!/usr/bin/env bash
# DESCRIPTION: Verilator: Travis CI test script
#
# Copyright 2019 by Todd Strader. This program is free software; you
# can redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License
# Version 2.0.
# SPDX-License-Identifier: LGPL-3.0-only OR Artistic-2.0

set -e

if [ -z "${MAKE}" ]; then
    MAKE=make
fi

export DRIVER_FLAGS='-j 0 --quiet --rerun'

case $1 in
    dist)
        ${MAKE} -C test_regress SCENARIOS=--dist
        ;;
    vlt)
        ${MAKE} -C test_regress SCENARIOS=--vlt
        ;;
    distvlt)
        ${MAKE} -C test_regress SCENARIOS="--dist --vlt"
        ;;
    vltmt)
        ${MAKE} -C test_regress SCENARIOS=--vltmt
        ;;
    vltmt0)
        ${MAKE} -C test_regress SCENARIOS=--vltmt DRIVER_HASHSET=--hashset=0/2
        ;;
    vltmt1)
        ${MAKE} -C test_regress SCENARIOS=--vltmt DRIVER_HASHSET=--hashset=1/2
        ;;
    coverage-build)
        nodist/code_coverage --stages 1-2
        ;;
    coverage-dist)
        nodist/code_coverage --scenarios=--dist
        bash <(curl -s https://codecov.io/bash) -f nodist/obj_dir/coverage/app_total.info 
        ;;
    coverage-vlt0)
        nodist/code_coverage --scenarios=--vlt --hashset=0/4
        bash <(curl -s https://codecov.io/bash) -f nodist/obj_dir/coverage/app_total.info 
        ;;
    coverage-vlt1)
        nodist/code_coverage --scenarios=--vlt --hashset=1/4
        bash <(curl -s https://codecov.io/bash) -f nodist/obj_dir/coverage/app_total.info 
        ;;
    coverage-vlt2)
        nodist/code_coverage --scenarios=--vlt --hashset=2/4
        bash <(curl -s https://codecov.io/bash) -f nodist/obj_dir/coverage/app_total.info 
        ;;
    coverage-vlt3)
        nodist/code_coverage --scenarios=--vlt --hashset=3/4
        bash <(curl -s https://codecov.io/bash) -f nodist/obj_dir/coverage/app_total.info 
        ;;
    coverage-vltmt0)
        nodist/code_coverage --scenarios=--vltmt --hashset=0/4
        bash <(curl -s https://codecov.io/bash) -f nodist/obj_dir/coverage/app_total.info 
        ;;
    coverage-vltmt1)
        nodist/code_coverage --scenarios=--vltmt --hashset=1/4
        bash <(curl -s https://codecov.io/bash) -f nodist/obj_dir/coverage/app_total.info 
        ;;
    coverage-vltmt2)
        nodist/code_coverage --scenarios=--vltmt --hashset=3/4
        bash <(curl -s https://codecov.io/bash) -f nodist/obj_dir/coverage/app_total.info 
        ;;
    coverage-vltmt3)
        nodist/code_coverage --scenarios=--vltmt --hashset=4/4
        bash <(curl -s https://codecov.io/bash) -f nodist/obj_dir/coverage/app_total.info 
        ;;
    *)
    echo "Usage: test.sh (dist|vlt|vltmt)"
    exit -1
    ;;
esac
