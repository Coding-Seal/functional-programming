---
name: report
description: Write or review a task report for this course (Соловьёв И.П., functional-programming). Covers report format, computation protocol notation, writing style, and how to verify a solution in this repo. Use whenever creating or editing the report-and-code file under tasks/taskN/, or asked to check/clean up an existing one.
---

# Writing a task report for this course

Reports themselves (headers, protocols, comments) must be written in Russian,
that's the language of submission.

## File layout

The report-and-code file (the part that gets submitted) holds the header
plus the solution plus the computation protocol, all in one file. See
CLAUDE.md for where that file and its tests live in this repo.

## Report header

Must always contain, in Russian:

- ФИО (full name)
- группа (group)
- номер задачи (task number)
- тема (topic)
- вычислительная модель (computational model)
- формулировка задачи (task statement)

## Computation protocol

For every step, state (Russian terms to reuse verbatim are given in
parentheses):

- a content comment (содержательный комментарий): what's happening and why,
  in terms of the task, not just the mechanics;
- the chosen subgoal (выбор подцели): which part of the current state is
  handled;
- the chosen rule (выбор правила): which fact/rule/production/axiom
  applies;
- the chosen substitution (выбор подстановки): unifier/variable binding,
  concretely.

Write out the current computation state explicitly at every step, using the
correct notation for the model, e.g. for Prolog that's the resolvent
(резольвента) — the current list of remaining subgoals, `R_i = { ... }`,
produced by SLD-resolution.

If the predicate/task can both succeed and fail, show the protocol for both
outcomes, not just the happy path.

## Terminology

Do not use the word "клауза" in Russian text, it sounds unnatural. Say
"факт" for a fact, "правило" for a rule with a body, or "предложение" as
the umbrella term when you need one word for both.

## Writing style

- No colored or small font. Plain text, normal size.
- Write like a student, not an AI: plain, formal, terse. No em dashes, no
  arrow symbols (→ ⇒ ⟹), no ellipsis-as-arrow, no padded column alignment,
  no over-explaining. Plain ASCII punctuation (colons, commas, periods),
  short sentences, minimal spacing.
- Markdown-style headers (`##`, etc.) for sections are fine, that's not an
  AI marker.
- Prefer simple language. Use the plainest word that's still correct. Keep
  required technical terms (резольвента, подстановка, факт, правило) but
  don't dress up the surrounding prose, e.g. "не совпадает с" instead of
  "не унифицируется с" where either reads fine.

## Don't restate these instructions in the report

Follow this checklist, but don't copy it into the report itself (e.g. a
line like "На каждом шаге: комментарий, подцель, правило, подстановка").
The report should only contain content specific to this task: the header,
the solution, and the actual protocol steps. A note defining notation you
then use (e.g. "R_i резольвента после шага i") is fine, that's task
content, not a restated instruction.

## Don't leak the dev environment into the report

The report is submitted to the teacher, who doesn't use this repo. Never
mention `just`, `devenv`, the `tests.pl` file, swipl invocation commands,
or any other detail of how this repo is set up or tested. The report is
just the header, the solution, and the protocol — nothing about tooling.

## Verifying a solution

Run `devenv shell -- just test taskN` and make sure all tests in that
task's `tests.pl` pass, including at least one success case and one
failure case, before considering a task done.

## Maintaining this skill

When the user corrects the report/protocol format or confirms a good
choice, add it here as its own bullet. Check against existing bullets
first: update one instead of duplicating, and drop what's stale. Keep this
file short, it's a checklist of rules, not a log.
