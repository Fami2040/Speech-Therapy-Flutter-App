import 'package:flutter/material.dart';

class IconWithText extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double size;

  IconWithText({
    required this.icon,
    required this.text,
    required this.onPressed,
    this.color = Colors.white,
    this.size = 35.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon, color: color, size: size),
          onPressed: onPressed,
        ),
        Text(
          text,
          style: TextStyle(color: color, fontSize: 14),
        ),
      ],
    );
  }
}
