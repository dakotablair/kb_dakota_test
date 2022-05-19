#!/bin/bash
# This script is meant to be run once immediately after cloning this repo.
set -e
set -x

# TODO: Infer app name from directory.
# The idea is that a user will clone this from a new project using the example
# app as a template repo. If they do not specify another directory (which we
# will suggest in the README)
name=$(basename $(pwd))

FILES=$(cat << HEREDOC
Makefile
README.md
RELEASE_NOTES.md
deploy.cfg
example_kb_sdk_app.spec
kbase.yml
lib/example_kb_sdk_app/example_kb_sdk_appImpl.py
lib/example_kb_sdk_app/example_kb_sdk_appServer.py
scripts/run_async.sh
test/example_kb_sdk_app_server_test.py
test/unit_tests/test_example_kb_sdk_app_utils.py
tox.ini
ui/narrative/methods/run_example_kb_sdk_app/spec.json
HEREDOC)

for file in $FILES
do
    sed -i'.bak' "s/example_kb_sdk/$name/g" $file
done

git add -u

git mv example_kb_sdk_app.spec ${name}_app.spec
git mv lib/example_kb_sdk_app/example_kb_sdk_appImpl.py lib/example_kb_sdk_app/${name}_appImpl.py
git mv lib/example_kb_sdk_app/example_kb_sdk_appServer.py lib/example_kb_sdk_app/${name}_appServer.py
git mv lib/example_kb_sdk_app lib/${name}_app
git mv test/example_kb_sdk_app_server_test.py test/${name}_app_server_test.py
git mv test/unit_tests/test_example_kb_sdk_app_utils.py test/unit_tests/test_${name}_app_utils.py
git mv ui/narrative/methods/run_example_kb_sdk_app ui/narrative/methods/run_${name}_app

# TODO: add a git commit below
