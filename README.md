# Street Workout Tracker - Project Documentation
## GymnasticBodies-Inspired Progressive Calisthenics App

**Research Date**: October 31, 2025
**Status**: Active Development (MVP ~55% complete)
**Created For**: Jari's Workout Tracker Project

---

## 📁 Documentation Files

For implementation-focused documentation (how to run, architecture, sprint log), see:
- `docs/DEV_README.md`
- `docs/ARCHITECTURE.md`
- `docs/SETUP.md`
- `docs/SPRINT_LOG.md`
- `docs/ROADMAP.md`

### 1. [GYMNASTICBODIES_RESEARCH.md](./GYMNASTICBODIES_RESEARCH.md)
**Complete research findings about GymnasticBodies training methodology**

**Contents:**
- ✅ Core training philosophy
- ✅ Mastery template system explained
- ✅ Steady State Cycle (SSC) methodology
- ✅ Set/rep methodology
- ✅ Feedback-based auto-regulation
- ✅ Example progressions
- ✅ Key differences from typical calisthenics programs
- ✅ Resources & limitations

**Key Takeaway**: GymnasticBodies uses a mastery-based progression system with 12-week cycles, automatic deload weeks (every 4th week), and requires 5 sets × 15 reps (or 5 sets × 60s holds) before advancing to next exercise level.

---

### 2. [PROGRESSION_TEMPLATES.md](./PROGRESSION_TEMPLATES.md)
**8 detailed progression templates with week-by-week protocols**

**Templates Included:**
1. ✅ **Linear Progression** (19 weeks) - Standard approach, +1 rep/week
2. ✅ **Accelerated Progression** (10 weeks) - Fast track, +2 reps/week
3. ✅ **Conservative Progression** (30 weeks) - Very gradual, +1 rep/2 weeks
4. ✅ **Hold Progression** (15 weeks) - For timed holds, +5s/week
5. ✅ **Wave Loading** (17 weeks) - Undulating pattern
6. ✅ **Variable Set Progression** (10 weeks) - Increase sets first, then reps
7. ✅ **Grease the Groove** (14 weeks) - Multiple daily sessions
8. ✅ **Beginner-Friendly** (24 weeks) - Absolute beginner protocol

**Bonus:**
- Deload calculation formulas
- Auto-regulation rules
- Database schema examples
- Visual progress indicators
- Testing recommendations

---

### 3. [APP_FEATURES_SPEC.md](./APP_FEATURES_SPEC.md)
**Complete app specification with features, UI/UX, and technical architecture**

**Sections:**
- ✅ Core features (10 major features)
- ✅ Exercise progression system (6-level structure)
- ✅ Workout tracking UI mockups
- ✅ Progress visualization
- ✅ Deload management
- ✅ Mastery system & badges
- ✅ Auto-regulation features
- ✅ Tech stack recommendations
- ✅ Database schema (SQL)
- ✅ Development roadmap (3 phases)
- ✅ Monetization strategy
- ✅ Competitive analysis

---

## 🎯 Quick Start Guide

### What You Have Now
1. **Research Foundation**: Complete understanding of GymnasticBodies methodology
2. **Progression Templates**: 8 ready-to-implement templates with exact week-by-week protocols
3. **App Specification**: Full feature list, UI mockups, and technical architecture

### What to Build First (MVP)

#### Core Components
```
1. Exercise Library
   └── 30+ exercises across 6 movement patterns
   └── Each with 6 progressive levels

2. Template System
   └── 3 preset templates (Beginner, Standard, Accelerated)
   └── Week-by-week protocols pre-programmed

3. Workout Logger
   └── Track sets × reps for each session
   └── Check off completed sets
   └── Rate workout difficulty (1-5 stars)

4. Progress Tracker
   └── Visual progress bar to mastery
   └── Automatic deload week scheduling
   └── Mastery detection & celebration

5. Local Database
   └── SQLite for offline-first functionality
   └── Store workouts, progress, templates
```

---

## 📊 Key Numbers & Standards

### Mastery Standards
- **Reps Target**: 5 sets × 15 reps
- **Holds Target**: 5 sets × 60 seconds
- **Deload Frequency**: Every 4 weeks
- **Deload Reduction**: 33% (Current reps × 0.67)

### Progression Structure
- **Levels per Exercise**: 6 (Beginner → Elite)
- **Weeks per Level**: 10-30 weeks (template-dependent)
- **Total Timeline**: 2-3 years to master all 6 levels of one movement

### Exercise Categories
1. Push (horizontal)
2. Pull (horizontal/vertical)
3. Legs (squat pattern)
4. Core - Hollow
5. Core - Arch
6. Vertical Push (handstand)
7. Skills (muscle-up, levers, etc.)

---

## 🗺️ Progression Example: Push-Ups

| Level | Exercise | Target | Est. Duration |
|-------|----------|--------|---------------|
| 1 | Wall Push-Ups | 5×15 | 8-12 weeks |
| 2 | Incline Push-Ups | 5×15 | 8-12 weeks |
| 3 | Knee Push-Ups | 5×15 | 8-12 weeks |
| 4 | Regular Push-Ups | 5×15 | 12-16 weeks |
| 5 | Decline Push-Ups | 5×15 | 12-16 weeks |
| 6 | Pseudo Planche | 5×15 | 16-24 weeks |

**Total**: 64-92 weeks (1.5-2 years) to master all push-up progressions

---

## 📱 App Screen Flow

```
Launch App
    ↓
Dashboard (Progress Overview)
    ↓
Start Workout → Select Exercise
    ↓
Workout Screen (Log Sets/Reps)
    ↓
Rate Workout (1-5 stars)
    ↓
Auto-Adjust Next Session
    ↓
Progress Charts & Stats
    ↓
Mastery Achievement 🎉
    ↓
Unlock Next Level
```

---

## 🛠️ Tech Stack Recommendation

### Mobile App
**Option 1: React Native**
- Pros: JavaScript, large ecosystem, good for MVP
- Libs: React Navigation, AsyncStorage, Victory Charts

**Option 2: Flutter**
- Pros: Fast performance, beautiful UI, single codebase
- Libs: Provider, SQFlite, FL Chart

### Backend (Phase 2)
- **Firebase**: Quick setup, auth + database + storage
- **Supabase**: Open-source alternative, PostgreSQL

### Database
- **Phase 1**: SQLite (local-only)
- **Phase 2**: Firebase/Supabase (cloud sync)

---

## 🎨 Design Principles

### Visual Style
- ✅ Clean & minimal interface
- ✅ Progress-centric (always show where user is)
- ✅ Motivating colors (green = progress, gold = mastery)
- ✅ Dark mode support

### UX Features
- ✅ Swipe to complete sets
- ✅ Haptic feedback on success
- ✅ Offline-first (works without internet)
- ✅ Fast (<1s load times)

---

## 📈 Development Roadmap

### Phase 1: MVP (2-3 months)
- [ ] Build exercise library
- [ ] Implement 3 templates
- [ ] Create workout logger
- [ ] Add progress tracking
- [ ] Automatic deload scheduling
- [ ] Mastery detection

### Phase 2: Enhancement (1-2 months)
- [ ] User ratings & auto-regulation
- [ ] Video tutorials
- [ ] Custom templates
- [ ] Data export
- [ ] Achievements

### Phase 3: Advanced (2-3 months)
- [ ] Cloud sync
- [ ] Social features
- [ ] AI form checker
- [ ] Community

---

## 💡 Unique Selling Points

What makes this app different:

1. **Mastery-Based**: Can't skip levels (prevents ego-lifting)
2. **Automatic Deloads**: Injury prevention built-in
3. **Long-Term Focus**: Designed for years, not weeks
4. **Form-First**: Quality over quantity
5. **Science-Backed**: Based on proven GymnasticBodies methodology
6. **Offline-First**: No internet required

---

## 📝 Example Template: Linear Progression

**Target**: 5 sets × 15 reps
**Duration**: 19 weeks

| Week | Sets × Reps | Type |
|------|-------------|------|
| 1 | 5 × 1 | Work |
| 2 | 5 × 2 | Work |
| 3 | 5 × 3 | Work |
| 4 | 5 × 2 | **DELOAD** |
| 5 | 5 × 4 | Work |
| ... | ... | ... |
| 19 | 5 × 15 | **MASTERY** |

See [PROGRESSION_TEMPLATES.md](./PROGRESSION_TEMPLATES.md) for full details.

---

## 🎓 Learning from GymnasticBodies

### What We Adopted
✅ Mastery-based progression (can't skip)
✅ 12-week cycles with deloads
✅ Fixed standards (5×15 or 5×60s)
✅ Emphasis on connective tissue adaptation
✅ Feedback-based auto-regulation

### What We Adapted
🔄 Made templates explicit (GymnasticBodies hides them)
🔄 Added multiple progression speeds
🔄 Simplified to core principles
🔄 Made it accessible (GymnasticBodies is expensive)

---

## 🚀 Next Actions

### For Development
1. Choose tech stack (React Native vs Flutter)
2. Set up project structure
3. Create database schema
4. Build exercise library data
5. Implement Template 1 (Linear)
6. Design workout logging UI
7. Beta test with real users

### For Research
1. Film exercise tutorial videos
2. Write form cue descriptions
3. Test templates with real athletes
4. Gather user feedback
5. Refine progression protocols

---

## 📚 File Summary

| File | Purpose | Size |
|------|---------|------|
| README.md | This file - project overview | Quick ref |
| GYMNASTICBODIES_RESEARCH.md | Complete research findings | ~8,000 words |
| PROGRESSION_TEMPLATES.md | 8 templates + protocols | ~6,000 words |
| APP_FEATURES_SPEC.md | Full app specification | ~10,000 words |

**Total Documentation**: ~24,000 words of detailed planning & research

---

## 🎯 Success Criteria

### App Launch Goals
- ⭐ 4.5+ star rating
- 📱 1,000+ downloads in first month
- 💪 50%+ user retention at 30 days
- 🏆 10%+ mastery achievement rate

### User Outcomes
- 🎓 Users master at least 1 exercise in first 3 months
- 📊 90%+ deload adherence rate
- 🔥 Average 7+ day workout streak
- ⚡ <1% injury/overtraining rate

---

## 📞 Resources & References

### GymnasticBodies
- Official: https://www.gymnasticbodies.com
- Foundation Series courses
- "Building the Gymnastic Body" book

### Community Resources
- Antranik.org (SSC methodology)
- GymnasticBodies forum
- r/bodyweightfitness (Reddit)

### Technical Docs
- React Native: https://reactnative.dev
- Flutter: https://flutter.dev
- Firebase: https://firebase.google.com

---

## 🤝 Contributing

This is a personal project for Jari, but contributions welcome:

1. Exercise library expansion
2. Template refinements
3. UI/UX feedback
4. Beta testing
5. Form video creation

---

## 📄 License

Documentation: CC BY-SA 4.0
Code (when developed): TBD

---

## 🙏 Credits

**Research & Documentation**: Claude (Jules)
**Project Vision**: Jari
**Methodology Inspiration**: Christopher Sommer / GymnasticBodies
**Date**: October 31, 2025

---

**Status**: Ready to build! 🚀

---

## Quick Links

- [Full Research →](./GYMNASTICBODIES_RESEARCH.md)
- [Templates →](./PROGRESSION_TEMPLATES.md)
- [App Spec →](./APP_FEATURES_SPEC.md)

**Let's build something awesome!** 💪
