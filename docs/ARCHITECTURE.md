**Architecture Overview**

- Date: 2025-10-31
- Pattern: Clean Architecture with feature-first layout

**Layers**
- Domain
  - Entities: `Exercise`, `Level`, `WorkoutSession`, `SetAttempt`, `TimerSettings`, `ProgressionTemplate`, `WeekProtocol`
  - Repositories (abstract): `ExerciseRepository`, `SessionRepository`, `PrefsRepository`, `TemplateRepository`
  - Use Cases: `CreateOrUpdateExercise`, `StartSession`, `RecordSetAttempt`, `EvaluateLevelPass`, `EndSession`, `AdvanceToNextLevel`, `GetSessions`, `GetTemplates`, `GenerateLevelsFromTemplate`, `ApplyTemplateToExercise`
  - Errors: `Failure.general`, `Failure.storage`
- Data
  - Data Sources: `ExerciseLocalDataSource`, `SessionLocalDataSource`, `PrefsLocalDataSource`, `TemplateLocalDataSource`
  - Repositories (impl): `ExerciseRepositoryImpl`, `SessionRepositoryImpl`, `PrefsRepositoryImpl`, `TemplateRepositoryImpl`
  - Current storage: SharedPreferences (JSON) and bundled assets (templates)
  - Planned storage: Drift/SQLite with DAOs and indices
- Presentation
  - State: Riverpod Notifier/Providers, immutable state via Freezed
  - Navigation: go_router, URL-like routes with deep-linkable session
  - Widgets: feature-first screens and shared components

**Routing**
- `/exercises`, `/exercises/new`, `/exercises/:id`, `/session/:sessionId`, `/history`, `/templates`, `/settings`

**Providers & DI**
- `appRouterProvider`, `appThemeProvider`
- Repository providers wired to local data sources
- Timer settings `StateNotifier`
- `sessionControllerProvider` handles session flow and rest ticker

**Timers & Notifications**
- Foreground: periodic 1s ticker from `SessionController`
- Background: local scheduled notification at rest end; on resume syncs from wall clock and cancels outdated notifications

**Immutability & Errors**
- All entities are `freezed`-based immutable value types (templates currently use immutable manual class)
- Use cases return `Either<Failure, T>` to avoid throwing through app layers

**Planned Drift Schema**
- Tables: `exercises`, `levels`, `sessions`, `set_attempts`, `templates`, `prefs`
- Indices: `sessions(exercise_id, started_at DESC)`, `set_attempts(session_id, set_index)`

