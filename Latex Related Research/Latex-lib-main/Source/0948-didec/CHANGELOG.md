# Changelog
All notable changes to this project will be documented in this file.

The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to
[Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
### Changed
### Deprecated
### Removed
### Fixed
### Security


## [1.2.1] - 2026-06-01

### Changed
- `f` type expansions replaced by `e`

### Fixed
- Code style improved with explcheck



## [1.2.0] - 2026-03-02

### Added
- Option `rounding` with two choices each providing several synonyms (issue #2):
    - `half-away-from-zero`, `commercial`, `DIN-1333`
    - `half-to-even`, `mathematical`, `IEEE-754`
  Rounding is applied only to floating-point expressions. 

### Changed
- Documentation partially rearranged; new section 'Option settings'
- The default rounding mode for floating-point expressions is now `half-away-from-zero`.
  To restore the previous default, use `\didecsetup{rounding=half-to-even}`.



## [1.1.1] - 2026-02-24

### Changed
- .tds.zip removed from CTAN upload to comply to CTAN rules
- TDS structure flattend on GitHub repository
- `README.md` adapted to these changes



## [1.1.0] - 2026-02-23

### Changed
- `CHANGES.md` renamed to `CHANGELOG.md` following https://keepachangelog.com/en/1.1.0/
- The initial values of `currency` and `didec/currency-negative` are now set to `euro`.
  Previously, no currency symbol was used (in contrast to the tutorial and examples).
- The styles `german`, `english`, `french`, and `float`, which set `decimal-separator` 
  and `grouping-separator`, no longer modify currency settings.
  Previously, they removed currency settings, which was not obvious.
- Some stylistic revisions in the documentation.

### Fixed
- Documentation produced with `minted2` instead of `minted` (currently not compatible to Python>=3.14)
- Obsolete (and now faulty) package loading of `l3benchmark` removed from the documentation 
    (it is part of l3kernel since June 2025)



## [1.0.0] - 2024-02-28

### Added
- Initial public release


## [-.-.-]
- Not public releases
