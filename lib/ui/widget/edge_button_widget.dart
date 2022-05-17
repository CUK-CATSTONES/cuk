// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EdgeButtonWidget extends StatelessWidget {
  final onTap;
  final IconData icon;
  final Color? iconColor;
  const EdgeButtonWidget({
    Key? key,
    required this.onTap,
    required this.icon,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.sp),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(18.sp),
        boxShadow: const [
          BoxShadow(
            offset: Offset(10, 10),
            color: Colors.black12,
            blurRadius: 20,
            spreadRadius: 1,
          ),
          BoxShadow(
            offset: Offset(-16, -16),
            color: Colors.white10,
            blurRadius: 16,
            spreadRadius: 2,
          ),
        ],
      ),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon),
        color: iconColor,
        padding: const EdgeInsets.all(0.0),
      ),
    );
  }
}
