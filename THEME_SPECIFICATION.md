# Street Workout Tracker - Theme Specification

## Design System Philosophy
**Urban Athlete Powerhouse** - A bold, energetic design system that embodies street workout culture with professional polish.

---

## Color Palette

### Primary Colors
| Token | Hex Code | Usage | Contrast Requirements |
|-------|----------|-------|----------------------|
| `deepElectricBlue` | `#2D5FFF` | Primary actions, brand identity | WCAG AA compliant with white text |
| `vibrantPurple` | `#9333EA` | Secondary actions, accents | WCAG AA compliant with white text |

### Accent Colors
| Token | Hex Code | Usage | Notes |
|-------|----------|-------|-------|
| `neonCyan` | `#06B6D4` | Tertiary actions, highlights | Active states, info messages |
| `energeticOrange` | `#FF6B35` | Errors, warnings, destructive actions | Attention-grabbing |
| `successGreen` | `#10B981` | Success states, completion | Positive feedback |
| `warningAmber` | `#FBBF24` | Caution, pending states | Medium priority alerts |

### Dark Theme Surface Colors
| Token | Hex Code | Layer | Elevation |
|-------|----------|-------|-----------|
| `richBlack` | `#0F0F0F` | Background | 0dp |
| `deepCharcoal` | `#1A1A1A` | Cards, containers | 1dp-3dp |
| `carbonGray` | `#2A2A2A` | Elevated surfaces | 4dp-8dp |
| `smokeGray` | `#3F3F3F` | Borders, dividers | - |

### Light Theme Surface Colors
| Token | Hex Code | Layer | Elevation |
|-------|----------|-------|-----------|
| `cloudWhite` | `#FAFAFA` | Background | 0dp |
| `softGray` | `#F5F5F5` | Cards, containers | 1dp-3dp |
| `lightGray` | `#E5E5E5` | Borders, dividers | - |

---

## Typography Scale

### Font Weights
- **Extra Bold (800)**: Display text, hero headings
- **Bold (700)**: Headlines, section titles
- **Semi-Bold (600)**: Subheadings, emphasis, buttons
- **Medium (500)**: Labels, captions
- **Regular (400)**: Body text

### Type Styles
| Style | Size | Weight | Letter Spacing | Usage |
|-------|------|--------|----------------|-------|
| `displayLarge` | 57px | 800 | -0.25px | Hero headlines |
| `displayMedium` | 45px | 700 | 0px | Large feature titles |
| `displaySmall` | 36px | 700 | 0px | Section headers |
| `headlineLarge` | 32px | 700 | 0px | Screen titles |
| `headlineMedium` | 28px | 600 | 0px | Card headers |
| `headlineSmall` | 24px | 600 | 0px | Subsection headers |
| `titleLarge` | 22px | 600 | 0px | List headers |
| `titleMedium` | 16px | 600 | 0.15px | Component titles |
| `titleSmall` | 14px | 600 | 0.1px | Dense titles |
| `bodyLarge` | 16px | 400 | 0.5px | Primary body text |
| `bodyMedium` | 14px | 400 | 0.25px | Secondary body text |
| `labelLarge` | 14px | 600 | 0.1px | Button text, tabs |

---

## Component Specifications

### Buttons

#### FilledButton (Primary CTA)
```
Background: primary color (#2D5FFF)
Foreground: white (#FFFFFF)
Padding: 24px horizontal × 16px vertical
Border Radius: 16px
Min Height: 48px
Text Style: labelLarge (14px, weight 600)
Elevation: 0dp (flat design)
Disabled Opacity: 38%
```

**Dark Mode Fix**: MUST use `onPrimary: Colors.white` explicitly

#### ElevatedButton (Secondary CTA)
```
Background: surface color
Foreground: primary color
Padding: 24px horizontal × 16px vertical
Border Radius: 16px
Elevation: 2dp
Shadow: primary color with 15% opacity
```

#### OutlinedButton (Tertiary Action)
```
Background: transparent
Foreground: primary color
Border: 2px solid outline color
Border Radius: 16px
Padding: 24px horizontal × 16px vertical
```

#### TextButton (Inline Action)
```
Background: transparent
Foreground: primary color
Padding: 12px horizontal × 8px vertical
No border
```

### Cards
```
Background:
  - Light: #FAFAFA (surface)
  - Dark: #1A1A1A (deepCharcoal)
Border Radius: 20px
Padding: 16px
Elevation: 0dp
Border (Dark Mode Only): 1px solid smokeGray with 30% opacity
Shadow (Dark): deepElectricBlue with 20% opacity
Margin: 16px horizontal × 8px vertical
```

### Input Fields
```
Background:
  - Light: #F5F5F5 (softGray)
  - Dark: #2A2A2A (carbonGray)
Border Radius: 16px
Border: None (filled style)
Focus Border: 2px solid primary (#2D5FFF)
Error Border: 2px solid energeticOrange (#FF6B35)
Padding: 20px horizontal × 16px vertical
Min Height: 56px
Label: bodyMedium, weight 500
```

### Chips
```
Background:
  - Light: #F5F5F5
  - Dark: #2A2A2A
Border Radius: 12px
Padding: 12px horizontal × 8px vertical
Text: 13px, weight 600
Border (Dark): 1px solid smokeGray with 30% opacity
```

### AppBar
```
Background:
  - Light: #FAFAFA (matches scaffold)
  - Dark: #0F0F0F (matches scaffold)
Elevation: 0dp (seamless)
Title: headlineMedium (28px, weight 600)
Icon Color: onSurface color
Center Title: false (start-aligned)
```

### Floating Action Button
```
Background: primary color (#2D5FFF)
Foreground: white
Border Radius: 20px
Elevation:
  - Light: 4dp
  - Dark: 8dp (enhanced for depth)
Size: 56×56px (standard)
Icon Size: 24px
```

---

## Spacing System

### Standard Increments (8dp base unit)
- **XXS**: 4dp
- **XS**: 8dp
- **S**: 12dp
- **M**: 16dp (default)
- **L**: 24dp
- **XL**: 32dp
- **XXL**: 48dp

### Component Spacing
- Card margins: 16dp horizontal, 8dp vertical
- Section padding: 16dp all sides
- List item padding: 16dp horizontal, 12dp vertical
- Button padding: 24dp horizontal, 16dp vertical

---

## Accessibility

### Contrast Ratios
- **Primary text on background**: Minimum 7:1 (AAA)
- **Secondary text on background**: Minimum 4.5:1 (AA)
- **White text on primary blue**: 4.7:1 (AA) ✓
- **White text on vibrant purple**: 4.9:1 (AA) ✓

### Touch Targets
- Minimum: 48×48dp (Material Design guideline)
- Preferred: 56×56dp for primary actions

### Focus States
- All interactive elements MUST have visible focus indicators
- Focus ring: 2px solid primary color with 8dp offset

---

## Dark Mode Specific Enhancements

### Elevation Through Borders
Instead of heavy shadows, use subtle borders:
```
Border: 1px solid smokeGray at 30% opacity
```

### Glow Effects
For primary actions, add subtle glow:
```
Shadow: primary color at 20% opacity, 8dp blur radius
```

### Text Contrast
- Primary text: `#FAFAFA` (cloudWhite)
- Secondary text: `#FAFAFA` at 70% opacity
- Disabled text: `#FAFAFA` at 38% opacity

---

## Implementation Checklist

### Critical Fixes
- [x] Set explicit `onPrimary: Colors.white` in ColorScheme
- [x] Set explicit `onSecondary: Colors.white` in ColorScheme
- [x] Set explicit `onTertiary: Colors.black` for cyan accent
- [ ] Verify all button variants have proper contrast
- [ ] Test theme switching (light ↔ dark) for visual consistency

### Enhancements
- [ ] Add semantic color tokens (success, warning, error)
- [ ] Create custom button style variants
- [ ] Document gradient usage patterns
- [ ] Add animation duration constants

---

## Component Library Extensions

### Custom Widgets Needed
1. **GradientButton** - For hero CTAs with gradient backgrounds
2. **StatCard** - Elevated card with icon, value, and label
3. **ProgressRing** - Circular progress indicator with label
4. **LevelChip** - Custom chip for workout levels with icon
5. **SessionCard** - Card variant for workout session history

---

## Design Tokens (Future Enhancement)
Consider migrating to design token system:
- `colors.primary.500` → `#2D5FFF`
- `spacing.m` → `16dp`
- `radius.large` → `20px`
- `elevation.card` → `0dp`

This enables design-dev synchronization through tools like Figma Tokens.
