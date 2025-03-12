import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A customizable text field with Material 3 design
class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? minLines;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final bool filled;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final TextStyle? helperStyle;
  final BorderRadius? borderRadius;
  final double? height;
  
  const AppTextField({
    Key? key,
    this.controller,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.maxLines = 1,
    this.minLines,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.focusNode,
    this.validator,
    this.autovalidateMode,
    this.filled = true,
    this.fillColor,
    this.contentPadding,
    this.style,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.helperStyle,
    this.borderRadius,
    this.height,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return SizedBox(
      height: height,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: onSubmitted,
        inputFormatters: inputFormatters,
        maxLines: maxLines,
        minLines: minLines,
        enabled: enabled,
        readOnly: readOnly,
        autofocus: autofocus,
        focusNode: focusNode,
        validator: validator,
        autovalidateMode: autovalidateMode,
        style: style ?? theme.textTheme.bodyLarge?.copyWith(
          color: enabled ? colorScheme.onSurface : colorScheme.onSurfaceVariant,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          helperText: helperText,
          errorText: errorText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          filled: filled,
          fillColor: fillColor ?? colorScheme.surfaceVariant.withOpacity(0.3),
          contentPadding: contentPadding ?? const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          labelStyle: labelStyle ?? theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
          hintStyle: hintStyle ?? theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant.withOpacity(0.7),
          ),
          errorStyle: errorStyle ?? theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.error,
          ),
          helperStyle: helperStyle ?? theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
          border: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            borderSide: BorderSide(
              color: colorScheme.primary,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            borderSide: BorderSide(
              color: colorScheme.error,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            borderSide: BorderSide(
              color: colorScheme.error,
              width: 2,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

/// A customizable search field with Material 3 design
class AppSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final bool autofocus;
  final FocusNode? focusNode;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final BorderRadius? borderRadius;
  final double? height;
  
  const AppSearchField({
    Key? key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.onClear,
    this.autofocus = false,
    this.focusNode,
    this.fillColor,
    this.contentPadding,
    this.style,
    this.hintStyle,
    this.borderRadius,
    this.height,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return SizedBox(
      height: height,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        autofocus: autofocus,
        focusNode: focusNode,
        style: style ?? theme.textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSurface,
        ),
        decoration: InputDecoration(
          hintText: hintText ?? 'Search',
          prefixIcon: Icon(
            Icons.search,
            color: colorScheme.onSurfaceVariant,
          ),
          suffixIcon: controller?.text.isNotEmpty == true
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  onPressed: () {
                    controller?.clear();
                    onClear?.call();
                  },
                )
              : null,
          filled: true,
          fillColor: fillColor ?? colorScheme.surfaceVariant.withOpacity(0.3),
          contentPadding: contentPadding ?? const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          hintStyle: hintStyle ?? theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant.withOpacity(0.7),
          ),
          border: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            borderSide: BorderSide(
              color: colorScheme.primary,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}

/// A customizable dropdown field with Material 3 design
class AppDropdownField<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final Widget? prefixIcon;
  final bool enabled;
  final bool filled;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final BorderRadius? borderRadius;
  final double? height;
  
  const AppDropdownField({
    Key? key,
    this.value,
    required this.items,
    this.onChanged,
    this.labelText,
    this.hintText,
    this.errorText,
    this.prefixIcon,
    this.enabled = true,
    this.filled = true,
    this.fillColor,
    this.contentPadding,
    this.style,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.borderRadius,
    this.height,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return SizedBox(
      height: height,
      child: DropdownButtonFormField<T>(
        value: value,
        items: items,
        onChanged: enabled ? onChanged : null,
        style: style ?? theme.textTheme.bodyLarge?.copyWith(
          color: enabled ? colorScheme.onSurface : colorScheme.onSurfaceVariant,
        ),
        icon: Icon(
          Icons.arrow_drop_down,
          color: enabled ? colorScheme.onSurfaceVariant : colorScheme.onSurfaceVariant.withOpacity(0.5),
        ),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          errorText: errorText,
          prefixIcon: prefixIcon,
          filled: filled,
          fillColor: fillColor ?? colorScheme.surfaceVariant.withOpacity(0.3),
          contentPadding: contentPadding ?? const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          labelStyle: labelStyle ?? theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
          hintStyle: hintStyle ?? theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant.withOpacity(0.7),
          ),
          errorStyle: errorStyle ?? theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.error,
          ),
          border: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            borderSide: BorderSide(
              color: colorScheme.primary,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            borderSide: BorderSide(
              color: colorScheme.error,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            borderSide: BorderSide(
              color: colorScheme.error,
              width: 2,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
