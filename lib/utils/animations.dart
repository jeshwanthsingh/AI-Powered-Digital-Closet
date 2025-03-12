import 'package:flutter/material.dart';

/// Animation utilities for consistent motion design across the app
class AppAnimations {
  // Private constructor to prevent instantiation
  AppAnimations._();
  
  /// Standard durations
  static const Duration fastest = Duration(milliseconds: 150);
  static const Duration fast = Duration(milliseconds: 250);
  static const Duration normal = Duration(milliseconds: 350);
  static const Duration slow = Duration(milliseconds: 700);
  
  /// Standard curves
  static const Curve easeOutCubic = Cubic(0.33, 1, 0.68, 1);
  static const Curve easeInOutCubic = Cubic(0.65, 0, 0.35, 1);
  static const Curve easeInCubic = Cubic(0.32, 0, 0.67, 0);
  
  /// Spring-based curves for more natural motion
  static const SpringDescription gentleSpring = SpringDescription(
    mass: 1,
    stiffness: 170,
    damping: 26,
  );
  
  static const SpringDescription bouncy = SpringDescription(
    mass: 1,
    stiffness: 200,
    damping: 15,
  );
  
  /// Page transitions
  static PageRouteBuilder<T> fadeThrough<T>(Widget page) {
    return PageRouteBuilder<T>(
      transitionDuration: normal,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
  
  static PageRouteBuilder<T> slideUp<T>(Widget page) {
    return PageRouteBuilder<T>(
      transitionDuration: normal,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = easeOutCubic;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
  
  /// Staggered animations for list items
  static Animation<double> staggeredAnimation(
    Animation<double> animation,
    int index, {
    int itemCount = 20,
    Duration duration = normal,
  }) {
    final double start = index / itemCount;
    final double end = (index + 1) / itemCount;
    final curve = Interval(start, end, curve: easeOutCubic);
    return CurvedAnimation(parent: animation, curve: curve);
  }
  
  /// Hero tag generator for smooth transitions
  static String heroTag(String id, String type) => '$type-$id';
  
  /// Shimmer loading effect
  static Widget shimmerLoading(Widget child) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return LinearGradient(
          colors: [
            Colors.grey.shade200,
            Colors.grey.shade100,
            Colors.grey.shade200,
          ],
          stops: const [0.1, 0.3, 0.4],
          begin: const Alignment(-1, -0.3),
          end: const Alignment(1, 0.3),
          tileMode: TileMode.clamp,
        ).createShader(bounds);
      },
      child: child,
    );
  }
}

/// Animated visibility widget with customizable transitions
class AnimatedVisibilityWidget extends StatelessWidget {
  final bool isVisible;
  final Widget child;
  final Duration duration;
  final Curve curve;
  final bool maintainState;
  final bool maintainAnimation;
  final bool maintainSize;
  final bool maintainSemantics;
  final bool maintainInteractivity;
  
  const AnimatedVisibilityWidget({
    Key? key,
    required this.isVisible,
    required this.child,
    this.duration = const Duration(milliseconds: 250),
    this.curve = Curves.easeInOut,
    this.maintainState = false,
    this.maintainAnimation = false,
    this.maintainSize = false,
    this.maintainSemantics = false,
    this.maintainInteractivity = false,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: curve,
      switchOutCurve: curve,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: SizeTransition(
            sizeFactor: animation,
            axisAlignment: -1,
            child: child,
          ),
        );
      },
      child: isVisible ? child : const SizedBox.shrink(),
    );
  }
}

/// Scale button with haptic feedback
class ScaleButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Duration duration;
  final double scaleSize;
  final bool enableHaptics;
  
  const ScaleButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.duration = const Duration(milliseconds: 150),
    this.scaleSize = 0.95,
    this.enableHaptics = true,
  }) : super(key: key);
  
  @override
  _ScaleButtonState createState() => _ScaleButtonState();
}

class _ScaleButtonState extends State<ScaleButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.scaleSize,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  void _onTapDown(TapDownDetails details) {
    if (widget.onPressed != null) {
      _controller.forward();
    }
  }
  
  void _onTapUp(TapUpDetails details) {
    if (widget.onPressed != null) {
      _controller.reverse();
      if (widget.enableHaptics) {
        // Add haptic feedback here when we add the package
      }
      widget.onPressed?.call();
    }
  }
  
  void _onTapCancel() {
    if (widget.onPressed != null) {
      _controller.reverse();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}

/// Fade in image with placeholder
class FadeInImageWidget extends StatelessWidget {
  final String? imageUrl;
  final Widget placeholder;
  final Widget errorWidget;
  final BoxFit fit;
  final Duration fadeInDuration;
  final Duration placeholderFadeOutDuration;
  
  const FadeInImageWidget({
    Key? key,
    required this.imageUrl,
    required this.placeholder,
    Widget? errorWidget,
    this.fit = BoxFit.cover,
    this.fadeInDuration = const Duration(milliseconds: 500),
    this.placeholderFadeOutDuration = const Duration(milliseconds: 300),
  }) : errorWidget = errorWidget ?? placeholder,
       super(key: key);
  
  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return placeholder;
    }
    
    return FadeInImage(
      placeholder: const AssetImage('assets/images/placeholder.png'),
      image: NetworkImage(imageUrl!),
      fit: fit,
      fadeInDuration: fadeInDuration,
      fadeOutDuration: placeholderFadeOutDuration,
      imageErrorBuilder: (context, error, stackTrace) => errorWidget,
    );
  }
}
