**Contributing Guide**

**Code Style & Lints**
- Format with `dart format .`
- Lints via `very_good_analysis`; see `analysis_options.yaml`
- Prefer small, pure widgets and feature-first organization

**Architecture Rules**
- Presentation: Widgets + Riverpod state only
- Domain: Pure Dart, no Flutter imports
- Data: Implement repositories; never import UI
- Use cases return `Either<Failure, T>`
- All state/data models are immutable (freezed or manually immutable)

**Workflow**
- `flutter pub get`
- `dart run build_runner build --delete-conflicting-outputs`
- `flutter analyze && flutter test`

**Commit Messages**
- Conventional style: `feat:`, `fix:`, `docs:`, `refactor:`, `test:`, `chore:`

