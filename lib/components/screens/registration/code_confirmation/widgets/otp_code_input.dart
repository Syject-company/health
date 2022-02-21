import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/components/shared_widgets/separated_row.dart';
import 'package:health_plus/utils/pin_input_formatter.dart';

class OtpCodeInput extends StatefulWidget {
  const OtpCodeInput({
    Key? key,
    required this.inputPrefix,
    required this.length,
    this.autoSubmit = true,
    this.onSubmit,
    this.onEditingComplete,
  }) : super(key: key);

  final String inputPrefix;
  final int length;
  final bool autoSubmit;
  final void Function(String)? onSubmit;
  final void Function(String)? onEditingComplete;

  @override
  OtpCodeInputState createState() => OtpCodeInputState();
}

class OtpCodeInputState extends State<OtpCodeInput> {
  final GlobalKey<FormBuilderState> _formBuilderKey = GlobalKey();
  final LinkedList<PinInput> _inputs = LinkedList();

  bool _enabled = true;

  set enabled(bool value) {
    setState(() => _enabled = value);
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.length; i++) {
      _inputs.add(PinInput('${widget.inputPrefix}${i + 1}'));
    }
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return FormBuilder(
          key: _formBuilderKey,
          enabled: _enabled,
          onChanged: () {
            if (_enabled && widget.autoSubmit) {
              final code = _getCode();
              if (code.length == widget.length) {
                widget.onSubmit?.call(code);
              }
            }
          },
          child: SeparatedRow(
            mainAxisAlignment: MainAxisAlignment.center,
            separator: const SizedBox(width: 10.0),
            children: _inputs.map(_buildOtpCodeInput).toList(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    for (final input in _inputs) {
      input.dispose();
    }
    super.dispose();
  }

  Widget _buildOtpCodeInput(PinInput input) {
    return Flexible(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 64.0,
          maxHeight: 64.0,
          minWidth: 48.0,
          minHeight: 48.0,
        ),
        child: AspectRatio(
          aspectRatio: 1.0,
          child: FormBuilderTextField(
            expands: true,
            minLines: null,
            maxLines: null,
            name: input.name,
            focusNode: input.tfFocusNode,
            controller: input.controller,
            onEditingComplete: () {
              FocusManager.instance.primaryFocus?.unfocus();
              widget.onEditingComplete?.call(_getCode());
            },
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              PinInputFormatter.create(input),
            ],
            textAlign: TextAlign.center,
            cursorColor: AppColors.purple,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            cursorWidth: 2.0,
            style: const TextStyle(
              fontSize: 27.0,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
            ),
            decoration: InputDecoration(
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
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ),
    );
  }

  String _getCode() {
    final code = StringBuffer();
    for (final input in _inputs) {
      code.write(input.controller.text);
    }
    return code.toString();
  }
}
