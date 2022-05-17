import 'dart:developer';

import 'package:cuk/model/repository/notice_repository.dart';
import 'package:cuk/model/vo/notice_vo.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class NoticeController extends GetxController {
  TextEditingController input = TextEditingController();

  bool state = false;
  bool expanded = true;
  late List flags = <NoticeVO>[].obs;

  late Map maps = {
    'page': 0,
    'notice': <NoticeVO>[].obs,
  };

  void reset() {
    state = false;
    maps['page'] = 0;
    maps['notice'].clear();
    flags.clear();
  }

  Future<void> search(int index) async {
    String? text = input.text;
    log(text.toString());
    NoticeRepository _noticeRepository = NoticeRepository();
    maps['page']++;
    _noticeRepository.read(index, text, maps['page']).then((result) {
      switch (result) {
        case 'success':
          if (maps['page'] == 1) {
            flags.addAll(_noticeRepository.flag);
            if (flags.isNotEmpty) {
              expanded = true;
            } else {
              expanded = false;
            }
          }
          maps['notice'].addAll(_noticeRepository.list);
          state = true;
          break;
        default:
          break;
      }
    });
    update();
  }
}
