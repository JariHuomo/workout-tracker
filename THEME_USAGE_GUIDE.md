# Theme Usage Guide - Street Workout Tracker

## Quick Start

### Importing Theme Files

```dart
import 'package:workouttracker/src/theme/app_theme.dart';
import 'package:workouttracker/src/theme/theme_extensions.dart';
import 'package:workouttracker/src/theme/button_styles.dart';
```

---

## Using Colors

### Standard Material Colors

```dart
// Access theme colors
final colorScheme = Theme.of(context).colorScheme;

// Primary colors
Container(
  color: colorScheme.primary, // Blue #2D5FFF
  child: Text(
    'Primary Action',
    style: TextStyle(color: colorScheme.onPrimary), // White
  ),
);

// Secondary colors
Container(
  color: colorScheme.secondary, // Purple #9333EA
  child: Text(
    'Secondary',
    style: TextStyle(color: colorScheme.onSecondary), // White
  ),
);

// Tertiary colors
Container(
  color: colorScheme.tertiary, // Cyan #06B6D4
  child: Text(
    'Tertiary',
    style: TextStyle(color: colorScheme.onTertiary), // Black
  ),
);
```

### Semantic Colors (Custom Extension)

```dart
// Access semantic colors
final semantic = context.semanticColors;

// Success states
Container(
  color: semantic.success, // Green
  child: Text(
    'Success!',
    style: TextStyle(color: semantic.onSuccess), // White
  ),
);

// Warning states
Container(
  color: semantic.warning, // Amber
  child: Text(
    'Warning',
    style: TextStyle(color: semantic.onWarning), // Black
  ),
);

// Info states
Container(
  color: semantic.info, // Cyan
  child: Text(
    'Info',
    style: TextStyle(color: semantic.onInfo), // Black
  ),
);
```

### Direct Color Access (For Gradients)

```dart
import 'package:workouttracker/src/theme/app_theme.dart';

// Use AppColors for direct access
Container(
  decoration: BoxDecoration(
    gradient: AppColors.primaryGradient,
  ),
);

// Or create custom gradients
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        AppColors.deepElectricBlue,
        AppColors.vibrantPurple,
      ],
    ),
  ),
);
```

---

## Using Buttons

### Standard FilledButton (Primary CTA)

```dart
// ✅ NOW PROPERLY DISPLAYS: White text on blue background
FilledButton(
  onPressed: () {},
  child: const Text('Start Session'),
);
```

### Semantic Button Styles

```dart
import 'package:workouttracker/src/theme/button_styles.dart';

// Success button (green)
FilledButton(
  style: AppButtonStyles.success(context),
  onPressed: () {},
  child: const Text('Complete'),
);

// Warning button (amber)
FilledButton(
  style: AppButtonStyles.warning(context),
  onPressed: () {},
  child: const Text('Caution'),
);

// Danger button (orange-red)
FilledButton(
  style: AppButtonStyles.danger(context),
  onPressed: () {},
  child: const Text('Delete'),
);

// Info button (cyan)
FilledButton(
  style: AppButtonStyles.info(context),
  onPressed: () {},
  child: const Text('Learn More'),
);

// Secondary button (purple)
FilledButton(
  style: AppButtonStyles.secondary(context),
  onPressed: () {},
  child: const Text('Secondary Action'),
);
```

### Button Size Variants

```dart
// Large button (full-width hero CTA)
FilledButton(
  style: AppButtonStyles.large(context),
  onPressed: () {},
  child: const Text('Start Workout'),
);

// Small button (compact spaces)
FilledButton(
  style: AppButtonStyles.small(context),
  onPressed: () {},
  child: const Text('Edit'),
);
```

### Gradient Button (Hero CTAs)

```dart
import 'package:workouttracker/src/theme/button_styles.dart';

GradientButton(
  onPressed: () {},
  child: const Text('Begin Training'),
  // Optional: custom gradient
  gradient: AppColors.primaryGradient,
);

// With custom styling
GradientButton(
  onPressed: () {},
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Icon(Icons.play_arrow, color: Colors.white),
      const SizedBox(width: 8),
      const Text('Start Now'),
    ],
  ),
  padding: const EdgeInsets.symmetric(
    horizontal: AppSpacing.xl,
    vertical: AppSpacing.l,
  ),
);
```

### Icon Buttons with Semantic Colors

```dart
import 'package:workouttracker/src/theme/button_styles.dart';

SemanticIconButton(
  icon: Icons.check_circle,
  onPressed: () {},
  type: SemanticButtonType.success,
  tooltip: 'Mark as complete',
);

SemanticIconButton(
  icon: Icons.delete,
  onPressed: () {},
  type: SemanticButtonType.danger,
  tooltip: 'Delete item',
);
```

---

## Using Spacing

### Standard Spacing Constants

```dart
import 'package:workouttracker/src/theme/theme_extensions.dart';

// Padding
Padding(
  padding: const EdgeInsets.all(AppSpacing.m), // 16dp
  child: child,
);

// Sized boxes for gaps
Column(
  children: [
    Text('Title'),
    const SizedBox(height: AppSpacing.xs), // 8dp
    Text('Subtitle'),
    const SizedBox(height: AppSpacing.l), // 24dp
    Widget(),
  ],
);

// Margins
Container(
  margin: const EdgeInsets.symmetric(
    horizontal: AppSpacing.m, // 16dp
    vertical: AppSpacing.xs,  // 8dp
  ),
);
```

### Available Spacing Values

```dart
AppSpacing.xxs  // 4dp
AppSpacing.xs   // 8dp
AppSpacing.s    // 12dp
AppSpacing.m    // 16dp (default)
AppSpacing.l    // 24dp
AppSpacing.xl   // 32dp
AppSpacing.xxl  // 48dp
AppSpacing.xxxl // 64dp
```

---

## Using Border Radius

```dart
import 'package:workouttracker/src/theme/theme_extensions.dart';

Container(
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(AppRadius.large), // 16dp
  ),
);

// Available radius values
AppRadius.small    // 8dp
AppRadius.medium   // 12dp
AppRadius.large    // 16dp (default for buttons/cards)
AppRadius.xlarge   // 20dp (for cards)
AppRadius.xxlarge  // 24dp
AppRadius.circle   // 999dp (fully rounded)
```

---

## Using Typography

### Text Styles from Theme

```dart
Text(
  'Display Large',
  style: Theme.of(context).textTheme.displayLarge,
);

Text(
  'Headline Medium',
  style: Theme.of(context).textTheme.headlineMedium,
);

Text(
  'Body text',
  style: Theme.of(context).textTheme.bodyLarge,
);

Text(
  'Button label',
  style: Theme.of(context).textTheme.labelLarge,
);
```

### Typography Scale Reference

| Style | Size | Weight | Usage Example |
|-------|------|--------|---------------|
| `displayLarge` | 57px | 800 | Onboarding headlines |
| `displayMedium` | 45px | 700 | Feature section titles |
| `displaySmall` | 36px | 700 | Marketing sections |
| `headlineLarge` | 32px | 700 | Screen titles |
| `headlineMedium` | 28px | 600 | AppBar titles |
| `headlineSmall` | 24px | 600 | Card headers, exercise names |
| `titleLarge` | 22px | 600 | List section headers |
| `titleMedium` | 16px | 600 | ListTile titles |
| `titleSmall` | 14px | 600 | Compact titles |
| `bodyLarge` | 16px | 400 | Primary body text |
| `bodyMedium` | 14px | 400 | Secondary text, descriptions |
| `labelLarge` | 14px | 600 | Button text, tabs |

---

## Using Cards

### Standard Card

```dart
Card(
  // Theme automatically applies:
  // - Border radius: 20dp
  // - Proper background color (dark/light)
  // - Border in dark mode
  // - No elevation (flat design)
  child: Padding(
    padding: const EdgeInsets.all(AppSpacing.m),
    child: Column(
      children: [
        Text('Card Title', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppSpacing.xs),
        Text('Card content'),
      ],
    ),
  ),
);
```

### Custom Card Styling

```dart
Container(
  decoration: BoxDecoration(
    color: Theme.of(context).colorScheme.surface,
    borderRadius: BorderRadius.circular(AppRadius.xlarge),
    border: Theme.of(context).brightness == Brightness.dark
        ? Border.all(
            color: context.semanticColors.cardBorder,
            width: 1,
          )
        : null,
  ),
  padding: const EdgeInsets.all(AppSpacing.m),
  child: child,
);
```

---

## Dark Mode Best Practices

### Checking Current Theme

```dart
final isDark = Theme.of(context).brightness == Brightness.dark;

Container(
  decoration: BoxDecoration(
    border: isDark
        ? Border.all(color: context.semanticColors.cardBorder)
        : null,
  ),
);
```

### Surface Colors in Dark Mode

```dart
// Background: richBlack (#0F0F0F)
Scaffold(
  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
);

// Card surface: deepCharcoal (#1A1A1A)
Container(
  color: Theme.of(context).colorScheme.surface,
);

// Elevated surface: carbonGray (#2A2A2A)
Container(
  color: Theme.of(context).colorScheme.surfaceContainerHighest,
);
```

### Text Colors in Dark Mode

```dart
// Primary text (white)
Text(
  'Primary text',
  style: TextStyle(
    color: Theme.of(context).colorScheme.onSurface,
  ),
);

// Secondary text (white at 70% opacity)
Text(
  'Secondary text',
  style: TextStyle(
    color: Theme.of(context).colorScheme.onSurfaceVariant,
  ),
);
```

---

## Common Patterns

### Section Header

```dart
Padding(
  padding: const EdgeInsets.symmetric(
    horizontal: AppSpacing.m,
    vertical: AppSpacing.xs,
  ),
  child: Text(
    'Section Title',
    style: Theme.of(context).textTheme.titleMedium,
  ),
);
```

### List Item

```dart
ListTile(
  contentPadding: const EdgeInsets.symmetric(
    horizontal: AppSpacing.m,
    vertical: AppSpacing.s,
  ),
  title: Text('Item Title'),
  subtitle: Text('Item description'),
  trailing: SemanticIconButton(
    icon: Icons.chevron_right,
    onPressed: () {},
    type: SemanticButtonType.primary,
  ),
);
```

### Form Field

```dart
TextField(
  decoration: InputDecoration(
    labelText: 'Label',
    hintText: 'Enter text...',
    // Theme automatically applies:
    // - Filled background
    // - 16dp border radius
    // - Focus border with primary color
    // - Proper padding
  ),
);
```

### Floating Action Button

```dart
FloatingActionButton(
  onPressed: () {},
  child: const Icon(Icons.add),
  // Theme automatically applies:
  // - Primary color background
  // - White foreground
  // - 20dp border radius
  // - Proper elevation
);
```

---

## Migration from Old Code

### Before (Contrast Issue)

```dart
❌ FilledButton(
  onPressed: () {},
  child: const Text('Start Session'),
);
// Result: Dark text on dark blue (poor contrast)
```

### After (Fixed)

```dart
✅ FilledButton(
  onPressed: () {},
  child: const Text('Start Session'),
);
// Result: White text on blue (perfect contrast)
```

The fix is automatic - no code changes needed! The theme now explicitly sets `onPrimary: Colors.white`.

---

## Testing Checklist

### Visual Inspection
- [ ] All FilledButtons have white text in both light and dark modes
- [ ] All buttons have minimum 48dp touch target
- [ ] Cards have subtle borders in dark mode
- [ ] Text contrast meets WCAG AA standards (4.5:1 minimum)
- [ ] Gradients render smoothly
- [ ] Icon colors match semantic intent

### Interactive Testing
- [ ] Button press states are visible
- [ ] Focus indicators appear on keyboard navigation
- [ ] Disabled states are clearly distinguished (38% opacity)
- [ ] Theme switching (light ↔ dark) is smooth
- [ ] No color flashing during theme transitions

---

## Troubleshooting

### Issue: Button text is still dark on dark background

**Solution:** Ensure you're using the latest `app_theme.dart` with explicit `onPrimary: Colors.white` in ColorScheme.

### Issue: Semantic colors not found

**Solution:** Import theme extensions:
```dart
import 'package:workouttracker/src/theme/theme_extensions.dart';
```

### Issue: Custom button styles not working

**Solution:** Import button styles:
```dart
import 'package:workouttracker/src/theme/button_styles.dart';
```

### Issue: Spacing constants not recognized

**Solution:** Use `AppSpacing.m` instead of hardcoded values, and ensure you've imported `theme_extensions.dart`.

---

## Additional Resources

- **Material Design 3**: https://m3.material.io/
- **Color Contrast Checker**: https://webaim.org/resources/contrastchecker/
- **Flutter Theme Documentation**: https://api.flutter.dev/flutter/material/ThemeData-class.html

---

**Last Updated**: 2025-10-31
**Theme Version**: 2.0 (Dark Mode Fixed)
