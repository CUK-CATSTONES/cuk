import 'dart:developer';

import 'package:cuk/model/repository/notice_pin_repository.dart';
import 'package:cuk/model/vo/notice_vo.dart';
import 'package:get/get.dart';

class NoticePinController extends GetxController {
  late List list = <NoticeVO>[].obs;

  // 1. 등록된 pin 정보를 받아온다
  Future readAll() async {
    NoticePinRepository noticePinRepository = NoticePinRepository();
    await noticePinRepository.readAll().then((result) {
      list.clear();
      switch (result) {
        case 'success':
          list.addAll(noticePinRepository.pin);
          break;
        default:
          log("실패");
      }
    });
  }

  // 2. 등록할 공지사항 정보를 받아서(1) 내부저장소에 등록 요청
  Future insertOne(NoticeVO notice) async {
    NoticePinRepository noticePinRepository = NoticePinRepository();
    await noticePinRepository.insertOne(notice).then((result) async {
      switch (result) {
        case 'success':
          await readAll();
          Get.snackbar('공지사항 PIN 등록', '등록되었습니다.');
          break;
        default:
      }
    });
  }

  Future deleteArgs(List list) async {
    NoticePinRepository noticePinRepository = NoticePinRepository();
    await noticePinRepository.deleteArgs(list).then((result) async {
      switch (result) {
        case 'success':
          await readAll();
          Get.snackbar('PIN 삭제', '삭제되었습니다.');
          break;
        default:
      }
    });
  }
}
