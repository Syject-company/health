import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pin_input_controller.dart';

class PinInput extends LinkedListEntry<PinInput> {
  PinInput(this.name);

  final String name;
  final PinInputController _controller = PinInputController();
  final FocusNode _tfFocusNode = FocusNode();

  PinInputController get controller => _controller;

  FocusNode get tfFocusNode => _tfFocusNode;

  void dispose() {
    _controller.dispose();
    _tfFocusNode.dispose();
  }
}

class PinInputFormatter with TextInputFormatter {
  const PinInputFormatter.create(this.input);

  final PinInput input;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final result = StringBuffer();

    final text = newValue.text;
    final length = newValue.text.length;

    if (length == 1) {
      result.write(text);
      input.next?.tfFocusNode.requestFocus();
    } else if (length > 1) {
      result.write(text[1]);
      input.next?.tfFocusNode.requestFocus();
    } else if (length == 0) {
      input.previous?.tfFocusNode.requestFocus();
    }

    return newValue.copyWith(
      text: result.toString(),
      selection: TextSelection.collapsed(offset: result.length),
    );
  }
}
