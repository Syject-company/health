import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_plus/app_colors.dart';

class HealthSearchInput extends StatefulWidget {
  const HealthSearchInput({
    Key? key,
    this.controller,
    this.readOnly = false,
    this.textAlign = TextAlign.start,
    this.hintText,
    this.formatters,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
    this.maxLength,
  }) : super(key: key);

  final TextEditingController? controller;
  final bool readOnly;
  final TextAlign textAlign;
  final String? hintText;
  final List<TextInputFormatter>? formatters;
  final VoidCallback? onTap;
  final void Function(String)? onChanged;
  final VoidCallback? onEditingComplete;
  final int? maxLength;

  @override
  State<HealthSearchInput> createState() => _HealthSearchInputState();
}

class _HealthSearchInputState extends State<HealthSearchInput> {
  final FocusNode _focusNode = FocusNode();

  late final TextEditingController _controller =
      widget.controller ?? TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.0,
      child: TextField(
        focusNode: _focusNode,
        controller: _controller,
        readOnly: widget.readOnly,
        minLines: 1,
        maxLines: 1,
        textAlign: widget.textAlign,
        keyboardType: TextInputType.text,
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
        obscureText: false,
        autocorrect: true,
        enableSuggestions: true,
        cursorColor: AppColors.purple,
        style: const TextStyle(
          fontSize: 14.0,
          fontFamily: 'Almarai',
          fontWeight: FontWeight.w400,
          color: AppColors.black,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.purpleDarkGrey.withOpacity(0.06),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontSize: 14.0,
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w400,
            color: AppColors.purpleDarkGrey,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 0.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
        ),
        enableInteractiveSelection: !widget.readOnly,
        textInputAction: TextInputAction.done,
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
