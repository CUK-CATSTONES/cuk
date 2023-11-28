import 'package:cuk/ui/widget/lostfind_widgetet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LostFindInfoEtView extends StatelessWidget {
  LostFindInfoEtView({Key? key}) : super(key: key);

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
        child: LostfindEtWidget(
          title: 'CU 카드 분실물 찾아가세요.',
          icon: Icons.search,
          details:
              '제가 모르고 꽂혀있는 카드로 초콜릿 \n2100원인가 결제했어요.. \n죄송합니다.. \n주인분 찾아가시고 쪽지주시면 송금해드리겠습니다.',

          // image: Icon(Icons.abc),
          getdate: '22.07.21',
          getspace: '알수없음',
          keepspace: '학생지원팀',
          link: "",
          writedate: '2022.07.21 23:03',
          iconData: Icons.card_travel_sharp,
        ),
      ),
    );
  }
}
