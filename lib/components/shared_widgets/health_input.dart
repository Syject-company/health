import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/extensions/widget.dart';

class HealthInput extends StatefulWidget {
  const HealthInput({
    Key? key,
    this.initialValue,
    this.controller,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.textAlign = TextAlign.start,
    this.formatters,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
    this.prefixText,
    this.labelText,
    this.maxLength,
    this.minLines = 1,
    this.maxLines = 1,
  }) : super(key: key);

  final String? initialValue;
  final TextEditingController? controller;
  final bool readOnly;
  final TextInputType keyboardType;
  final TextAlign textAlign;
  final List<TextInputFormatter>? formatters;
  final VoidCallback? onTap;
  final void Function(String)? onChanged;
  final VoidCallback? onEditingComplete;
  final String? prefixText;
  final String? labelText;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;

  @override
  State<HealthInput> createState() => _HealthInputState();
}

class _HealthInputState extends State<HealthInput> {
  final FocusNode _focusNode = FocusNode();

  late final bool _isPassword =
      widget.keyboardType == TextInputType.visiblePassword;
  late final TextEditingController _controller =
      widget.controller ?? TextEditingController();

  late Color _labelColor = _getLabelColor();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => _labelColor = _getLabelColor());
    });
    _controller.text = widget.initialValue ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      controller: _controller,
      readOnly: widget.readOnly,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      textAlign: widget.textAlign,
      keyboardType: widget.keyboardType,
      obscuringCharacter: '●',
      inputFormatters: [
        LengthLimitingTextInputFormatter(widget.maxLength),
        if (widget.formatters != null) ...widget.formatters!
      ],
      onTap: () {
        if (widget.readOnly) {
          _focusNode.unfocus();
        }
        widget.onTap?.call();
      },
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      obscureText: _isPassword,
      autocorrect: !_isPassword,
      enableSuggestions: !_isPassword,
      cursorColor: AppColors.purple,
      style: const TextStyle(
        fontSize: 14.0,
        fontFamily: 'Almarai',
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(
          top: 27.0,
          right: 20.0,
          bottom: 18.0,
          left: 20.0,
        ),
        isCollapsed: true,
        prefixText: widget.prefixText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        label: widget.labelText != null
            ? Text(
                widget.labelText!,
                style: TextStyle(
                  fontSize: 19.0,
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.w400,
                  color: _labelColor,
                ),
              ).withPaddingSymmetric(16.0, 0.0)
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: AppColors.inputDefaultBorder,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: AppColors.inputDefaultBorder,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: AppColors.inputFocusedBorder,
          ),
        ),
      ),
      enableInteractiveSelection: !widget.readOnly,
      textInputAction: TextInputAction.done,
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Color _getLabelColor() {
    if (_focusNode.hasFocus || (_controller.text.isNotEmpty)) {
      return AppColors.purple;
    }
    return AppColors.grey;
  }
}
