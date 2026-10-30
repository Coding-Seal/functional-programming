// Shared "Протокол вычислений" table: one row per SLD-resolution step.
// Usage: proto-table(
//   [1. post(T\*, L)], [P1], [X1/'*', ...], [N1 = { ... } \ Комментарий.],
//   [2. post(T+, A1)], [P1], [X2/'+', ...], [N2 = { ... } \ Комментарий.],
// )
#let proto-table(..cells) = text(size: 9.5pt)[#table(
  columns: (24%, 13%, 18%, 1fr),
  inset: 7pt,
  align: left + top,
  row-gutter: 3pt,
  table.header(
    [*Шаг и выбранная подцель* $g_i$],
    [*Выбранное правило*],
    [*Выбранная подстановка* $sigma_i$],
    [*Резольвента* $R_i$ (через $N_i$) и комментарий],
  ),
  ..cells,
)]
