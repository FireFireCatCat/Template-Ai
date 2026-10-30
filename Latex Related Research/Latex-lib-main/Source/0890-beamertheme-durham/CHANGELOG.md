
Durham Beamer Theme
===================

CHANGELOG
=========

Version 1.1.0 — Major Functional Update (CTAN Update)
------------------------------------------------------

This release represents a significant functional update to the Durham
Beamer Theme following the initial public release. It introduces structural
refinements, robustness improvements, and expanded user-level customization.

Major Enhancements
------------------

1. User-Defined Theme Color
   - Fully stabilized support for user-defined theme color via:
         \definecolor{Theme_Color}{HTML}{<code>}
   - Color redefinition supported after theme loading.
   - All structural elements respond consistently to updated color values.

2. Robust Section Title Handling (Math-Safe)
   - Eliminated fragile expansion mechanisms in section title processing.
   - Section titles now safely support mathematical expressions.
   - Improved truncation logic avoids expansion conflicts and compilation failures.

3. User-Configurable Outline and Thank You Slides
   - Outline page now accepts user-defined title:
         \makeoutline[Custom Title]
   - Thank You slide supports flexible syntax:
         \makethankyou
         \makethankyou{Line1}{Line2}
         \makethankyou[Line1]
         \makethankyou[Line1][Line2]
   - Defaults provided when no arguments are supplied.
   - Backward compatibility preserved.

4. Accessibility Mode
   - Refined high-contrast mode:
         \usetheme[accessibility]{durham}
   - Enforces strict black/white structural palette.
   - Maintains layout integrity while improving visual contrast.
   - Compatible with plain mode.

5. Plain and Invert Layout Modes
   - Plain mode removes headline and footline:
         \usetheme[plain]{durham}
   - Invert mode (requires plain):
         \usetheme[plain,invert]{durham}
   - Invert can also be combined with accessibility when used with plain:
         \usetheme[accessibility,plain,invert]{durham}


6. Table of Contents Structural Refinement
   - Replaced numeric hierarchy with filled-dot visual system.
   - Implemented consistent spacing logic:
       • Gap after subsection block (if subsections exist)
       • Gap after section title (if no subsections)
   - Improved visual hierarchy and long-deck readability.

7. Internal Code Stabilization
   - Cleaned and consolidated option handling logic.
   - Removed fragile constructs and redundant definitions.
   - Prepared codebase for LPPL-compliant CTAN update.
   - Formalized documentation structure.

Documentation Updates
---------------------

- Updated User Manual.
- Added formal CHANGELOG.
- Revised README for CTAN compliance.
- Clarified maintenance status and authorship.

Maintenance
-----------

Maintainer: Suhail Rizwan  
License: LaTeX Project Public License (LPPL) 1.3c or later  
Maintenance Status: Maintained


Version History
---------------

Version 1.0.0 — Initial Public Release
   - First CTAN submission.
   - Core structural layout and design philosophy established.
   - Initial accessibility support.
   - Outline and Thank You custom structure introduced.

