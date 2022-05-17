import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TagNotiView extends StatefulWidget {
  const TagNotiView({Key? key}) : super(key: key);

  @override
  _TagNotiViewState createState() => _TagNotiViewState();
}

class _TagNotiViewState extends State<TagNotiView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('태그 알림'),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                  width: double.infinity,
                  height: 200.h,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 233, 239, 255),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        '공지사항을 더 편하게!',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Text(
                        '개발중입니다:)',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(height: 10),
                    ],
                  )),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 233, 239, 255),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: TextButton(
                  onPressed: () => Get.snackbar('5월 출시 예정', '조금만 기다려주세요:)'),
                  child: const Text('CLICK'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
