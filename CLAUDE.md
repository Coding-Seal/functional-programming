# functional-programming — course taught by Соловьёв И.П.

The course covers several computational models (Prolog/resolution,
possibly later — Turing machines, Markov normal algorithms, recursive
functions, combinatory logic, etc.).

## Project structure

- Every task lives in its own folder: `tasks/taskN/`.
- Each task folder has three parts:
  - a `.pl` file (e.g. `list3.pl`) — just the Prolog solution, no report
    content;
  - `report.typ` — the submission: header, solution (embeds the `.pl`
    file), screenshot, computation protocol;
  - `tests.pl` — automated tests for that task, not part of the
    submission.
- `tasks/task0/` is an exception: early learning/reference code
  (`hello.pl`, `my_lists.pl`), not a graded assignment. No report
  required there, but it still has a `tests.pl` (a smoke test
  that both files consult cleanly) so tooling can treat every task
  folder uniformly.
- `templates/protocol.typ` has the shared `proto-table` helper used by
  every report's protocol section.

## Tooling

- `devenv shell -- just new taskN topic` scaffolds `tasks/taskN/` from
  the templates in `templates/` (code stub, report template, empty
  test suite).
- `devenv shell -- just test taskN` runs that task's `tests.pl`.
- `devenv shell -- just test-all` runs every task's tests.
- `devenv shell -- just report taskN` compiles that task's `report.typ`
  to PDF.

When writing, reviewing, or verifying a task report, use the `report`
skill — it has the format rules, protocol notation, and style guide.
