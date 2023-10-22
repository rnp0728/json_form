import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

InputDecoration inputDecoration(String label, BorderRadius borderRadius,
    [EdgeInsets? contentPadding]) {
  return InputDecoration(
    label: Text(
      label,
    ),
    labelStyle: const TextStyle(
      color: Colors.black87,
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
    alignLabelWithHint: true,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    contentPadding: contentPadding ?? const EdgeInsets.fromLTRB(12, 8, 12, 8),
    enabledBorder: OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1.25,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: const BorderSide(
        color: Colors.green,
        width: 2,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: const BorderSide(
        color: Colors.red,
        width: 0.8,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: const BorderSide(
        color: Colors.red,
        width: 0.8,
      ),
    ),
  );
}

class CustomTextFormField extends StatelessWidget {
  final String label;
  final Widget? prefix;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final String? initialValue;
  final EdgeInsets? padding;
  final int maxLines;
  final bool obscureText;
  final AutovalidateMode autovalidateMode;
  final String? Function(String? value) validator;
  final void Function(String value) onChanged;
  final void Function(String value)? onFieldSubmitted;
  final void Function()? onTap;
  final bool? readOnly;
  final TextInputType? textInputType;
  final bool isDateField;
  final bool isTimeField;
  final FocusNode? focusNode;
  final Function()? onEditingComplete;
  final bool? enabled;
  final TextInputType? keyboardType;
  final int? maxLength;
  final InputDecoration? decorator;
  final bool autofocus;
  final BorderRadius borderRadius;
  final TextAlign textAlign;
  const CustomTextFormField(
      {Key? key,
      required this.label,
      this.controller,
      this.initialValue,
      this.padding,
      this.maxLines = 1,
      this.obscureText = false,
      this.autovalidateMode = AutovalidateMode.onUserInteraction,
      required this.validator,
      this.onFieldSubmitted,
      required this.onChanged,
      this.onTap,
      this.prefix,
      this.readOnly,
      this.textInputType,
      this.isDateField = false,
      this.isTimeField = false,
      this.focusNode,
      this.onEditingComplete,
      this.enabled = true,
      this.inputFormatters,
      this.keyboardType,
      this.maxLength,
      this.decorator,
      this.autofocus = false,
      this.textAlign = TextAlign.start,
      this.borderRadius = const BorderRadius.all(Radius.circular(10.58))})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      focusNode: focusNode,
      inputFormatters: inputFormatters,
      onFieldSubmitted: onFieldSubmitted,
      controller: controller,
      initialValue: initialValue,
      enabled: enabled,
      decoration: isDateField
          ? inputDecoration(label, borderRadius, padding).copyWith(
              suffixIcon: const Icon(
                Icons.calendar_month_outlined,
              ),
              suffixIconColor: Colors.green,
            )
          : isTimeField
              ? inputDecoration(label, borderRadius, padding).copyWith(
                  suffixIcon: const Icon(
                    Icons.watch_later_outlined,
                  ),
                  suffixIconColor: Colors.green,
                )
              : decorator ??
                  inputDecoration(label, borderRadius, padding)
                      .copyWith(prefix: prefix)
                      .copyWith(prefix: prefix),
      style: const TextStyle(
        color: Colors.black87,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      cursorColor: Colors.black,
      obscureText: obscureText,
      maxLines: maxLines,
      autovalidateMode: autovalidateMode,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap ?? () {},
      readOnly: readOnly ?? false,
      keyboardType: textInputType,
      onEditingComplete: onEditingComplete,
      maxLength: maxLength,
      textAlign: textAlign,
    );
  }

  CustomTextFormField copyWith({
    Key? key,
    String? label,
    TextEditingController? controller,
    String? initialValue,
    EdgeInsets? padding,
    int? maxLines,
    bool? obscureText,
    AutovalidateMode? autovalidateMode,
    String? Function(String? value)? validator,
    void Function(String value)? onChanged,
    void Function(String value)? onFieldSubmitted,
    void Function()? onTap,
    bool? readOnly,
    TextInputType? textInputType,
    bool isDateField = false,
    bool isTimeField = false,
    FocusNode? focusNode,
    Function()? onEditingComplete,
    bool? autofocus,
    InputDecoration? decorator,
  }) {
    return CustomTextFormField(
      label: label ?? this.label,
      controller: controller ?? this.controller,
      initialValue: initialValue,
      padding: padding ?? this.padding,
      maxLines: maxLines ?? this.maxLines,
      obscureText: obscureText ?? this.obscureText,
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
      validator: validator ?? this.validator,
      onChanged: onChanged ?? this.onChanged,
      onFieldSubmitted: onFieldSubmitted ?? this.onFieldSubmitted,
      onTap: onTap ?? this.onTap,
      readOnly: readOnly ?? this.readOnly,
      textInputType: textInputType ?? this.textInputType,
      isDateField: isDateField,
      isTimeField: isTimeField,
      focusNode: focusNode ?? this.focusNode,
      onEditingComplete: onEditingComplete ?? this.onEditingComplete,
      autofocus: autofocus ?? this.autofocus,
      decorator: decorator ?? this.decorator,
    );
  }
}
