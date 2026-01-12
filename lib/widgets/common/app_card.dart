import 'package:flutter/material.dart';
import '../../utils/animations.dart';

/// A customizable card widget with Material 3 design and animations
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final double? elevation;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final bool enableAnimation;
  final bool useSurfaceTintColor;
  final bool useOutline;
  final Color? outlineColor;
  final double outlineWidth;
  
  const AppCard({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.elevation,
    this.borderRadius,
    this.onTap,
    this.enableAnimation = true,
    this.useSurfaceTintColor = true,
    this.useOutline = false,
    this.outlineColor,
    this.outlineWidth = 1.0,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final cardContent = Card(
      margin: margin ?? const EdgeInsets.all(0),
      elevation: elevation ?? 0,
      surfaceTintColor: useSurfaceTintColor ? colorScheme.surfaceTint : null,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        side: useOutline ? BorderSide(
          color: outlineColor ?? colorScheme.outline.withOpacity(0.5),
          width: outlineWidth,
        ) : BorderSide.none,
      ),
      color: backgroundColor ?? colorScheme.surface,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );
    
    if (onTap == null) {
      return cardContent;
    }
    
    return enableAnimation
        ? ScaleButton(
            onPressed: onTap,
            child: cardContent,
          )
        : InkWell(
            onTap: onTap,
            borderRadius: borderRadius ?? BorderRadius.circular(16),
            child: cardContent,
          );
  }
}

/// A card with a glassmorphic effect
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final double opacity;
  final bool enableAnimation;
  final Color? tintColor;
  
  const GlassCard({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.onTap,
    this.opacity = 0.1,
    this.enableAnimation = true,
    this.tintColor,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final cardContent = Container(
      margin: margin ?? const EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        color: (tintColor ?? colorScheme.primary).withOpacity(opacity),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ColorFilter.mode(
            (tintColor ?? colorScheme.primary).withOpacity(opacity),
            BlendMode.overlay,
          ),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );
    
    if (onTap == null) {
      return cardContent;
    }
    
    return enableAnimation
        ? ScaleButton(
            onPressed: onTap,
            child: cardContent,
          )
        : InkWell(
            onTap: onTap,
            borderRadius: borderRadius ?? BorderRadius.circular(16),
            child: cardContent,
          );
  }
}

/// A card with a neomorphic effect
class NeomorphicCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final bool enableAnimation;
  final bool isPressed;
  final Color? backgroundColor;
  final double intensity;
  
  const NeomorphicCard({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.onTap,
    this.enableAnimation = true,
    this.isPressed = false,
    this.backgroundColor,
    this.intensity = 1.0,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bgColor = backgroundColor ?? colorScheme.surface;
    
    final bool isDark = theme.brightness == Brightness.dark;
    
    final cardContent = AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: margin ?? const EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        color: bgColor,
        boxShadow: [
          // Top-left shadow (light)
          BoxShadow(
            color: (isDark ? Colors.black : Colors.white).withOpacity(0.5 * intensity),
            offset: Offset(isPressed ? -1 : -3, isPressed ? -1 : -3),
            blurRadius: isPressed ? 3 : 6,
            spreadRadius: isPressed ? 1 : 2,
          ),
          // Bottom-right shadow (dark)
          BoxShadow(
            color: (isDark ? Colors.black : Colors.grey.shade400).withOpacity(0.3 * intensity),
            offset: Offset(isPressed ? 1 : 3, isPressed ? 1 : 3),
            blurRadius: isPressed ? 3 : 6,
            spreadRadius: isPressed ? 1 : 2,
          ),
        ],
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );
    
    if (onTap == null) {
      return cardContent;
    }
    
    return enableAnimation
        ? ScaleButton(
            onPressed: onTap,
            child: cardContent,
          )
        : InkWell(
            onTap: onTap,
            borderRadius: borderRadius ?? BorderRadius.circular(16),
            child: cardContent,
          );
  }
}
