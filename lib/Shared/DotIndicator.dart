import 'package:flutter/material.dart';
import 'package:stem_vault/Core/appColors.dart';

class DotIndicator extends StatelessWidget {
  final bool isActive;
  const DotIndicator({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 10,
      width: isActive ? 20 : 10,
      decoration: BoxDecoration(
        color: isActive ? AppColors.bgColor : Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
