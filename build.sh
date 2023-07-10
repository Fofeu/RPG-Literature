#!/bin/bash

# Make handles pathnames with spaces poorly
# We don't need complicated build logic anyway
# A simple Bash script is enough

PANDOCS=('Fate/Fate Primer/Rubber Mechanics 1.md')

BUILD_DIR="build"

rm -rf "${BUILD_DIR}"

mkdir --parent "${BUILD_DIR}"

for pd in "${PANDOCS[@]}"
do
    mkdir --parent "$(dirname "${BUILD_DIR}/${pd}")"
    pandoc "${pd}" -o "${BUILD_DIR}/${pd/%.md/.pdf}"
    pandoc "${pd}" -o "${BUILD_DIR}/${pd/%.md/.epub}"
done

rm release.zip
rm release.tar.gz

cd "${BUILD_DIR}"

zip -r '../release.zip' *
tar czf '../release.tar.gz' *
