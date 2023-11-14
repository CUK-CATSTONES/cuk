import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LostfindWidget extends StatelessWidget {
  final String title; // 글 제목
  final IconData icon; // cukcat...
  final String losttitle; // 유실물
  final String? details; // 세부 내용
  final String getdate; // 습득일자
  final String writedate; // 작성일자
  final String getspace; // 습득장소
  final String keepspace; // 보관장소
  final double? marginT;
  final double? marginB;
  final String? link;

  const LostfindWidget({
    Key? key,
    required this.title,
    required this.losttitle,
    required this.icon,
    this.details,
    required this.getdate,
    required this.writedate,
    required this.getspace,
    required this.keepspace,
    this.link,
    this.marginT,
    this.marginB,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(top: marginT ?? 5.h, bottom: marginB ?? 5.h),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  icon,
                  size: 35.sp,
                ),
                title: Text(
                  title,
                  style: Theme.of(context).textTheme.headline4,
                ),
                subtitle: Text(
                  writedate,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          '유실물   ',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(width: 40.h),
                        Text(
                          losttitle,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Visibility(
                      visible: details == null ? false : true,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          const Text(
                            '세부내용',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(width: 40.h),
                          Text(
                            details ?? '',
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              const Divider(
                color: Colors.grey,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '습득일자',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          getdate,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const VerticalDivider(
                      color: Colors.grey,
                      width: 50,
                    ),
                    Column(
                      children: [
                        const Text(
                          '습득장소',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          getspace,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const VerticalDivider(
                      color: Colors.grey,
                      width: 50,
                    ),
                    Column(
                      children: [
                        const Text(
                          '보관장소',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          keepspace,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(padding: const EdgeInsets.symmetric(vertical: 20)),
              Visibility(
                visible: link == null ? false : true,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(300.h, 40.h),
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: () {
                      print('가톨릭대학교 웹사이트에서 보기');
                    },
                    child: const Text('가톨릭대학교 웹사이트에서 보기'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
