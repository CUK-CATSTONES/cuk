import 'package:cuk/asset/data/schinfo.dart';
import 'package:cuk/asset/data/status.dart';
import 'package:cuk/ui/component/board_component.dart';
import 'package:cuk/view_model/controller/sign_up_controller.dart';
import 'package:cuk/view_model/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditInfoView extends StatefulWidget {
  const EditInfoView({Key? key}) : super(key: key);

  @override
  State<EditInfoView> createState() => _EditInfoViewState();
}

class _EditInfoViewState extends State<EditInfoView> {
  TextEditingController name = TextEditingController();

  final _signUpController = Get.put(SignUpController());
  final _userController = Get.put(UserController());
  String defaultMajor = SchInfo.major[0];
  String defaultBranch = SchInfo.branch[0];

  @override
  Widget build(BuildContext context) {
    bool _all = true;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('사용자 정보 입력'),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          BoardComponent(
            title: '닉네임 입력',
            subTitle:
                'CUKCAT에서 사용할 이름을 입력해주세요.\n닉네임은 2 ~ 6 글자이여야 하며, 한글, 영어, 숫자만 사용가능합니다.',
            child: Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 20),
              child: TextFormField(
                controller: name,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.done,
                validator: (val) {
                  _signUpController.name = '';
                  _signUpController.isNameValidated = false;
                  if (val == null || val.isEmpty) {
                    return '닉네임을 입력하세요.';
                  } else {
                    switch (_signUpController.validateName(val)) {
                      case Validate.containSpace:
                        return '띄어쓰기는 포함할 수 없습니다.';
                      case Validate.minLength:
                        return '2글자 이상이여야 합니다.';
                      case Validate.maxLength:
                        return '6글자 이하이여야 합니다.';
                      case Validate.uncompliteWord:
                        return '형식에 맞지 않는 닉네임입니다.';
                      case Validate.pass:
                        _signUpController.name = val;
                        _signUpController.isNameValidated = true;
                        return null;
                      default:
                        return '알 수 없는 에러, 관리자에게 문의하세요.';
                    }
                  }
                },
                decoration: const InputDecoration(
                  filled: false,
                  labelText: '닉네임 입력',
                  hintText: 'ex) 푸드파이터',
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
          ),
          BoardComponent(
            title: '교정 입력',
            subTitle: '(Optional)재학중인 교정을 선택하세요.\n선택하지 않을 시, 미기입으로 선택됩니다.',
            child: Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 20),
              child: DropdownButton<String>(
                value: defaultBranch,
                icon: const Icon(Icons.arrow_drop_down),
                isExpanded: true,
                elevation: 16,
                style: Theme.of(context).textTheme.headline5,
                underline: Container(
                  height: 1,
                  color: Colors.black26,
                ),
                onChanged: (String? newValue) {
                  _signUpController.branch = newValue!;
                  setState(() {
                    defaultBranch = newValue.toString();
                  });
                },
                items: SchInfo.branch
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          BoardComponent(
            title: '학과 선택',
            subTitle: '(Optional)본인의 학과를 선택하세요.\n선택하지 않을 시, 미기입으로 선택됩니다.',
            child: Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 20),
              child: DropdownButton<String>(
                value: defaultMajor,
                icon: const Icon(Icons.arrow_drop_down),
                isExpanded: true,
                elevation: 16,
                style: Theme.of(context).textTheme.headline5,
                underline: Container(
                  height: 1,
                  color: Colors.black26,
                ),
                onChanged: (String? newValue) {
                  _signUpController.major = newValue!;
                  setState(() {
                    defaultMajor = newValue.toString();
                  });
                },
                items:
                    SchInfo.major.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          Visibility(
            visible: _all,
            child: Padding(
              padding: const EdgeInsets.only(right: 40.0, left: 40.0),
              child: ElevatedButton(
                child: const Text('확인'),
                onPressed: () async {
                  if (_signUpController.isNameValidated) {
                    Map<String, dynamic> map = {
                      'name': _signUpController.name,
                      'branch': _signUpController.branch,
                      'major': _signUpController.major,
                    };
                    await _userController.updateUserInfoInDB(map);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
