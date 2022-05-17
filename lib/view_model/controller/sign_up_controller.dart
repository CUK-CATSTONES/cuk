import 'dart:developer';

import 'package:cuk/asset/data/schinfo.dart';
import 'package:cuk/asset/data/status.dart';
import 'package:cuk/model/repository/auth_repository.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  String id = '';
  String pw = '';
  String name = '';
  String major = SchInfo.major[0];
  String branch = SchInfo.branch[0];
  bool isIDFetched = false;
  bool isPWValidated = false;
  bool isIDValidated = false;
  bool isNameValidated = false;
  bool isReadyForSignUp = false;

  Future fetchID() async {
    await AuthRepository.withID(id: id).checkIfEmailExist().then(
      (result) {
        log(result);
        switch (result) {
          case 'success':
            isIDFetched = true;
            Get.snackbar('사용가능한 이메일', '회원가입을 계속 진행해주세요.');
            break;
          case 'already-exist':
            isIDFetched = false;
            Get.snackbar('해당 이메일 사용불가', '이메일이 이미 존재합니다.');
            break;
          default:
            isIDFetched = false;
            break;
        }
      },
    );
  }

  Validate comparePW(String rePw) {
    if (validatePW(pw) == Validate.pass) {
      if (pw != rePw) {
        return Validate.notMatchPW;
      }
      return Validate.pass;
    }
    return Validate.error;
  }

  Validate validatePW(String pw) {
    if (pw.contains(RegExp(r'[\s]'))) {
      return Validate.containSpace;
    }
    if (!pw.contains(RegExp(r'^[a-zA-Z0-9]+$'))) {
      return Validate.containSpecialChar;
    }
    if (pw.length < 6) {
      return Validate.minLength;
    }
    if (pw.length > 15) {
      return Validate.maxLength;
    }
    return Validate.pass;
  }

  Validate validateID(String id) {
    if (id.contains(RegExp(r'[@]'))) {
      return Validate.containSpecialChar;
    }
    if (id.length > 20) {
      return Validate.maxLength;
    }
    return Validate.pass;
  }

  Validate validateName(String name) {
    if (name.contains(RegExp(r'[\s]'))) {
      return Validate.containSpace;
    }

    if (RegExp(r'[\uac00-\ud7af]', unicode: true).allMatches(name).length !=
            name.length &&
        !name.contains(RegExp(r'^[a-zA-Z0-9가-힣]+$'))) {
      return Validate.uncompliteWord;
    }
    if (name == 'admin' ||
        name == 'root' ||
        name == '관리자' ||
        name == '운영자' ||
        name == 'MsSQL' ||
        name == 'MySQL') {
      return Validate.error;
    }
    if (name.length < 2) {
      return Validate.minLength;
    }
    if (name.length > 6) {
      return Validate.maxLength;
    }

    return Validate.pass;
  }
}
