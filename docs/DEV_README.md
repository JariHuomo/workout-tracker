**Street Workout Tracker — Developer README**

- Purpose: practical, up-to-date instructions for running, developing, and testing the current Flutter app implementation.
- Date: 2025-10-31

**Status**
- Implementation progress: ~55% MVP complete
- Key modules working: Exercises, Sessions with rest timer (background-safe), Settings, History, Templates Browser
- Persistence: SharedPreferences JSON (migration to Drift/SQLite planned)

**Features Implemented**
- Exercises
  - Create exercise with ladder generator (sets, start/end reps, step, rest)
  - Assign template to auto-generate levels (deload-aware)
  - Set current starting level
- Sessions
  - Start at current level, log sets (target/−1/+1/custom)
  - Rest timer with background notification, resume sync, ±15s adjust, skip
  - Auto evaluate pass (all sets ≥ target) and enable Advance Level
- History
  - Persist sessions; view pass/fail, targets vs attempts, timestamps
- Templates
  - Load curated templates from `assets/data/templates_data.json`
  - List with difficulty, audience, deload cadence, week preview
- Settings
  - Default rest, precise alarms toggle, countdown beeps mode

**Project Structure**
- `lib/src/features/*` feature-first folders (presentation/application/data)
- `lib/src/core/*` shared domain/data/usecases/providers
- `lib/src/routing/app_router.dart` go_router config
- `lib/src/theme/app_theme.dart` Material 3 theme

**Clean Architecture**
- Domain (pure Dart): entities, repositories (abstract), use cases, failures
- Data: data sources (SharedPreferences/assets), repository implementations
- Presentation: Widgets + Riverpod Notifier/Providers

**Run Locally**
- Prereqs: Flutter SDK 3.24+ installed and healthy
- Commands:
  - `flutter pub get`
  - `dart run build_runner build --delete-conflicting-outputs`
  - `flutter run`

If the SDK is broken, repair and validate:
- `flutter doctor -v`
- Reinstall/refresh tool cache if needed: `git -C <flutter-sdk> clean -xfd && git -C <flutter-sdk> pull`

**Testing**
- Unit/widget tests exist under `test/` (pass evaluation, session timer flow, history/template UIs)
- Run:
  - `flutter test`

**Key Routes (go_router)**
- `/exercises` list (entry)
- `/exercises/new` form (with template picker)
- `/exercises/:id` details + level ladder
- `/session/:sessionId` active session
- `/history` sessions history
- `/templates` progression templates
- `/settings` preferences

**Development Tasks Remaining (MVP)**
- Migrate persistence to Drift (exercises, levels, sessions, attempts, templates)
- Dashboard with quick-start and analytics
- History filters (exercise/date) and charts
- Foreground countdown beeps and haptics language
- Onboarding and accessibility polish

**Coding Standards**
- Use Riverpod for state/DI, go_router for navigation, freezed for immutables, fpdart Either for errors
- Lints: `very_good_analysis` (see `analysis_options.yaml`)

**Troubleshooting**
- Templates not appearing → ensure asset listed in `pubspec.yaml` and run `flutter pub get`
- Notifications not firing on iOS → allow notifications on first prompt; check system settings
- Rest timer drift → on resume, app re-syncs by wall clock and cancels/updates notification

**Documents**
- Architecture: `docs/ARCHITECTURE.md`
- Setup: `docs/SETUP.md`
- Sprint log: `docs/SPRINT_LOG.md`
- Roadmap/Next steps: `docs/ROADMAP.md`

