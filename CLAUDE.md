# functional-programming — course taught by Соловьёв И.П.

The course covers several computational models (Prolog/resolution,
possibly later — Turing machines, Markov normal algorithms, recursive
functions, combinatory logic, etc.).

## Project structure

- Every task lives in its own folder: `tasks/taskN/`.
- Each task folder has two parts:
  - the report-and-code file (e.g. `list3.pl`) — this is what gets
    submitted, report header + protocol + solution in one file;
  - `tests.pl` — automated tests for that task, not part of the
    submission.
- `tasks/task0/` is an exception: early learning/reference code
  (`hello.pl`, `my_lists.pl`), not a graded assignment. No report
  header required there, but it still has a `tests.pl` (a smoke test
  that both files consult cleanly) so tooling can treat every task
  folder uniformly.

## Tooling

- `devenv shell -- just new taskN topic` scaffolds `tasks/taskN/` from
  the templates in `templates/` (report header stub + empty test
  suite).
- `devenv shell -- just test taskN` runs that task's `tests.pl`.
- `devenv shell -- just test-all` runs every task's tests.

When writing, reviewing, or verifying a task report, use the `report`
skill — it has the format rules, protocol notation, and style guide.
