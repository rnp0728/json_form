import 'package:flutter/material.dart';
import 'package:form_kit/src/theme/theme.dart';

class CustomDropDown extends StatefulWidget {
  final String? value;
  final List<DropdownMenuItem>? items;
  final String? label;
  final bool showLabel;
  final String? Function(dynamic)? validator;
  final void Function(dynamic)? onChanged;
  const CustomDropDown({
    super.key,
    this.value,
    this.items,
    this.showLabel = true,
    required this.label,
    this.validator,
    required this.onChanged,
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DropdownButtonFormField(
        hint: widget.label != null ? Text(widget.label.toString()) : null,
        onChanged: widget.onChanged,
        validator: widget.validator,
        borderRadius: BorderRadius.circular(6),
        value: widget.value,
        isExpanded: true,
        icon: Icon(
          Icons.arrow_drop_down_circle_outlined,
          color: JsonFormTheme.green,
        ),
        focusColor: Colors.white,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          labelText:
              (widget.value != null && widget.showLabel) ? widget.label : null,
          hintText: !widget.showLabel ? widget.label : null,
          floatingLabelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.58),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1.25,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.58),
            borderSide: const BorderSide(
              color: Colors.green,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.58),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 0.8,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.58),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 0.8,
            ),
          ),
        ),
        items: widget.items,
      ),
    );
  }
}
