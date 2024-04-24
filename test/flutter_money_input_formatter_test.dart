import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/flutter_multi_formatter.dart';

void main() {
  test('should correctly remove a comma from thousands', () {
    final currentNumber = "1,000.0";
    final inputNumber = "1,00.0";
    final formattedNumber = CurrencyInputFormatter()
        .formatEditUpdate(
        TextEditingValue(
            text: currentNumber, selection: TextSelection.collapsed(offset: 5), composing: TextRange.empty),
        TextEditingValue(
            text: inputNumber, selection: TextSelection.collapsed(offset: 4), composing: TextRange.empty))
        .text;
    expect(formattedNumber, "100.00");
  });

  test('should correctly remove a leading 0', () {
    final currentNumber = "01,00.0";
    final inputNumber = "01,000.0";
    final formattedNumber = MoneyInputFormatter()
        .formatEditUpdate(
        TextEditingValue(
            text: currentNumber, selection: TextSelection.collapsed(offset: 5), composing: TextRange.empty),
        TextEditingValue(
            text: inputNumber, selection: TextSelection.collapsed(offset: 6), composing: TextRange.empty))
        .text;
    expect(formattedNumber, "1,000.00");
  });

  test('should correctly not remove a leading 0', () {
    final currentNumber = "0.0";
    final inputNumber = ".0";
    final formattedNumber = MoneyInputFormatter()
        .formatEditUpdate(
        TextEditingValue(
            text: currentNumber, selection: TextSelection.collapsed(offset: 1), composing: TextRange.empty),
        TextEditingValue(
            text: inputNumber, selection: TextSelection.collapsed(offset: 0), composing: TextRange.empty))
        .text;
    expect(formattedNumber, "0.00");
  });

  test('should correctly place marker', () {
    final currentNumber = "0";
    final inputNumber = "";
    final inputFormattedNumber = MoneyInputFormatter().formatEditUpdate(
        TextEditingValue(
            text: currentNumber, selection: TextSelection.collapsed(offset: 1), composing: TextRange.empty),
        TextEditingValue(text: inputNumber, selection: TextSelection.collapsed(offset: 0), composing: TextRange.empty));
    expect(inputFormattedNumber.text, "0.00");
    expect(inputFormattedNumber.selection, TextSelection.collapsed(offset: 1));
  });

  test('should correctly place marker2', () {
    final currentNumber = "0.";
    final inputNumber = "";
    final inputFormattedNumber = MoneyInputFormatter().formatEditUpdate(
        TextEditingValue(
            text: currentNumber, selection: TextSelection.collapsed(offset: 1), composing: TextRange.empty),
        TextEditingValue(text: inputNumber, selection: TextSelection.collapsed(offset: 0), composing: TextRange.empty));
    expect(inputFormattedNumber.text, "0.00");
    expect(inputFormattedNumber.selection, TextSelection.collapsed(offset: 1));
  });
}
