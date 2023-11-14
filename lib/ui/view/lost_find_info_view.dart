import 'package:cuk/ui/widget/lostfind_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LostFindInfoView extends StatelessWidget {
  LostFindInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('유실물 정보'),
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.close),
            color: Colors.black,
            padding: const EdgeInsets.all(0.0),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: LostfindWidget(
          title: '인간학1 보관중입니다.',
          losttitle: '책',
          icon: Icons.search,
          // 자동 줄바꿈 해결해야함 & 줄 바꿈시 왼쪽 제목과 줄이 달라짐
          // details: '제가 개인적으로 보관중입니다.\n010-6444-6887로 연락주세요.',
          getdate: '23.05.17',
          writedate: '2023.09.21',
          getspace: '니콜스 3층 311',
          keepspace: '개인 보관',
          link: "",
        ),
      ),
    );
  }
}
