**Sprint Log**

- Project: Street Workout Tracker (Flutter)
- Owner: Jari
- Updated: 2025-10-31

**Sprint 0 — Foundations (2025-10-31 AM)**
- Defined Clean Architecture, feature-first structure, Riverpod DI, go_router
- Captured UI blueprints and creative themes
- Pinned dependencies; added `very_good_analysis`

**Sprint 1 — Core Entities & Screens**
- Added domain entities (Exercise, Level, Session, Attempts, TimerSettings)
- Implemented exercises list, create form with ladder generator, details with ladder
- Integrated Material 3 theme, routing, ProviderScope

**Sprint 2 — Sessions & Rest Timer**
- SessionController with states: idle/inProgress/resting/completed/failure
- Log sets (target/±1/custom), schedule local notification for rest end
- Background-safe rest (resume sync by wall clock), skip/±15s adjust
- Pass/fail evaluation; advance level on pass

**Sprint 3 — Persistence & History**
- Persist sessions via SharedPreferences
- History screen: list sessions with pass/fail, target vs attempts, timestamps

**Sprint 4 — Templates**
- Template data loader from assets; template browser UI `/templates`
- Apply template to exercise (auto-generate levels, mark deload weeks)
- Exercise form template picker and summary

**Sprint 5 — Hardening & Tests**
- Notification service permissions, cancel/reschedule logic
- Tests: pass evaluation, session timer flow with fake time, repository persistence, templates parsing/UI

**Known Blockers**
- Local Flutter SDK broken in this environment; cannot run `flutter test` here

**Next Sprints**
- Drift migration, dashboard & charts, history filters, onboarding & polish

