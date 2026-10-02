default:
    just --list

# Scaffold a new task folder with a report template and an empty test suite.
new task topic:
    mkdir -p tasks/{{task}}
    cp templates/report_template.pl tasks/{{task}}/{{topic}}.pl
    sed 's/__TOPIC__/{{topic}}/g' templates/tests_template.pl > tasks/{{task}}/tests.pl
    echo "created tasks/{{task}}/{{topic}}.pl and tasks/{{task}}/tests.pl"

# Run the test suite for one task.
test task:
    cd tasks/{{task}} && swipl -q -t halt tests.pl

# Run every task's test suite.
test-all:
    for d in tasks/*/; do \
        t=$(basename "$d"); \
        echo "== $t =="; \
        (cd "$d" && swipl -q -t halt tests.pl); \
    done
