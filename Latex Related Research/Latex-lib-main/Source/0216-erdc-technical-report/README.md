# ERDC technical report

An original technical-report starter for a field pilot, with a formal report
cover, summary metrics, equations, tables, results, and handover checklist.

The `erdc` class is supplied by TeX Live and is not bundled. CTAN identifies the
package as released under the LaTeX Project Public License 1.3:
<https://ctan.org/pkg/erdc>.

The example does not use the upstream USACE cover artwork or logos.

The historical `erdc` class requests `mathgifg`, which is not included in the
pinned TeX distribution. The archive includes a small compatibility shim so the
class falls back to the standard math fonts; replace it with the original
mathgifg package if that font is required for a house-style match.
