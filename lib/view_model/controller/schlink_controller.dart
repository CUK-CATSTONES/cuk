import 'package:cuk/asset/data/schlink.dart';
import 'package:cuk/model/vo/schlink_vo.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SchLinkController extends GetxController {
  final input = TextEditingController();
  List<Map<String, dynamic>> all = SchLink.list;
  List<Map<String, dynamic>> searched = SchLink.list;

  Future<void> search() async {
    String _input = input.text;
    searched = [];
    if (_input.isNotEmpty) {
      for (Map<String, dynamic> link in all) {
        if (link['title'].toString().contains(_input) ||
            link['description'].toString().contains(_input)) {
          searched.add(link);
        }
      }
    } else {
      searched = all;
    }
    update();
  }

  SchLinkVO toObject(Map<String, dynamic> link) {
    return SchLinkVO(
      title: link['title'],
      description: link['description'],
      icon: link['icon'],
      color: link['color'],
      url: link['url'],
    );
  }
}
