import 'package:cuk/asset/data/service.dart';
import 'package:cuk/ui/component/board_component.dart';
import 'package:cuk/view_model/controller/auth_controller.dart';
import 'package:cuk/view_model/controller/web_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingView extends StatelessWidget {
  final _authController = Get.find<AuthController>();

  SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.close),
            color: Colors.black,
            padding: const EdgeInsets.all(0.0),
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(height: 10.h),
          BoardComponent(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            title: '사용자 계정',
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Color.fromARGB(255, 161, 71, 71),
                  ),
                  title: Text(
                    '로그아웃',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  onTap: () async {
                    await _authController.signOut();
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.change_circle,
                    color: Color.fromARGB(255, 71, 128, 161),
                  ),
                  title: Text(
                    '비밀번호 변경',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  onTap: () => Get.toNamed(Service.PW_RESET_ROUTE),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.person,
                    color: Color.fromARGB(255, 71, 161, 101),
                  ),
                  title: Text(
                    '사용자 정보 변경',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  onTap: () => Get.toNamed(Service.EDIT_INFO_ROUTE),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.remove_circle,
                    color: Color.fromARGB(255, 126, 130, 133),
                  ),
                  title: Text(
                    '회원 탈퇴',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  onTap: () => Get.toNamed(Service.WITHDRAW_ROUTE),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          BoardComponent(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            title: '제공 서비스',
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.report,
                    color: Color.fromARGB(255, 183, 183, 70),
                  ),
                  title: Text(
                    '버그 제보',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  onTap: () {
                    WebController.toLaunch(
                      'https://docs.google.com/forms/d/e/1FAIpQLSd7OYllqmpAvOzLjgOp8io2Fer6VkWVY-CevdBBzKbDYPPtMw/viewform?usp=sf_link',
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.question_answer,
                    color: Color.fromARGB(255, 161, 71, 135),
                  ),
                  title: Text(
                    '개발자 문의',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  onTap: () {
                    WebController.toLaunch(
                      'https://docs.google.com/forms/d/e/1FAIpQLSehcHHkDbB0ra7tkF7_xVqfxqMbDjiMQqXLfti0-frkl2rZwA/viewform?usp=sf_link',
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.light,
                    color: Color.fromARGB(255, 71, 128, 161),
                  ),
                  title: Text(
                    '앱 관련 의견 제시',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  onTap: () {
                    WebController.toLaunch(
                      'https://docs.google.com/forms/d/e/1FAIpQLSefde1C3_n6rT1K8Xu3CdDTDr1qth7usIS6zoHIcUTOz5wQBg/viewform?usp=sf_link',
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
