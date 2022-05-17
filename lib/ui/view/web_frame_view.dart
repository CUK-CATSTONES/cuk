import 'dart:developer';
import 'dart:io';

import 'package:cuk/asset/data/auth.dart';
import 'package:cuk/view_model/controller/auth_controller.dart';
import 'package:cuk/view_model/controller/notice_pin_controller.dart';
import 'package:cuk/view_model/controller/web_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebFrameView extends StatefulWidget {
  const WebFrameView({Key? key}) : super(key: key);

  @override
  State<WebFrameView> createState() => _WebFrameViewState();
}

class _WebFrameViewState extends State<WebFrameView> {
  final _noticePinController = Get.find<NoticePinController>();
  final _authController = Get.find<AuthController>();

  late String? url;

  @override
  void initState() {
    super.initState();
    log(Get.arguments.toString());
    url = Get.arguments;

    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      left: false,
      right: false,
      child: Scaffold(
        bottomNavigationBar: Container(
          height: 100.h,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
                spreadRadius: 1,
              ),
            ],
          ),
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: [
              const SizedBox(width: 20),
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(CupertinoIcons.back),
              ),
              const SizedBox(width: 20),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 28.h),
                child: Stack(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        await _noticePinController
                            .insertOne(WebController.noticeVO);
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          width: 1.5,
                          color: Color.fromARGB(255, 47, 84, 170),
                        ),
                        fixedSize: const Size.fromWidth(
                          double.infinity,
                        ),
                      ),
                      icon: const Icon(Icons.add),
                      label: const Text('공지사항 PIN 등록'),
                    ),
                    Visibility(
                      visible: _authController.status == Auth.isAnonymous,
                      child: Container(
                        width: 165.w,
                        height: 55.h,
                        color: const Color.fromARGB(160, 0, 0, 0),
                        child: Center(
                          child: Text(
                            '로그인 후 이용할 수 있습니다.',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 28.h),
                child: OutlinedButton.icon(
                  onPressed: () {
                    WebController.toLaunch(url!);
                    Get.back();
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      width: 1.5,
                      color: Color.fromARGB(255, 47, 84, 170),
                    ),
                    fixedSize: const Size.fromWidth(
                      double.infinity,
                    ),
                  ),
                  icon: const Icon(Icons.link),
                  label: const Text('인터넷 앱으로 보기'),
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
        body: WebView(
          initialUrl: url,
          backgroundColor: Colors.white,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
