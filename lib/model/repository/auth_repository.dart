import 'package:cuk/asset/data/status.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// [AuthRepository]는 [FirebaseAuth]와 관련된 요청을 처리합니다.
///
/// 해당 클래스를 사용하는 경우는 아래와 같습니다.
///   - [signIn]
///     > 로그인 요청
///   - [signOut]
///     > 로그아웃 요청
///   - [sendEmailVerification]
///     > 인증메일 발송 요청
///   - [sendPasswordResetEmail]
///     > 패스워드 초기화 메일 발송 요청
///   - [signInAnonymously]
///     > 익명 로그인 요청
class AuthRepository {
  late String id;
  late String pw;

  AuthRepository();

  AuthRepository.withID({required this.id});

  AuthRepository.withIDandPW({required this.id, required this.pw});

  /// [signIn]은 [FirebaseAuth.instance]의 [signInWithEmailAndPassword]를 통해 Firebase에 로그인 요청을 합니다.
  ///
  /// [id], [pw]값을 기반으로 로그인을 요청하기 때문에 *반드시 [AuthRepository.withIDandPW]생성자와 함께 사용*해야 합니다.
  /// - 성공할 경우
  ///   > `'success'`를 반환합니다.
  /// - 실패할 경우
  ///   > [FirebaseAuthException.code]를 반환합니다.
  Future<Status> signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: id,
        password: pw,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return Status.userNotFound;
        case 'wrong-password':
          return Status.wrongPW;
        default:
          return Status.error;
      }
    }

    return Status.success;
  }
  /*
      case 'user-not-found':
          Get.back();
          Get.snackbar('로그인 실패', '해당 아이디 정보가 없어요.');
          break;
        case 'wrong-password':
          Get.back();
          Get.snackbar('로그인 실패', '잘못된 비밀번호가 입력되었어요.');
          break;
        default:
          Get.back();
          Get.snackbar('로그인 실패', '다시 시도해주세요.');
          break;
  */

  /// [sendEmailVerification]는 [FirebaseAuth.instance]의 [currentUser.sendEmailVerification]을 통해 Firebase에 인증 메일 발송을 요청합니다.
  ///
  /// 이메일 인증 시 사용자의 id(email)을 활용하기 때문에 *사용자가 로그인한 상태에서만 사용*해야 합니다.
  /// ```
  /// if (user != null && !user.emailVerified) {
  ///   <인증 메일 요청 로직>
  /// }
  /// ```
  /// 위 로직을 통해 사용자가 로그인한 상태인지 확인합니다.
  /// - 성공할 경우
  ///   > `'success'`를 반환합니다.
  /// - 실패할 경우
  ///   > [FirebaseAuthException.code]를 반환합니다.
  /// - 이미 인증된 계정일 경우
  ///   > `'already-valificated'`을 반환합니다.
  Future<Status> sendEmailVerification() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      try {
        user.sendEmailVerification();
      } catch (e) {
        return Status.error;
      }
      return Status.success;
    }
    return Status.alreadyValificated;
  }

  /// [signOut]는 [FirebaseAuth.instance]의 [signOut]을 통해 Firebase에 로그아웃을 요청합니다.
  ///
  /// - 성공할 경우
  ///   > `'success'`를 반환합니다.
  /// - 실패할 경우
  ///   > [error.code]를 반환합니다.
  Future<Status> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      return Status.error;
    }
    return Status.success;
  }

  /// [signUp]는 [FirebaseAuth.instance]의 [createUserWithEmailAndPassword]을 통해 Firebase에 회원가입을 요청합니다.
  ///
  /// 회원가입 시 사용자의 id(email)와 pw가 필요하기 때문에 *반드시 [AuthRepository.withIDandPW]생성자와 함께 사용*해야 합니다.
  /// - 성공할 경우
  ///   > `'success'`를 반환합니다.
  /// - 실패할 경우
  ///   > [FirebaseAuthException.code]를 반환합니다.
  Future<String> signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: id,
        password: pw,
      );
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
    return 'success';
  }

  /// [sendPasswordResetEmail]는 [FirebaseAuth.instance]의 [sendPasswordResetEmail]을 통해 Firebase에 비밀번호 초기화 메일 발송을 요청합니다.
  ///
  /// 인증 메일 발송 시 사용자의 id(email)이 필요하기 때문에 *반드시 [AuthRepository.withID]생성자와 함께 사용*해야 합니다.
  /// - 성공할 경우
  ///   > `'success'`를 반환합니다.
  /// - 실패할 경우
  ///   > [FirebaseAuthException.code]를 반환합니다.
  Future<String> sendPasswordResetEmail() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: id);
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
    return 'success';
  }

  /// [signInAnonymously]는 [FirebaseAuth.instance]의 [signInAnonymously]을 통해 Firebase에 익명 로그인을 요청합니다.
  ///
  /// - 성공할 경우
  ///   > `'success'`를 반환합니다.
  /// - 실패할 경우
  ///   > [FirebaseAuthException.code]를 반환합니다.
  Future<String> signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
    return 'success';
  }

  Future<String> withdraw() async {
    try {
      if (!FirebaseAuth.instance.currentUser!.isAnonymous) {
        String email = id;
        String password = pw;

        AuthCredential credential =
            EmailAuthProvider.credential(email: email, password: password);

        await FirebaseAuth.instance.currentUser
            ?.reauthenticateWithCredential(credential);
      }

      await FirebaseAuth.instance.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        return 'requires-recent-login';
      }
      return e.code;
    }
    return 'success';
  }

  Future<String> checkIfEmailExist() async {
    List list = [];
    try {
      list = await FirebaseAuth.instance.fetchSignInMethodsForEmail(id);
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
    if (list.isEmpty) {
      return 'success';
    }
    return 'already-exist';
  }
}
