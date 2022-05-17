// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconTileWidget extends StatelessWidget {
  final String? title;
  final Color? color;
  final IconData icon;
  final Color iconColor;
  final onTap;

  const IconTileWidget({
    Key? key,
    this.title,
    this.color,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Align(
        child: SizedBox(
          height: 100.h,
          width: 80.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: color ?? Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20.sp)),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 30.sp,
                ),
              ),
              Text(
                title ?? '',
                style: Theme.of(context).textTheme.headline5,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
