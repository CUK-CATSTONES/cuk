import 'package:cuk/model/repository/slot_repository.dart';
import 'package:cuk/model/vo/schlink_vo.dart';
import 'package:get/get.dart';

class SlotController extends GetxController {
  // 2. blockList(List<BlockVO>)을 반환
  RxList slot = [].obs;

  // editedSlotView에서 사용하는 block list
  // List<SchLinkVO> editedSlot = [];

  // 1. sqflite에 현재 저장된 block들(List<BlockVO>)을 요청(repository)
  Future<void> readSlot() async {
    SlotRepository _slotRepository = SlotRepository();
    slot.clear();
    _slotRepository.readAll().then((result) async {
      switch (result) {
        case 'success':
          slot.addAll(_slotRepository.slot);
          update();
          break;
        default:
          Get.snackbar('알수없는 오류', '앱을 다시 실행해주세요.');
      }
    });
  }

  Future<void> insertSlot(SchLinkVO link) async {
    SlotRepository _slotRepository = SlotRepository();
    slot.add(link);
    _slotRepository.insertAll(slot).then((result) async {
      switch (result) {
        case 'success':
          Get.snackbar('등록 완료!', '바로가기에 등록되었어요.');
          break;
        default:
          Get.snackbar('등록 실패', '다시 시도해주세요.');
          break;
      }
    });
  }

  Future<void> setSlot(List slot) async {
    SlotRepository _slotRepository = SlotRepository();

    _slotRepository.insertAll(slot).then((result) async {
      switch (result) {
        case 'success':
          Get.snackbar('변경 완료!', '바로가기가 변경되었어요.');
          break;
        default:
          Get.snackbar('변경 실패', '다시 시도해주세요.');
          break;
      }
    });
  }
}
