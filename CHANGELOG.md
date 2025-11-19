# Changelog

All notable changes to this package will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) and follows [Semantic Versioning](https://semver.org/).

---

## [1.1.3] - 2025-11-20  
### Changed
- Add Package Screenshot to README.md.
- Updated documentation to better explain forward/backward flip behavior and top/bottom page support.

## [1.1.2] - 2025-11-20  
### Changed
- Improved readability for users by refining descriptions of newly added flash-card page flipping animations.
- Updated documentation to better explain forward/backward flip behavior and top/bottom page support.

## [1.1.1] - 2025-11-19
### Added
- Forward and backward page flipping animations for flash cards.
- Support for top and bottom pages with customizable content.
- DecorationImage support for page flip GIFs.
- Customizable card height, colors, border radius, and margins.
- Assets folder included for example images (`assets/images/`).

### Fixed
- Asset loading issue: ensured `package:` parameter is used for all AssetImage references.
- Assertion added to enforce that `topPages` and `bottomPages` lists have equal length.

---

## [1.0.0] - 2025-11-10
### Added
- Initial release of `animated_flash_cards` package.
- Basic flash card widget with flipping animation.
- Configurable properties for card appearance (colors, border radius, height).
- Basic support for top and bottom pages list.

