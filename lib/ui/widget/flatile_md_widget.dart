// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FlatileWidget_md extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final onTap;
  final double? elevation;
  final double? marginT;
  final double? marginB;
  final ShapeBorder? shape;
  final Widget? trailing;

  const FlatileWidget_md({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.onTap,
    this.elevation,
    this.marginT,
    this.marginB,
    this.shape,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: shape,
        elevation: elevation,
        margin: EdgeInsets.only(top: marginT ?? 5.h, bottom: marginB ?? 5.h),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Icon(
              icon,
              size: 35.sp,
              color: iconColor,
            ),
            title: Text(
              title,
              style: Theme.of(context).textTheme.headline4,
            ),
            subtitle: Text(
              subtitle,
              style: Theme.of(context).textTheme.headline6,
            ),
            trailing: trailing,
          ),
        ),
      ),
    );
  }
}
