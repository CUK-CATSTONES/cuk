import 'dart:developer';

import 'package:cuk/asset/data/service.dart';
import 'package:cuk/asset/data/status.dart';
import 'package:cuk/model/repository/user_repository.dart';
import 'package:cuk/model/vo/user_vo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static final UserController _userController = UserController._internal();
  factory UserController() => _userController;
  UserController._internal();
  late UserVO? user;

  Future readUserInfoInDB() async {
    UserRepository userRepository = UserRepository();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      await userRepository.readInfoInFireStore(uid).then((result) {
        switch (result) {
          case Status.error:
            Get.snackbar('알 수 없는 에러', '초기화면으로 돌아갑니다.');
            Get.offAllNamed(Service.SIGN_IN_ROUTE);
            break;
          case 'NOT-EXIST':
            Get.offAllNamed(Service.EDIT_INFO_ROUTE);
            break;
          case Status.success:
            user = userRepository.user;
            Get.offAllNamed(Service.HOME_ROUTE);
            break;
        }
      });
    } else {
      log('uid 접근 불가');
    }
  }

  Future addUserInfoInDB(Map<String, dynamic> map) async {
    UserRepository userRepository = UserRepository();
    userRepository.setUserVO(map);
    await userRepository.addInfoInFireStore().then((result) {
      switch (result) {
        case Status.success:
          log('회원 등록 성공');
          break;
        case Status.error:
          log('회원 등록 실패');
          break;
      }
    });
  }

  // map = name, .... id랑 uid 없음
  Future updateUserInfoInDB(Map<String, dynamic> map) async {
    UserRepository userRepository = UserRepository();
    final email = FirebaseAuth.instance.currentUser?.email;
    map.addAll({'id': email});
    userRepository.setUserVO(map);
    await userRepository.addInfoInFireStore().then((result) async {
      switch (result) {
        case Status.success:
          await readUserInfoInDB();
          Get.snackbar('수정 완료!', '회원정보가 변경되었습니다.');
          Get.offAllNamed(Service.HOME_ROUTE);
          break;
        case Status.error:
          log('회원 정보 수정 실패');
          break;
      }
    });
  }

  Future deleteUserInfoInDB() async {
    UserRepository userRepository = UserRepository();
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid != null) {
      await userRepository.deleteInfoInFireStore(uid).then((result) {
        switch (result) {
          case Status.error:
            log('DB 삭제 완료');
            break;
          case Status.success:
            log('삭제 에러');
            break;
        }
      });
    }
  }
}
