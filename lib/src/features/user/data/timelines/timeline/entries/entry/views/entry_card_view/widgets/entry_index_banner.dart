import 'dart:math';

import 'package:flutter/material.dart';

class EntryIndexBanner extends StatelessWidget {
  static const _width = 200.0;
  static const _height = 100.0;

  static const _borderRadius = BorderRadius.all(Radius.circular(100.0));
  static const _textStyle = TextStyle(fontSize: 16.0);

  static const initialOffset = Offset(_width * .5, -_height * .5);
  static const prefOffset = Offset(20.0, -20.0);

  final int index;
  final Widget child;

  const EntryIndexBanner({
    super.key,
    required this.index,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final text = "#${index + 1}";
    final textFactor = text.length * 3.0;
    final textOffset = Offset(-textFactor, textFactor);

    return Stack(
      children: [
        child,
        Align(
          alignment: Alignment.topRight,
          child: Transform.translate(
            offset: initialOffset + prefOffset + textOffset,
            child: Transform.rotate(
              angle: pi * .25,
              child: _buildBannerTag(context, text),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBannerTag(BuildContext context, String text) {
    return Container(
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: _borderRadius,
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Text(text, style: _textStyle),
      ),
    );
  }
}
