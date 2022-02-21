import 'package:flutter/material.dart';

class MaskedInputController extends TextEditingController {
  MaskedInputController({
    String? text,
    required String mask,
    required Map<String, RegExp> filter,
  })   : _mask = mask,
        _filter = filter,
        super(text: text) {
    addListener(_formatText);
    _formatText();
  }

  final String _mask;
  final Map<String, RegExp> _filter;

  @override
  set text(String newText) {
    value = value.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
      composing: TextRange.empty,
    );
  }

  bool isFilled() {
    return text.length == _mask.length;
  }

  void _formatText() {
    text = _applyMask();
  }

  String _applyMask() {
    final maskedText = StringBuffer();

    int maskCharIndex = 0;
    int valueCharIndex = 0;

    while (true) {
      if (maskCharIndex == _mask.length) {
        break;
      }

      if (valueCharIndex == text.length) {
        break;
      }

      final maskChar = _mask[maskCharIndex];
      final valueChar = text[valueCharIndex];

      if (maskChar == valueChar) {
        maskedText.write(maskChar);
        valueCharIndex += 1;
        maskCharIndex += 1;
        continue;
      }

      if (_filter.containsKey(maskChar)) {
        if (_filter[maskChar]!.hasMatch(valueChar)) {
          maskedText.write(valueChar);
          maskCharIndex += 1;
        }

        valueCharIndex += 1;
        continue;
      }

      maskedText.write(maskChar);
      maskCharIndex += 1;
      continue;
    }

    return maskedText.toString();
  }
}
