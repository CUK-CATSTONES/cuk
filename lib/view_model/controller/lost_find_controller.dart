import 'dart:developer';

import 'package:cuk/model/repository/lost_find_repository.dart';
import 'package:cuk/model/vo/lost_find_vo.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class LostFindController extends GetxController {
  TextEditingController input = TextEditingController();

  bool state = false;
  bool expanded = true;
  late List flags = <LostFindVO>[].obs;

  late Map maps = {
    'page': 0,
    'lostfind': <LostFindVO>[].obs,
  };

  void reset() {
    state = false;
    maps['page'] = 0;
    maps['lostfind'].clear();
    flags.clear();
  }

  Future<void> search(int index) async {
    String? text = input.text;
    log(text.toString());
    LostFindRepository _lostFindRepository = LostFindRepository();
    maps['page']++;
    _lostFindRepository.read(index, text, maps['page']).then((result) {
      switch (result) {
        case 'success':
          if (maps['page'] == 1) {
            flags.addAll(_lostFindRepository.flag);
            if (flags.isNotEmpty) {
              expanded = true;
            } else {
              expanded = false;
            }
          }
          maps['lostfind'].addAll(_lostFindRepository.list);
          state = true;
          break;
        default:
          break;
      }
    });
    update();
  }
}
