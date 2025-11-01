# Agents Notebook

## Project Snapshot
- Flutter app in `lib/main.dart` bootstrapping Riverpod-driven feature modules.
- Core layer split into `application`, `data`, and `domain` folders with repositories, entities, and use cases.
- Feature slices under `lib/src/features/<feature>` each expose `application`, `presentation`, and sometimes `widgets`.
- Custom theming lives in `lib/src/theme` with `app_theme.dart` and related helpers; routing logic resides in `lib/src/routing`.

## Testing & Tooling
- Widget/unit tests organized in `test/core/...` and `test/features/...`.
- `analysis_options.yaml` enables strict lints (trailing commas, directives ordering, prefer_const, etc.).
- Custom utilities live in `tool/` (e.g., `contrast_audit.dart` for theme contrast checks).

## Common Commands
- `flutter analyze` for lint enforcement (ensure Flutter SDK cache is healthy first).
- `flutter test` or scoped `flutter test test/features/...` for regression coverage.
- `dart run tool/contrast_audit.dart` to scan color usage against theme guidelines.

## Reference Docs
- Domain specs: `APP_FEATURES_SPEC.md`, `PROGRESSION_TEMPLATES.md`.
- Visual/theme guidance: `THEME_SPECIFICATION.md`, `THEME_USAGE_GUIDE.md`, `THEME_UPGRADE_SUMMARY.md`, `CONTRAST_FIX_VISUALIZATION.md`.
- Implementation checklists: `IMPLEMENTATION_CHECKLIST.md`, `GYMNASTICBODIES_RESEARCH.md`, `VISUAL_PROGRESSION_CHART.md`.

## Notes for Future Agents
- Many lint warnings relate to trailing commas and deprecations; prefer `.withValues(alpha: …)` instead of `.withOpacity`.
- When editing providers/controllers, watch for caching hooks like `TemplateRepository.invalidateCache`.
- Keep line length ≤ 80 chars; analyzer enforces this across lib and test sources.
