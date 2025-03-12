import 'package:flutter/material.dart';
import '../../utils/animations.dart';

/// A customizable button with Material 3 design and animations
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final ButtonStyle? style;
  final Widget? icon;
  final bool iconTrailing;
  final double? width;
  final double? height;
  final bool enableAnimation;
  
  const AppButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.style,
    this.icon,
    this.iconTrailing = false,
    this.width,
    this.height,
    this.enableAnimation = true,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final buttonContent = SizedBox(
      width: width,
      height: height ?? 48,
      child: ElevatedButton(
        onPressed: (isEnabled && !isLoading) ? onPressed : null,
        style: style ?? ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          disabledBackgroundColor: colorScheme.surfaceVariant,
          disabledForegroundColor: colorScheme.onSurfaceVariant,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _buildButtonContent(colorScheme),
      ),
    );
    
    return enableAnimation && onPressed != null && isEnabled && !isLoading
        ? ScaleButton(
            onPressed: onPressed,
            child: buttonContent,
          )
        : buttonContent;
  }
  
  Widget _buildButtonContent(ColorScheme colorScheme) {
    if (isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            isEnabled ? colorScheme.onPrimary : colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }
    
    if (icon == null) {
      return Text(text);
    }
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: iconTrailing
          ? [
              Text(text),
              const SizedBox(width: 8),
              icon!,
            ]
          : [
              icon!,
              const SizedBox(width: 8),
              Text(text),
            ],
    );
  }
}

/// A customizable outlined button with Material 3 design
class AppOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final ButtonStyle? style;
  final Widget? icon;
  final bool iconTrailing;
  final double? width;
  final double? height;
  final bool enableAnimation;
  
  const AppOutlinedButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.style,
    this.icon,
    this.iconTrailing = false,
    this.width,
    this.height,
    this.enableAnimation = true,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final buttonContent = SizedBox(
      width: width,
      height: height ?? 48,
      child: OutlinedButton(
        onPressed: (isEnabled && !isLoading) ? onPressed : null,
        style: style ?? OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(
            color: isEnabled 
                ? colorScheme.outline 
                : colorScheme.outline.withOpacity(0.5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _buildButtonContent(colorScheme),
      ),
    );
    
    return enableAnimation && onPressed != null && isEnabled && !isLoading
        ? ScaleButton(
            onPressed: onPressed,
            child: buttonContent,
          )
        : buttonContent;
  }
  
  Widget _buildButtonContent(ColorScheme colorScheme) {
    if (isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            isEnabled ? colorScheme.primary : colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }
    
    if (icon == null) {
      return Text(text);
    }
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: iconTrailing
          ? [
              Text(text),
              const SizedBox(width: 8),
              icon!,
            ]
          : [
              icon!,
              const SizedBox(width: 8),
              Text(text),
            ],
    );
  }
}

/// A customizable text button with Material 3 design
class AppTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final ButtonStyle? style;
  final Widget? icon;
  final bool iconTrailing;
  final double? width;
  final double? height;
  final bool enableAnimation;
  
  const AppTextButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.style,
    this.icon,
    this.iconTrailing = false,
    this.width,
    this.height,
    this.enableAnimation = true,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final buttonContent = SizedBox(
      width: width,
      height: height ?? 48,
      child: TextButton(
        onPressed: (isEnabled && !isLoading) ? onPressed : null,
        style: style ?? TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: _buildButtonContent(colorScheme),
      ),
    );
    
    return enableAnimation && onPressed != null && isEnabled && !isLoading
        ? ScaleButton(
            onPressed: onPressed,
            child: buttonContent,
          )
        : buttonContent;
  }
  
  Widget _buildButtonContent(ColorScheme colorScheme) {
    if (isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            isEnabled ? colorScheme.primary : colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }
    
    if (icon == null) {
      return Text(text);
    }
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: iconTrailing
          ? [
              Text(text),
              const SizedBox(width: 8),
              icon!,
            ]
          : [
              icon!,
              const SizedBox(width: 8),
              Text(text),
            ],
    );
  }
}

/// A customizable icon button with Material 3 design
class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final Color? color;
  final double? size;
  final bool enableAnimation;
  final bool filled;
  final EdgeInsetsGeometry? padding;
  
  const AppIconButton({
    Key? key,
    required this.icon,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.color,
    this.size,
    this.enableAnimation = true,
    this.filled = false,
    this.padding,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final buttonContent = IconButton(
      onPressed: (isEnabled && !isLoading) ? onPressed : null,
      icon: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  isEnabled ? (color ?? colorScheme.primary) : colorScheme.onSurfaceVariant,
                ),
              ),
            )
          : Icon(
              icon,
              color: color ?? (filled ? colorScheme.onPrimary : colorScheme.primary),
              size: size,
            ),
      style: IconButton.styleFrom(
        backgroundColor: filled ? colorScheme.primary : null,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
    
    return enableAnimation && onPressed != null && isEnabled && !isLoading
        ? ScaleButton(
            onPressed: onPressed,
            child: buttonContent,
          )
        : buttonContent;
  }
}
