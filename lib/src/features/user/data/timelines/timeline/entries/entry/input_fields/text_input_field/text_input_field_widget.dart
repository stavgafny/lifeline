import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import '../core/input_field_widget.dart';
import './text_input_field_model.dart';

class TextInputFieldWidget extends InputFieldWidget<TextInputFieldModel> {
  static const defaultTextDirection = TextDirection.ltr;
  static const double _maxHeightFromScreen = .35;

  const TextInputFieldWidget({
    super.key,
    required super.model,
    required super.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * _maxHeightFromScreen,
      ),
      child: _TextField(key: key, model: model, onChange: onChange),
    );
  }
}

class _TextField extends StatefulWidget {
  final TextInputFieldModel model;
  final void Function(TextInputFieldModel) onChange;

  const _TextField({super.key, required this.model, required this.onChange});

  @override
  State<_TextField> createState() => _TextFieldState();
}

class _TextFieldState extends State<_TextField> {
  final _focusNode = FocusNode();
  TextDirection _textDirection = TextInputFieldWidget.defaultTextDirection;
  String _lastUpdate = "";
  String _text = "";

  @override
  void initState() {
    super.initState();
    _lastUpdate = widget.model.value;
    _text = _lastUpdate;
    _checkIfTextDirectionChanged(_text);

    _focusNode.addListener(() {
      if (_text != _lastUpdate) {
        widget.onChange(TextInputFieldModel(value: _text));
        _lastUpdate = _text;
      }
    });
  }

  void _checkIfTextDirectionChanged(String text) {
    final currentTextDirection = _getTextDirection(text);
    if (currentTextDirection != _textDirection) {
      setState(() => _textDirection = currentTextDirection);
    }
  }

  void _onTextChange(String value) {
    _text = value;
    _checkIfTextDirectionChanged(_text);
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface),
      borderRadius: BorderRadius.circular(15.0),
    );

    return RawScrollbar(
      thumbColor: Theme.of(context).colorScheme.onSurface,
      mainAxisMargin: 10.0,
      thickness: 4.0,
      child: TextFormField(
        focusNode: _focusNode,
        initialValue: widget.model.value,
        onChanged: _onTextChange,
        textDirection: _textDirection,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          enabledBorder: inputBorder,
          focusedBorder: inputBorder,
          hintText: "Type your details here...",
          labelText: "Text Field",
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}

TextDirection _getTextDirection(String text) {
  if (text.isEmpty) return TextInputFieldWidget.defaultTextDirection;
  return intl.Bidi.detectRtlDirectionality(text)
      ? TextDirection.rtl
      : TextDirection.ltr;
}
