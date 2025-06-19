import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final Function(String value)? onChanged;
  final Function(String? value)? onSaved;
  final Function(String? value)? onSubmitted;
  final String? Function(String?)? validator;
  final TextAlign textAlign;
  final int? maxLength;
  final Color? labelColor;
  final bool readOnly;
  final void Function()? onTap;
  final String? value;
  final bool withHeader;
  final String? headerIcon;
  final String? headerLabel;
  final String? hintText;
  final TextInputType? keyboardType;
  final Color? backgroundColor;
  const CustomTextFormField({
    super.key,
    this.onChanged,
    this.onSaved,
    this.onSubmitted,
    this.validator,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.labelColor = Colors.black26,
    this.readOnly = false,
    this.onTap,
    this.value,
    this.withHeader = false,
    this.headerIcon,
    this.headerLabel,
    this.hintText,
    this.keyboardType,
    this.backgroundColor,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController(text: widget.value);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          controller.text = widget.value ?? '';
        }
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      onSaved: widget.onSaved,
      onFieldSubmitted: widget.onSubmitted,
      validator: widget.validator,
      textAlign: widget.textAlign,
      maxLength: widget.maxLength,
      readOnly: widget.readOnly,
      keyboardType: widget.keyboardType,
      maxLines: widget.keyboardType == TextInputType.multiline ? 4 : 1,
      decoration: InputDecoration(
        isCollapsed: true,
        isDense: true,
        // fillColor: Colors.white,
        // focusColor: Colors.white,
        // filled: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 13),
        errorStyle: TextStyle(fontSize: 14, color: Colors.red),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black26, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black26, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        counter: const SizedBox.shrink(),
      ),
    );
  }
}
