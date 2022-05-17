import 'package:cuk/asset/data/auth.dart';
import 'package:cuk/asset/data/service.dart';
import 'package:cuk/asset/data/status.dart';
import 'package:cuk/model/repository/auth_repository.dart';
import 'package:cuk/view_model/controller/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

/// [AuthController]는 Sign 상태와 처리 결과를 반환하여 전역적으로 [Auth] 상태를 관리합니다.
///
/// [Auth]와 관련된 모든 것을 해당 Controller에서 관리합니다. 이러한 관리를 위해 아래의 기능을 포함하고 있습니다.
///
/// 주요기능:
/// 1. 현재 User의 status 관리 및 반환 : [status], [setStatus]
/// 2. 로그인 시도에 대한 처리 요청 후, 처리 결과 제어 : [signIn]
/// 3. 인증 메일 발송 요청 후, 처리 결과 제어 : [sendEmailVerification]
/// 4. 로그아웃 시도에 대한 처리 요청 후, 처리 결과 제어 : [signOut]
/// 5. 회원가입 시도에 대한 처리 요청 후, 처리 결과 제어 : [signUp]
/// 6. 비밀번호 초기화(찾기) 시도에 대한 처리 요청 후, 처리 결과 제어 : [resetPW]
/// 7. 익명 로그인 시도에 대한 처리 요청 후, 처리 결과 제어 : [signInAnonymously]
///
/// 각 기능별 사용 조건이 다르기 때문에 주의해야 합니다.
/// 또한, 선행되어야 하는 조건이 만족되지 않을 경우 컴파일 에러가 발생할 수도 있습니다.
/// 선행조건은 각 기능에서 확인할 수 있습니다.
///
/// [AuthController]는 [GetxController]를 상속받습니다.
/// 이에 따라 루트 파일인 `main.dart`에서 아래와 같이 선언됩니다.
///
/// ```
/// final _authController = Get.put(AuthController());
/// ```
///
/// 이후 다른 파일에서 [AuthController]를 사용해야 한다면, 아래와 같이 사용해야 합니다.
///
/// ```
/// final _authController = Get.find<AuthController>();
/// ```
///
/// See Also:
/// - [Getx] https://pub.dev/documentation/get/latest/
///
class AuthController extends GetxController {
  /// [status]는 현재 사용자의 [Auth] 상태를 의미합니다.
  ///
  /// [Auth]타입의 enum 값을 가집니다. 처음 `main.dart`에서 [status]를 초기화합니다.
  /// 반드시 initialize 되어야 컴파일 에러가 뜨지 않습니다.
  ///
  /// 현재 사용자의 [Auth] 상태를 확인하고 싶다면 [status]를 사용해야 합니다.
  /// 만약 사용자의 상태를 변경하는 로직이 작동할 경우, [status]값도 이에 맞춰 변경되어야 합니다.
  /// 이러한 값의 변경은 [setStatus]를 활용합니다.
  Auth status = Auth.signOut;

  /// [status]값을 변경합니다.
  ///
  /// 모든 경우에서 [status]값을 변경하고 싶다면 [setStatus]를 사용해야 합니다.
  /// 이는 어떠한 예외도 있을 수 없으며, [status]는 [setStatus]에 의해서만 값을 수정할 수 있습니다.
  ///
  /// Example:
  /// ```
  /// final _authController = Get.find<AuthController>();
  /// Auth status = Auth.emailVerified;
  ///
  /// await _authController.setStatus(status);
  /// ```
  Future<void> setStatus(Auth status) async {
    this.status = status;
    update();
  }

  /// [signIn]은 로그인에 사용하며, 로그인 과정을 제어합니다.
  ///
  /// [id], [pw]값과 함께 [AuthRepository]에 로그인을 요청합니다.
  /// 해당 로직에서는 별도의 validation이 없기 때문에 parameter로 받은 [id], [pw]의 validation은 선행되어야 합니다.
  ///
  /// 익명 사용자[Auth.isAnonymous]의 경우, [withdraw]를 통해 회원탈퇴를 먼저 선행하고 로그인합니다.
  /// 이는 익명 사용자 역시 현재 익명 상태로 로그인된 상태이기 때문입니다.
  /// 로그인 상태에서 로그인을 시도할 수 없으므로, 회원탈퇴를 진행하여 DB의 해당 익명 계정 정보를 삭제하고 로그아웃합니다.
  ///
  /// > 로그인 성공 시(`result == 'Status.success'`)
  /// > 사용자의 상태에 따라 아래와 같이 작동합니다.
  /// > -
  /// > - Auth.i
  /// - 로그인 실패 시(`result == 'Status.userNotFound || Status.wrongPW || Status.error'`)
  /// > [Get.back]을 통해 [Get.defaultDialog]를 닫고 [Get.snackbar]를 출력합니다.
  Future signIn(String id, String pw) async {
    // [1] Display Indicator
    Get.defaultDialog(
      barrierDismissible: false,
      title: '',
      backgroundColor: const Color.fromARGB(0, 255, 255, 255),
      content: const CircularProgressIndicator.adaptive(
        backgroundColor: Colors.white,
      ),
    );

    // [2]익명 계정 사용자 validation
    // - 익명 사용자의 경우 익명으로 로그인되어 있는 상태
    // - 로그인하기 위해 먼저 익명 계정에 대한 로그아웃을 진행
    if (status == Auth.isAnonymous) {
      await withdraw();
    }

    // [3]id, pw를 이용하여 로그인 시도
    AuthRepository.withIDandPW(id: id, pw: pw).signIn().then((result) async {
      switch (result) {
        case Status.success:
          // [3-1]로그인에 성공시 signIn 상태의 사용자의 validation
          // - 이메일 인증을 아직 받지 않음을 의미
          // - 해당 사용자에 대해 이메일 인증 Dialog 출력
          if (status == Auth.signIn) {
            Get.back(); // Indicator Off
            // Display Dialog
            Get.defaultDialog(
              barrierDismissible: false,
              // Dialog Off Button
              // - 클릭 시 Display 된 Dialog Off
              // - 현재 사용자는 sign in 상태이므로 Off 시 로그아웃 함
              cancel: TextButton(
                onPressed: () async {
                  await signOut();
                  Get.back();
                },
                child: Text('로그인 하러 가기'),
              ),
              title: '이메일 인증이 필요합니다.',
              titleStyle: TextStyle(
                fontSize: 18.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              middleText:
                  '\n인증메일이 도착하지 않았다면,\n스팸함을 확인해주세요.\n\n\n\n메일이 도착하지 않았다면,\n아래의 재발송 버튼을 클릭해주세요.',
              middleTextStyle: TextStyle(
                fontSize: 14.sp,
                color: const Color.fromARGB(255, 60, 60, 60),
              ),
              actions: [
                // 인증메일 재발송 버튼
                // - 클릭 시 인증메일을 재 발송함
                // - 이후, 로그인 화면으로 Display
                ElevatedButton(
                  onPressed: () async {
                    await sendEmailVerification();
                  },
                  child: const Text('인증메일 재발송'),
                ),
              ],
            );
            break;
          }
          // [3-2]사용자 정보 요청
          // - UserController 에게 사용자 정보 요청
          await UserController().readUserInfoInDB();
          break;
        case Status.userNotFound:
          Get.back(); // Indicator Off
          Get.snackbar('로그인 실패', '해당 아이디 정보가 없어요.');
          break;
        case Status.wrongPW:
          Get.back(); // Indicator Off
          Get.snackbar('로그인 실패', '잘못된 비밀번호가 입력되었어요.');
          break;
        default:
          Get.back(); // Indicator Off
          Get.snackbar('로그인 실패', '다시 시도해주세요.');
          break;
      }
    });
  }

  /// [signOut]은 로그아웃에 사용되며, 로그아웃 과정을 제어합니다.
  ///
  /// [AuthRepository]에 로그아웃을 요청합니다.
  ///  - 로그아웃에 성공할 경우(`result == 'success'`)
  /// > [Get.offAllNamed]을 통해 [Get.defaultDialog]를 닫고 `sign_in_view.dart`로 이동합니다.
  /// - 로그아웃에 실패할 경우
  /// > [Get.back]을 통해 [Get.defaultDialog]를 닫고 [Get.snackbar]를 출력합니다.
  /// - 로그아웃 요청시 로그아웃 상태일 경우
  /// > [Get.snackbar]를 통해 로그아웃 상태임을 알리고 [Get.offAllNamed]을 통해 `sign_in_view.dart`로 이동합니다.
  Future signOut() async {
    // Display Indicator
    Get.defaultDialog(
      barrierDismissible: false,
      title: '',
      backgroundColor: const Color.fromARGB(0, 255, 255, 255),
      content: const CircularProgressIndicator.adaptive(
        backgroundColor: Colors.white,
      ),
    );
    // [1]로그아웃 상태 확인
    // - 현재 사용자가 로그아웃 상태인지 확인함
    // - 사용자가 로그아웃 상태가 아니라면 로그아웃을 진행함
    if (status != Auth.signOut) {
      AuthRepository().signOut().then((result) {
        switch (result) {
          case Status.success:
            Get.back(); // Indicator Off
            if (Get.previousRoute == Service.SIGN_IN_ROUTE) {
              Get.back(); // Indicator Off
            } else {
              Get.offAllNamed(Service.SIGN_IN_ROUTE); // Indicator Off and Route
            }
            break;
          default:
            Get.back(); // Indicator Off
            Get.snackbar('로그아웃 실패', '로그아웃에 실패했습니다.\n문제가 있다면 개발팀에 문의해주세요.');
            break;
        }
      });
    } else {
      Get.snackbar('로그아웃 상태', '현재 로그아웃 상태입니다.');
      Get.offAllNamed(Service.SIGN_IN_ROUTE);
    }
  }

  /// [sendEmailVerification]은 인증메일 발송에 사용되며, 이메일 발송을 제어합니다.
  ///
  /// [AuthRepository]에 이메일 인증을 요청합니다.
  /// id(email)값이 필요하므로 id를 입력받은 상태에서만 사용가능합니다.
  /// 이메일 인증이 되지 않은 사용자의 경우 로그인하지 않은 상태이므로, 보통의 경우 로그인 시도 후
  /// - 인증에 성공할 경우
  /// > [Get.back]을 통해 [Get.defaultDialog]을 닫고 [Get.snackbar]을 출력합니다.
  /// - 인증에 실패할 경우
  /// > [Get.back]을 통해 [Get.defaultDialog]을 닫고 [Get.snackbar]을 출력합니다.
  /// - 이미 인증된 계정일 경우
  /// > [AuthRepository]에 인증요청을 하지 않고 [Get.snackbar]을 출력합니다.
  Future sendEmailVerification() async {
    // [1]이메일 인증 상태 확인
    // - 현재 사용자 상태가 이메일 인증이 되지 않는 경우에만 인증메일이 발송되도록 함
    if (status != Auth.emailVerified) {
      // Display Indicator
      Get.defaultDialog(
        barrierDismissible: false,
        content: const CircularProgressIndicator.adaptive(),
      );

      print(FirebaseAuth.instance.currentUser);

      // [2]인증메일 발송
      // - 인증 메일을 발송하고 결과에 따라 validation
      AuthRepository().sendEmailVerification().then((result) async {
        switch (result) {
          case 'success':
            Get.back();
            Get.snackbar(
              '인증메일 발송 성공!',
              '인증 메일이 발송되었어요.\n이메일 인증 후, 다시 로그인 해주세요.',
            );
            break;
          default:
            Get.back();
            Get.snackbar('인증메일 발송 실패', '다시 시도해주세요.');
            break;
        }
      });
    } else {
      Get.snackbar('이미 인증되었어요.', '인증에 문제가 있다면 개발팀에 문의해주세요.');
    }
  }

  /// [signUp]은 회원가입에 사용되며, 회원가입 과정을 제어합니다.
  ///
  /// [AuthRepository]에 [id], [pw]과 함께 회원가입을 요청합니다.
  /// - 회원가입 성공할 경우
  /// > ...
  /// - 이미 존재하는 계정으로 회원가입을 시도할 경우
  /// > [Get.back]을 통해 [Get.defaultDialog]을 닫고 [Get.snackbar]을 출력합니다.
  /// - 그 외 회원가입을 실패할 경우
  /// > [Get.back]을 통해 [Get.defaultDialog]을 닫고 [Get.snackbar]을 출력합니다.
  Future signUp(Map<String, dynamic> map) async {
    Get.defaultDialog(
      barrierDismissible: false,
      title: '',
      backgroundColor: const Color.fromARGB(0, 255, 255, 255),
      content: const CircularProgressIndicator.adaptive(
        backgroundColor: Colors.white,
      ),
    );
    if (status == Auth.isAnonymous) {
      await withdraw();
    }
    AuthRepository.withIDandPW(id: map['id'], pw: map['pw'])
        .signUp()
        .then((result) async {
      switch (result) {
        case 'success':
          await UserController().addUserInfoInDB({
            'id': map['id'],
            'name': map['name'],
            'major': map['major'],
            'branch': map['branch'],
          });
          Get.back();
          await sendEmailVerification();
          await signOut();
          break;
        case 'email-already-in-use':
          Get.back();
          Get.snackbar('회원가입 실패', '이미 존재하는 아이디입니다.');
          break;
        default:
          Get.back();
          Get.snackbar('회원가입 실패', '다시 시도해주세요.');
          break;
      }
    });
  }

  /// [resetPW]는 비밀번호 초기화(찾기)에 사용되며, 비밀번호 초기화 과정을 제어합니다.
  ///
  /// [AuthRepository]에 [id]와 함께 비밀번호 초기화 메일 발송을 요청합니다.
  /// - 비밀번호 초기화 성공할 경우
  /// > [Get.back]을 통해 [Get.defaultDialog]을 닫습니다.
  /// > 이후 [signOut]을 통해 로그아웃하고 [Get.snackbar]을 출력합니다.
  /// > 로그아웃하는 이유는 초기화된 비밀번호로 다시 로그인을 하게 하여 Auth를 정확하게 관리하기 위해서 입니다.
  /// - 비밀번호 초기화 실패할 경우
  /// > [Get.back]을 통해 [Get.defaultDialog]을 닫고 [Get.snackbar]을 출력합니다.
  Future resetPW(String id) async {
    Get.defaultDialog(
      barrierDismissible: false,
      title: '',
      backgroundColor: const Color.fromARGB(0, 255, 255, 255),
      content: const CircularProgressIndicator.adaptive(
        backgroundColor: Colors.white,
      ),
    );
    AuthRepository.withID(id: id).sendPasswordResetEmail().then((result) async {
      switch (result) {
        case 'success':
          Get.back();
          Get.snackbar('비밀번호 초기화 메일 전송 완료', '발송된 메일에서 비밀번호를 초기화해주세요.');
          break;
        default:
          Get.back();
          Get.snackbar('비밀번호 초기화 실패', '다시 시도해주세요.');
          break;
      }
    });
  }

  /// [signInAnonymously]는 익명 로그인에 사용되며 익명 로그인 과정을 제어합니다.
  ///
  /// [AuthRepository]에 익명 로그인을 요청합니다.
  /// - 익명 로그인에 성공할 경우
  /// > [Get.offAllNamed]을 통해 `home.dart`로 이동합니다.
  /// - 익명 로그인에 실패할 경우
  /// > [Get.back]을 통해 [Get.defaultDialog]을 닫고 [Get.snackbar]을 출력합니다.
  Future signInAnonymously() async {
    Get.defaultDialog(
      barrierDismissible: false,
      title: '',
      backgroundColor: const Color.fromARGB(0, 255, 255, 255),
      content: const CircularProgressIndicator.adaptive(
        backgroundColor: Colors.white,
      ),
    );
    AuthRepository().signInAnonymously().then((result) {
      switch (result) {
        case 'success':
          Get.offAllNamed(Service.HOME_ROUTE);
          break;
        default:
          Get.back();
          Get.snackbar('로그인 실패', '다시 시도해주세요.');
          break;
      }
    });
  }

  Future withdraw({String id = '', String pw = ''}) async {
    if (status == Auth.isAnonymous) {
      AuthRepository().withdraw().then((result) {
        switch (result) {
          case 'success':
            Get.back();
            break;
          default:
            Get.back();
            Get.snackbar('로그인을 할 수 없어요.', '개발팀에 문의해주세요.');
            break;
        }
      });
    } else {
      await UserController().deleteUserInfoInDB();

      AuthRepository.withIDandPW(id: id, pw: pw)
          .withdraw()
          .then((result) async {
        switch (result) {
          case 'success':
            Get.offAllNamed(Service.SIGN_IN_ROUTE);
            Get.snackbar('회원 탈퇴 완료', '로그인 화면으로 이동합니다.');
            break;
          case 'requires-recent-login':
            Get.back();
            Get.snackbar('회원 탈퇴 실패', '로그인 상태인지 확인해주세요.');
            break;
          default:
            Get.back();
            Get.snackbar('회원 탈퇴 실패', '다시 시도해주세요.');
        }
      });
    }
  }
}
