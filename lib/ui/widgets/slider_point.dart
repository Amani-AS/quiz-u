import 'package:flutter/material.dart';

class SliderPoint extends StatelessWidget {
  final bool isActive;

  const SliderPoint({Key? key, required this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(microseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 3),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: isActive ? Colors.orange : Colors.grey.withOpacity(0.6),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
