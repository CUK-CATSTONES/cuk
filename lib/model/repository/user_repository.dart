import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuk/asset/data/status.dart';
import 'package:cuk/model/repository/impl/shared_preferences_impl.dart';
import 'package:cuk/model/vo/user_vo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository extends SharedPreferencesImpl {
  static final UserRepository _userRepository = UserRepository._internal();
  final String root = 'user_db';
  late UserVO? user;
  factory UserRepository() => _userRepository;

  UserRepository._internal();

  void setUserVO(Map<String, dynamic> map) {
    map.addAll({'uid': FirebaseAuth.instance.currentUser!.uid});
    user = UserVO.fromMap(map);
  }

  Future addInfoInFireStore() async {
    try {
      Map<String, dynamic>? map = user?.toJson();
      map!.addAll({'createdTime': Timestamp.now()});
      CollectionReference userDB = FirebaseFirestore.instance.collection(root);
      await userDB.doc(user!.uid).set(map);
    } catch (e) {
      log(e.toString());
      return Status.error;
    }
    return Status.success;
  }

  // 유저 정보 읽어옴
  Future readInfoInFireStore(String uid) async {
    DocumentSnapshot document;
    try {
      CollectionReference userDB = FirebaseFirestore.instance.collection(root);
      document = await userDB.doc(uid).get();
    } catch (e) {
      return Status.error;
    }
    log('document:${document.data().toString()}');
    if (document.data() == null) {
      return 'NOT-EXIST';
    }
    user = UserVO.fromMap(document.data() as Map<String, dynamic>);
    return Status.success;
  }

  Future updateInfoInFireStore() async {}

  Future deleteInfoInFireStore(String uid) async {
    try {
      CollectionReference userDB = FirebaseFirestore.instance.collection(root);
      await userDB.doc(uid).delete();
    } catch (e) {
      return Status.error;
    }
    return Status.success;
  }
}
