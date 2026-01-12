import 'package:flutter/material.dart';
import '../../utils/animations.dart';
import 'app_buttons.dart';

/// A loading state widget with Material 3 design
class AppLoadingState extends StatelessWidget {
  final String? message;
  final double size;
  final double strokeWidth;
  final Color? color;
  final bool useScaffold;
  
  const AppLoadingState({
    Key? key,
    this.message,
    this.size = 40,
    this.strokeWidth = 4,
    this.color,
    this.useScaffold = false,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              strokeWidth: strokeWidth,
              valueColor: AlwaysStoppedAnimation<Color>(
                color ?? colorScheme.primary,
              ),
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
    
    return useScaffold
        ? Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            body: content,
          )
        : content;
  }
}

/// A shimmer loading state for content placeholders
class AppShimmerLoading extends StatelessWidget {
  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;
  final Duration duration;
  
  const AppShimmerLoading({
    Key? key,
    required this.child,
    this.baseColor,
    this.highlightColor,
    this.duration = const Duration(milliseconds: 1500),
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return AppAnimations.shimmerLoading(child);
  }
}

/// An empty state widget with Material 3 design
class AppEmptyState extends StatelessWidget {
  final String title;
  final String? message;
  final IconData icon;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final bool useScaffold;
  final EdgeInsetsGeometry padding;
  
  const AppEmptyState({
    Key? key,
    required this.title,
    this.message,
    this.icon = Icons.inbox_outlined,
    this.buttonText,
    this.onButtonPressed,
    this.useScaffold = false,
    this.padding = const EdgeInsets.all(32),
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final content = Center(
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              const SizedBox(height: 8),
              Text(
                message!,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (buttonText != null && onButtonPressed != null) ...[
              const SizedBox(height: 24),
              AppButton(
                text: buttonText!,
                onPressed: onButtonPressed,
                icon: const Icon(Icons.add),
              ),
            ],
          ],
        ),
      ),
    );
    
    return useScaffold
        ? Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            body: content,
          )
        : content;
  }
}

/// An error state widget with Material 3 design
class AppErrorState extends StatelessWidget {
  final String title;
  final String? message;
  final IconData icon;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final bool useScaffold;
  final EdgeInsetsGeometry padding;
  
  const AppErrorState({
    Key? key,
    required this.title,
    this.message,
    this.icon = Icons.error_outline,
    this.buttonText = 'Try Again',
    this.onButtonPressed,
    this.useScaffold = false,
    this.padding = const EdgeInsets.all(32),
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final content = Center(
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: colorScheme.error.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              const SizedBox(height: 8),
              Text(
                message!,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (buttonText != null && onButtonPressed != null) ...[
              const SizedBox(height: 24),
              AppButton(
                text: buttonText!,
                onPressed: onButtonPressed,
                icon: const Icon(Icons.refresh),
              ),
            ],
          ],
        ),
      ),
    );
    
    return useScaffold
        ? Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            body: content,
          )
        : content;
  }
}
