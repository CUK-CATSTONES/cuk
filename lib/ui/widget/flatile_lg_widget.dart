// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FlatileWidget_lg extends StatelessWidget {
  final String title;
  final onTap;
  final double? elevation;
  final double? marginT;
  final double? marginB;
  final double? marginL;
  final double? marginR;
  final ShapeBorder? shape;
  final Widget? trailing;
  final Widget leading;
  final String valueL;
  final String valueM;
  final String valueR;

  const FlatileWidget_lg({
    Key? key,
    required this.leading,
    required this.title,
    required this.onTap,
    required this.valueL,
    required this.valueM,
    required this.valueR,
    this.elevation,
    this.marginT,
    this.marginB,
    this.marginL,
    this.marginR,
    this.shape,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.only(
          top: marginT ?? 0.0,
          bottom: marginB ?? 0.0,
          left: marginL ?? 0.0,
          right: marginR ?? 0.0,
        ),
        elevation: elevation,
        shape: shape,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              leading,
              SizedBox(width: 20.w),
              Flexible(
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headline4,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "작성자",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Text(
                              valueL,
                              style: Theme.of(context).textTheme.headline5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "작성일",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Text(
                              valueM,
                              style: Theme.of(context).textTheme.headline5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "공지타입",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Text(
                              valueR,
                              style: Theme.of(context).textTheme.headline5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
