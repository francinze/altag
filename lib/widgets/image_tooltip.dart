import 'package:flutter/material.dart';

class ImageTooltip extends StatelessWidget {
  const ImageTooltip(this.label, this.top, this.left, {super.key});

  final String label;
  final double top;
  final double left;
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: top,
        left: left,
        child: Material(
          color: Colors.red,
          shape: const CircleBorder(
            side: BorderSide(color: Colors.black, width: 2),
          ),
          child: SizedBox(
            width: 30,
            height: 30,
            child: Tooltip(message: label),
          ),
        ));
  }
}
