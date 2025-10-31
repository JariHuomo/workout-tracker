**Roadmap**

- Updated: 2025-10-31

**MVP (In Progress)**
- [x] Exercises CRUD with ladder generator
- [x] Sessions with background-safe rest timer
- [x] Pass/fail and level advance
- [x] History list (persisted)
- [x] Templates browser and template → exercise levels
- [ ] Drift migration (SQLite) for robustness and queries
- [ ] Dashboard with quick-start, week summary, and mini charts
- [ ] History filters and charts
- [ ] Foreground countdown beeps, haptics language
- [ ] Onboarding, accessibility polish

**Post-MVP**
- Cloud sync (Supabase/Firebase)
- Achievements/badges, streaks, reminders
- Data export/import
- Advanced auto-regulation (RPE-based adjustments)

**Risks & Mitigations**
- Timer exactness on Android 12+ → offer Precise Alarms toggle with guidance
- Notification permission denial → in-app banner and fallback cues
- Data integrity on upgrade → migrations with Drift, backup on first launch of new schema

