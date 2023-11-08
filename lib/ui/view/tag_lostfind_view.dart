import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TagLostFindView extends StatefulWidget {
  const TagLostFindView({Key? key}) : super(key: key);

  @override
  _TagLostFindViewState createState() => _TagLostFindViewState();
}

class _TagLostFindViewState extends State<TagLostFindView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('태그 관리'),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(0, 300, 0, 0),
            child: Text(
              '등록된 태그가 없어요\n최대 3개까지 등록이 가능해요',
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(padding: EdgeInsets.fromLTRB(0, 300, 0, 0)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(300, 40),
              textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            onPressed: () {
              print('태그 등록');
            },
            child: const Text('태그 등록'),
          ),
        ],
      ),
    );
  }
}
