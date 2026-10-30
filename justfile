default:
    just --list

# Scaffold a new task folder with a report template and an empty test suite.
new task topic:
    mkdir -p tasks/{{task}}
    cp templates/code_template.pl tasks/{{task}}/{{topic}}.pl
    sed 's/__TOPIC__/{{topic}}/g' templates/report_template.typ > tasks/{{task}}/report.typ
    sed 's/__TOPIC__/{{topic}}/g' templates/tests_template.pl > tasks/{{task}}/tests.pl
    echo "created tasks/{{task}}/{{topic}}.pl, tasks/{{task}}/report.typ and tasks/{{task}}/tests.pl"

# Run the test suite for one task.
test task:
    cd tasks/{{task}} && swipl -q -t halt tests.pl

# Launch an interactive swipl shell with the task's solution loaded.
run task:
    #!/usr/bin/env bash
    set -euo pipefail
    code=$(basename "$(ls tasks/{{task}}/*.pl | grep -v tests.pl)")
    cmd="swipl -q $code"
    echo "$cmd"
    cd tasks/{{task}} && exec $cmd

# Compile a task's report to PDF.
report task:
    typst compile --root . tasks/{{task}}/report.typ

# Run every task's test suite.
test-all:
    for d in tasks/*/; do \
        t=$(basename "$d"); \
        echo "== $t =="; \
        (cd "$d" && swipl -q -t halt tests.pl); \
    done
