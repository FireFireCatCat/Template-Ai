# Fantasy / RPG Calendar

A calendar generator for fictional worlds — define your own year length,
month lengths, weekday names, leap-year rule, and recurring holidays, then
render a full year as one PDF. Ships pre-configured for the Forgotten
Realms "Calendar of Harptos" (D&D 5e): twelve 30/31-day months, 10-day
"weeks", a Shieldmeet leap day every 4 years, and named festival days
(Midwinter, Greengrass, Midsummer, Highharvestide, the Feast of the Moon).

Renders as a 12-page PDF, one month per page, year **200** (an arbitrary
in-world year — this calendar has no real-world date anchor). To use a
different setting, edit the `\FantasyCalendarAddMonths`,
`\FantasyCalendarAddDays`, `\DefineLeapYear` and `\FantasyCalendarDateEntry`
calls in `main.tex` — see the package's wiki
(https://github.com/Vidabe/FantasyCalendar/wiki) for the full macro
reference, or the upstream repo's other example files (`Klingon.tex`,
`Greorgian.tex`, `40k.tex`) for further starting points.

## Licence

LPPL-1.3c, per the upstream repository's `LICENSE` file (included in this
download) and the package's own README. Source:
https://github.com/Vidabe/FantasyCalendar
