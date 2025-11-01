import 'package:flutter/material.dart';
import 'package:workouttracker/src/theme/app_theme.dart';
import 'package:workouttracker/src/theme/theme_extensions.dart';

/// Custom button styles for semantic actions
/// Usage: FilledButton(style: AppButtonStyles.success(context), ...)
class AppButtonStyles {
  const AppButtonStyles._();

  /// Success button style (green) - for completion, confirmation actions
  static ButtonStyle success(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return FilledButton.styleFrom(
      backgroundColor: AppColors.successGreen,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.l,
        vertical: AppSpacing.m,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      elevation: isDark ? AppElevation.level2 : AppElevation.level0,
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }

  /// Warning button style (amber) - for caution actions
  static ButtonStyle warning(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return FilledButton.styleFrom(
      backgroundColor: AppColors.warningAmber,
      foregroundColor: AppColors.richBlack,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.l,
        vertical: AppSpacing.m,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      elevation: isDark ? AppElevation.level2 : AppElevation.level0,
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }

  /// Danger/Destructive button style (orange-red) - for delete, destructive actions
  static ButtonStyle danger(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return FilledButton.styleFrom(
      backgroundColor: AppColors.energeticOrange,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.l,
        vertical: AppSpacing.m,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      elevation: isDark ? AppElevation.level2 : AppElevation.level0,
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }

  /// Info button style (cyan) - for informational actions
  static ButtonStyle info(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return FilledButton.styleFrom(
      backgroundColor: AppColors.neonCyan,
      foregroundColor: AppColors.richBlack,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.l,
        vertical: AppSpacing.m,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      elevation: isDark ? AppElevation.level2 : AppElevation.level0,
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }

  /// Secondary button style (purple) - for secondary actions
  static ButtonStyle secondary(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return FilledButton.styleFrom(
      backgroundColor: AppColors.vibrantPurple,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.l,
        vertical: AppSpacing.m,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      elevation: isDark ? AppElevation.level2 : AppElevation.level0,
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }

  /// Large button variant - for hero CTAs
  static ButtonStyle large(BuildContext context) {
    return FilledButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.l,
      ),
      minimumSize: const Size(double.infinity, 56),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
      ),
    );
  }

  /// Small button variant - for compact spaces
  static ButtonStyle small(BuildContext context) {
    return FilledButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.m,
        vertical: AppSpacing.s,
      ),
      minimumSize: const Size(0, 36),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.medium),
      ),
      textStyle: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
    );
  }
}

/// Gradient button widget for hero CTAs
class GradientButton extends StatelessWidget {
  const GradientButton({
    required this.onPressed,
    required this.child,
    this.gradient,
    this.borderRadius,
    this.padding,
    super.key,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final Gradient? gradient;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final effectiveGradient = gradient ?? AppColors.primaryGradient;
    final effectiveBorderRadius =
        borderRadius ?? BorderRadius.circular(AppRadius.large);
    final effectivePadding = padding ??
        const EdgeInsets.symmetric(
          horizontal: AppSpacing.l,
          vertical: AppSpacing.m,
        );

    return Container(
      decoration: BoxDecoration(
        gradient: onPressed == null ? null : effectiveGradient,
        borderRadius: effectiveBorderRadius,
      ),
      child: Material(
        color: onPressed == null
            ? Theme.of(context).disabledColor
            : Colors.transparent,
        borderRadius: effectiveBorderRadius,
        child: InkWell(
          onTap: onPressed,
          borderRadius: effectiveBorderRadius,
          child: Container(
            padding: effectivePadding,
            child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

/// Icon button with semantic colors
class SemanticIconButton extends StatelessWidget {
  const SemanticIconButton({
    required this.icon,
    required this.onPressed,
    this.type = SemanticButtonType.primary,
    this.tooltip,
    super.key,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final SemanticButtonType type;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    Color getColor() {
      switch (type) {
        case SemanticButtonType.primary:
          return Theme.of(context).colorScheme.primary;
        case SemanticButtonType.secondary:
          return AppColors.vibrantPurple;
        case SemanticButtonType.success:
          return AppColors.successGreen;
        case SemanticButtonType.warning:
          return AppColors.warningAmber;
        case SemanticButtonType.danger:
          return AppColors.energeticOrange;
        case SemanticButtonType.info:
          return AppColors.neonCyan;
      }
    }

    final button = IconButton(
      icon: Icon(icon),
      onPressed: onPressed,
      color: getColor(),
    );

    if (tooltip != null) {
      return Tooltip(
        message: tooltip,
        child: button,
      );
    }

    return button;
  }
}

enum SemanticButtonType {
  primary,
  secondary,
  success,
  warning,
  danger,
  info,
}
