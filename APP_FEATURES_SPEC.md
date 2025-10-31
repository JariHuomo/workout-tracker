# Street Workout Tracker - Feature Specifications
## GymnasticBodies-Inspired Progressive Calisthenics App

---

## App Overview

**Mission**: Create a comprehensive street workout tracking app with systematic progression inspired by GymnasticBodies methodology.

**Core Philosophy**:
- Progressive overload through exercise variations
- Mastery-based advancement (can't skip levels)
- Automatic deload weeks for recovery
- Long-term sustainable progression (months/years)
- Emphasis on form quality over quantity

---

## Core Features

### 1. Exercise Progression System

#### Exercise Library Structure
```
Movement Pattern (e.g., Push)
├── Level 1: Wall Push-Ups
│   ├── Tutorial Video
│   ├── Form Checklist
│   ├── Mastery Target: 5×15
│   └── Status: Locked/Unlocked/In Progress/Mastered
├── Level 2: Incline Push-Ups
│   └── ...
├── Level 3: Knee Push-Ups
├── Level 4: Regular Push-Ups
├── Level 5: Decline Push-Ups
└── Level 6: Pseudo Planche Push-Ups
```

#### Movement Patterns to Include
1. **Push** (6 levels)
2. **Pull** (6 levels)
3. **Legs** (6 levels)
4. **Core - Hollow** (6 levels)
5. **Core - Arch** (6 levels)
6. **Vertical Push** (Handstand progressions, 6 levels)
7. **Skills** (Muscle-up, Front Lever, etc., variable levels)

#### Exercise Data Model
```typescript
interface Exercise {
  id: string;
  name: string;
  movementPattern: string;
  level: number; // 1-6
  description: string;
  formCues: string[];
  videoUrl?: string;
  imageUrl?: string;
  masteryTarget: {
    sets: number;
    reps?: number;
    duration?: number; // for holds
  };
  prerequisites: string[]; // Exercise IDs that must be mastered first
  isLocked: boolean;
  isMastered: boolean;
}
```

---

### 2. Progression Templates

#### Template Selection Screen
**User chooses template based on experience level:**

| Template Name | Target Audience | Timeline | Description |
|---------------|----------------|----------|-------------|
| Beginner | Never trained | 6-8 months | Start from 1×1, very gradual |
| Conservative | Some experience | 5-7 months | +1 rep per 2 weeks |
| Standard | Regular training | 4-5 months | +1 rep per week (recommended) |
| Accelerated | Experienced | 2.5-3 months | +2 reps per week |
| Custom | Advanced | Variable | User defines progression |

#### Template Data Model
```typescript
interface ProgressionTemplate {
  id: string;
  name: string;
  description: string;
  targetAudience: string;
  estimatedWeeks: number;
  deloadFrequency: number; // Every N weeks
  deloadPercentage: number; // 0.33 = 33% reduction
  weeks: WeekProtocol[];
}

interface WeekProtocol {
  week: number;
  sets: number;
  reps: number;
  isDeload: boolean;
  notes?: string;
}
```

---

### 3. Workout Tracking

#### Daily Workout Screen

**Layout:**
```
┌─────────────────────────────────┐
│ Today's Workout - Week 7        │
│ Standard Template               │
├─────────────────────────────────┤
│ Regular Push-Ups (Level 4)      │
│ Target: 5 sets × 6 reps         │
│                                 │
│ Set 1: [✓] 6 reps  ⏱ 1:30 rest │
│ Set 2: [✓] 6 reps  ⏱ 1:30 rest │
│ Set 3: [✓] 6 reps  ⏱ 1:30 rest │
│ Set 4: [✓] 5 reps  ⏱ 1:30 rest │ ⚠️
│ Set 5: [ ] _ reps               │
│                                 │
│ Progress: 40% to Mastery        │
│ ▓▓▓▓▓▓░░░░░░░░░                 │
│                                 │
│ [Complete Workout]              │
└─────────────────────────────────┘
```

**Features:**
- ✅ Rest timer between sets (customizable)
- ✅ Check off completed sets
- ✅ Input actual reps performed
- ✅ Flag failed sets (auto-adjustment trigger)
- ✅ Progress bar to mastery
- ✅ Exercise form cues (expandable)
- ✅ Quick video reference

#### Workout Completion

**Post-Workout Survey:**
```
How did this workout feel?

⭐ (1) Too Easy - barely broke a sweat
⭐⭐ (2) Easy - could do more
⭐⭐⭐ (3) Just Right - good challenge
⭐⭐⭐⭐ (4) Hard - really struggled
⭐⭐⭐⭐⭐ (5) Too Hard - couldn't complete

[Submit Rating]
```

**Auto-Adjustment Based on Rating:**
- Rating 1-2: Suggest advancing faster
- Rating 3: Perfect, continue as planned
- Rating 4-5: Suggest slowing down or repeat week

---

### 4. Progress Tracking & Visualization

#### Progress Dashboard

**Overview Screen:**
```
┌─────────────────────────────────┐
│ Your Progress                   │
├─────────────────────────────────┤
│ Current Streak: 🔥 14 days      │
│ Workouts This Month: 12         │
│ Exercises Mastered: 3           │
├─────────────────────────────────┤
│ Active Exercises                │
│                                 │
│ 📊 Push-Ups (Level 4)           │
│    Week 7/19 - 40% Complete     │
│    ▓▓▓▓▓▓░░░░░░░░░              │
│    Next: Week 8 (Deload)        │
│                                 │
│ 📊 Pull-Ups (Level 2)           │
│    Week 3/19 - 15% Complete     │
│    ▓▓░░░░░░░░░░░░░░             │
│    Next: Week 4 (Deload)        │
│                                 │
│ 📊 Squats (Level 5)             │
│    Week 11/19 - 58% Complete    │
│    ▓▓▓▓▓▓▓▓▓░░░░░░░             │
│    Next: Week 12 (Deload)       │
└─────────────────────────────────┘
```

#### Mastery Timeline
```
┌─────────────────────────────────┐
│ Mastery History                 │
├─────────────────────────────────┤
│ 🏆 Wall Push-Ups                │
│    Mastered: Jan 15, 2025       │
│    Duration: 8 weeks            │
│                                 │
│ 🏆 Incline Push-Ups             │
│    Mastered: Mar 22, 2025       │
│    Duration: 10 weeks           │
│                                 │
│ 🏆 Knee Push-Ups                │
│    Mastered: Jun 8, 2025        │
│    Duration: 11 weeks           │
└─────────────────────────────────┘
```

#### Visual Charts
1. **Reps Over Time**: Line graph showing rep increases week by week
2. **Total Volume**: Bar chart of weekly total reps
3. **Consistency**: Calendar heatmap showing workout days
4. **Mastery Progress**: Circular progress rings for each exercise
5. **Deload Weeks**: Highlighted on all charts

---

### 5. Deload Management

#### Automatic Deload Scheduling

**System Rules:**
- Every 4th week = automatic deload
- Deload calculation: Current reps × 0.67 (33% reduction)
- User cannot skip deload weeks
- Deload weeks count toward progression timeline

**Deload Notification:**
```
┌─────────────────────────────────┐
│ 🛌 Deload Week Ahead            │
├─────────────────────────────────┤
│ Next week is your scheduled     │
│ recovery week. You'll reduce    │
│ volume by 33% to allow your     │
│ body to recover and adapt.      │
│                                 │
│ This is essential for long-term │
│ progress and injury prevention. │
│                                 │
│ Regular Push-Ups:               │
│ From: 5 × 6 reps                │
│ To:   5 × 4 reps                │
│                                 │
│ [Got It]                        │
└─────────────────────────────────┘
```

#### Deload Week Display
- Different color scheme (blue vs. normal green)
- Rest days emphasized
- Encouragement for active recovery (mobility, light cardio)
- Progress bar still advances (deload is part of progression)

---

### 6. Mastery System

#### Mastery Achievement

**When User Completes 5×15 (or target):**
```
┌─────────────────────────────────┐
│ 🎉 MASTERY ACHIEVED! 🎉         │
├─────────────────────────────────┤
│ You've mastered:                │
│ REGULAR PUSH-UPS                │
│                                 │
│ 💪 Completed: 5 sets × 15 reps  │
│ 📅 Duration: 19 weeks           │
│ 🔥 Consistency: 95%             │
│                                 │
│ Next Progression:               │
│ → Decline Push-Ups (Level 5)    │
│                                 │
│ [Start Next Level]              │
│ [Share Achievement]             │
└─────────────────────────────────┘
```

#### Badges & Achievements
- **First Mastery**: "Journey Begins"
- **3 Masteries**: "Dedicated Athlete"
- **6 Masteries**: "Foundation Complete"
- **Perfect Week**: All planned workouts completed
- **30-Day Streak**: Consistency King
- **100 Workouts**: Century Club
- **All Level 6 Exercises**: "Elite Bodyweight Athlete"

#### Mastery Lock System
- Level 2 exercises locked until Level 1 mastered
- Level 3 locked until Level 2 mastered
- etc.
- Visual "locked" icon with keyhole
- Tap locked exercise → shows prerequisite

---

### 7. Auto-Regulation Features

#### Failed Set Detection
**If user logs fewer reps than target:**
```
┌─────────────────────────────────┐
│ ⚠️ Adjustment Needed?           │
├─────────────────────────────────┤
│ You completed:                  │
│ Set 1: 6/6 ✓                    │
│ Set 2: 6/6 ✓                    │
│ Set 3: 5/6 ⚠️                   │
│ Set 4: 4/6 ⚠️                   │
│ Set 5: 4/6 ⚠️                   │
│                                 │
│ Recommendation:                 │
│ Repeat this week to build       │
│ strength before progressing.    │
│                                 │
│ [Follow Recommendation]         │
│ [Continue As Planned]           │
└─────────────────────────────────┘
```

#### Smart Suggestions
**Based on rating patterns:**
- 3+ consecutive "Too Easy" → Suggest jumping ahead
- 2+ consecutive "Too Hard" → Suggest stepping back
- Inconsistent performance → Suggest easier template
- Perfect performance → Celebrate and encourage

#### Custom Adjustments
**User can manually:**
- Add/remove reps from next session
- Skip to specific week in template
- Repeat current week
- Switch templates mid-progression

---

### 8. Exercise Form Guide

#### Form Checklist
**For each exercise:**
```
┌─────────────────────────────────┐
│ Regular Push-Up - Form Guide    │
├─────────────────────────────────┤
│ ✓ Body in straight line         │
│ ✓ Hands shoulder-width apart    │
│ ✓ Elbows at 45° angle           │
│ ✓ Chest touches ground          │
│ ✓ Full lockout at top           │
│ ✓ Controlled tempo (2-1-2)      │
│                                 │
│ [▶ Watch Tutorial Video]        │
│ [View Common Mistakes]          │
└─────────────────────────────────┘
```

#### Video Integration
- Short form tutorial (30-60s)
- Side-by-side comparison (good vs. bad form)
- Slow-motion breakdown
- Multiple camera angles
- Hosted on YouTube/Vimeo or in-app

---

### 9. Settings & Customization

#### User Preferences
```
Settings
├── Profile
│   ├── Name
│   ├── Experience Level
│   └── Goals
├── Templates
│   ├── Default Template
│   ├── Deload Frequency (3/4/5 weeks)
│   └── Deload Percentage (25%/33%/40%)
├── Workout
│   ├── Rest Timer Duration (30s/60s/90s/120s)
│   ├── Auto-start Rest Timer
│   └── Sound/Vibration Alerts
├── Notifications
│   ├── Workout Reminders
│   ├── Deload Week Alerts
│   └── Mastery Celebrations
└── Data
    ├── Export Workout History (CSV)
    ├── Backup Data
    └── Delete All Data
```

---

### 10. Social & Motivation Features

#### Sharing
- Share mastery achievements to social media
- Custom achievement cards with stats
- Progress snapshots (before/after)
- Workout summaries

#### Community (Future)
- Leaderboards (by exercise level)
- Friend challenges
- Training groups
- Form check requests

#### Motivation Tools
- Daily quotes/tips
- Progress reminders ("You're 40% to mastery!")
- Streak notifications
- Milestone celebrations

---

## Technical Architecture Recommendations

### Tech Stack Suggestions

#### Mobile App (React Native or Flutter)
**Pros:**
- Cross-platform (iOS + Android)
- Large ecosystem
- Good performance

**Key Libraries:**
- Chart library (victory-native, react-native-chart-kit)
- Video player (react-native-video)
- Local storage (AsyncStorage, SQLite)
- Animations (react-native-reanimated)

#### Backend (Optional - can start local-first)
- Firebase (authentication, database, storage)
- Supabase (open-source alternative)
- Custom API (Node.js + PostgreSQL)

#### Database Schema
```sql
-- Users
CREATE TABLE users (
  id UUID PRIMARY KEY,
  name VARCHAR(255),
  email VARCHAR(255) UNIQUE,
  experience_level VARCHAR(50),
  created_at TIMESTAMP
);

-- Exercises
CREATE TABLE exercises (
  id UUID PRIMARY KEY,
  name VARCHAR(255),
  movement_pattern VARCHAR(100),
  level INT,
  description TEXT,
  video_url VARCHAR(500),
  mastery_sets INT,
  mastery_reps INT,
  mastery_duration INT
);

-- Templates
CREATE TABLE templates (
  id UUID PRIMARY KEY,
  name VARCHAR(255),
  description TEXT,
  estimated_weeks INT,
  deload_frequency INT,
  deload_percentage DECIMAL(3,2)
);

-- Template Weeks
CREATE TABLE template_weeks (
  id UUID PRIMARY KEY,
  template_id UUID REFERENCES templates(id),
  week_number INT,
  sets INT,
  reps INT,
  is_deload BOOLEAN
);

-- User Progress
CREATE TABLE user_progress (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES users(id),
  exercise_id UUID REFERENCES exercises(id),
  template_id UUID REFERENCES templates(id),
  current_week INT,
  is_mastered BOOLEAN,
  mastered_at TIMESTAMP,
  created_at TIMESTAMP
);

-- Workouts
CREATE TABLE workouts (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES users(id),
  exercise_id UUID REFERENCES exercises(id),
  date DATE,
  planned_sets INT,
  planned_reps INT,
  completed_sets INT,
  actual_reps JSONB, -- [6,6,5,6,6]
  rating INT, -- 1-5
  notes TEXT
);
```

---

## UI/UX Design Principles

### Visual Style
- **Clean & Minimal**: Focus on data, reduce clutter
- **Progress-Centric**: Always show where user is vs. where they're going
- **Motivating Colors**: Green for progress, blue for deload, gold for mastery
- **Dark Mode Support**: Essential for gym environments

### Navigation Structure
```
Bottom Tab Bar:
├── 🏋️ Workout (main screen)
├── 📊 Progress (charts & stats)
├── 📚 Exercises (library browser)
└── ⚙️ Settings
```

### Key UX Features
- **Swipe gestures**: Swipe to complete sets
- **Quick actions**: Long-press for options
- **Haptic feedback**: Success vibrations
- **Offline-first**: Works without internet
- **Fast load times**: <1s to start workout

---

## Development Roadmap

### Phase 1: MVP (2-3 months)
- [ ] Exercise library (30+ exercises across 6 movement patterns)
- [ ] 3 preset progression templates
- [ ] Basic workout logging
- [ ] Progress tracking
- [ ] Automatic deload weeks
- [ ] Mastery detection
- [ ] Local data storage

### Phase 2: Enhancement (1-2 months)
- [ ] User ratings & auto-regulation
- [ ] Video tutorials for exercises
- [ ] Custom template builder
- [ ] Export workout data
- [ ] Notifications & reminders
- [ ] Achievement badges

### Phase 3: Advanced (2-3 months)
- [ ] User accounts & cloud sync
- [ ] Social sharing
- [ ] Multiple progression paths (holds, reps, advanced variations)
- [ ] AI form checker (camera + ML)
- [ ] Community features
- [ ] Premium features (custom programming, coaching)

---

## Monetization Strategy (Optional)

### Free Tier
- Full access to core features
- 3 preset templates
- Basic progress tracking
- 30 exercises

### Premium ($4.99/month or $39.99/year)
- Unlimited custom templates
- Full exercise library (100+ exercises)
- Advanced analytics
- Video form analysis
- Priority support
- Ad-free experience

### One-Time Purchase ($19.99)
- Lifetime access to all features
- One-time payment model
- All future updates included

---

## Success Metrics

### User Engagement
- Daily Active Users (DAU)
- Weekly Active Users (WAU)
- Average session duration
- Workout completion rate
- Streak retention (7-day, 30-day)

### Progression Metrics
- Average time to mastery per exercise
- Progression template preference
- Deload adherence rate
- Exercise dropout rate
- Mastery achievement rate

### App Health
- Crash rate (<1%)
- Load time (<2s)
- User retention (Day 1, 7, 30)
- Rating (target 4.5+ stars)
- Review sentiment

---

## Competitive Analysis

### Similar Apps
1. **StrongLifts 5×5**: Strength-focused, simple UI
2. **Calisthenics Mastery**: Exercise progressions, lacks templates
3. **Fitbod**: AI-driven, but more gym-focused
4. **THENX**: Professional production, subscription-heavy

### Unique Selling Points
✅ **Mastery-based progression** (can't skip levels)
✅ **Automatic deload weeks** (injury prevention)
✅ **GymnasticBodies methodology** (proven system)
✅ **Long-term focus** (months/years, not weeks)
✅ **Form-first approach** (quality over quantity)
✅ **Completely offline** (no internet required)

---

## Legal & Compliance

### Content Rights
- Create original exercise videos or license
- Avoid using GymnasticBodies trademarked content
- Credit methodology inspiration appropriately

### Privacy
- GDPR compliance (EU users)
- Clear data policy
- User data export option
- Account deletion capability

### Health Disclaimers
- "Consult physician before starting exercise program"
- "Not medical advice"
- Injury risk warnings

---

## Next Steps

### Immediate Actions
1. ✅ Finalize exercise library (exercises + progressions)
2. ✅ Create detailed wireframes for core screens
3. ✅ Set up development environment
4. ✅ Build database schema
5. ✅ Implement Template 1 (Linear Progression)
6. ✅ Create workout logging UI
7. ✅ Test with real users (beta)

### Questions to Answer
- Mobile app or web app first?
- React Native or Flutter?
- Local-only or cloud-sync from start?
- Free-only or freemium model?
- Exercise videos: DIY or hire talent?

---

**Document Created By**: Claude (Jules)
**Date**: October 31, 2025
**For**: Jari's Street Workout Tracker App
**Status**: Planning & Specification Phase
