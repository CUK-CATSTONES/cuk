import 'package:cuk/asset/data/auth.dart';
import 'package:cuk/asset/data/lostfind.dart';
import 'package:cuk/asset/data/service.dart';
import 'package:cuk/ui/component/board_component.dart';
import 'package:cuk/view_model/controller/auth_controller.dart';
import 'package:cuk/view_model/controller/lost_find_controller.dart';
import 'package:cuk/view_model/controller/web_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// 주석
class LostFindLView extends StatefulWidget {
  const LostFindLView({Key? key}) : super(key: key);

  @override
  _LostFindLViewState createState() => _LostFindLViewState();
}

class _LostFindLViewState extends State<LostFindLView> {
  final _lostFindController = Get.put(LostFindController());
  final _authController = Get.find<AuthController>();
  final List<bool> isSelected = [true, false];
  final List<String> category = ['유실물', '내가 찾는 물건'];
  int target = 0;
  bool isExpanded = true;
  late Future search;
  bool isValidated = false;

  @override
  void initState() {
    super.initState();
    search = _lostFindController.search(target);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('유실물 찾기'),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      floatingActionButton: Visibility(
        visible: target == 1 ? false : true,
        child: FloatingActionButton.extended(
          onPressed: () {
            Get.toNamed(
                Service.LOST_FIND_REG_ROUTE); //Service.LOST_FIND_REG_ROUTE
          },
          label: const Text(
            "유실물 등록",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          icon: Icon(Icons.edit),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          foregroundColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 47, 84, 170),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: RefreshIndicator(
        onRefresh: () async {
          _lostFindController.input.clear();
          _lostFindController.reset();
          await _lostFindController.search(target);
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              automaticallyImplyLeading: false,
              titleSpacing: 0.0,
              toolbarHeight: 70.h,
              title: Container(
                height: 70.h,
                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Center(
                  child: TextFormField(
                    controller: _lostFindController.input,
                    textInputAction: TextInputAction.done,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onEditingComplete: () async {
                      _lostFindController.reset();
                      await _lostFindController.search(target);
                      setState(() {});
                      FocusScope.of(context).unfocus();
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      // hintText: 'search',
                    ),
                  ),
                ),
              ),
            ),
            SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              titleSpacing: 0.0,
              toolbarHeight: 55.h,
              title: Container(
                width: double.infinity,
                height: 55.h,
                color: const Color.fromARGB(255, 233, 239, 255),
                child: Center(
                  child: Container(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    height: 35,
                    child: ToggleButtons(
                      borderColor: const Color.fromARGB(0, 255, 255, 255),
                      constraints:
                          BoxConstraints.tight(const Size(355 / 2, 35)),
                      color: const Color.fromARGB(75, 47, 84, 170),
                      selectedColor: const Color.fromARGB(255, 255, 255, 255),
                      selectedBorderColor:
                          const Color.fromARGB(255, 47, 84, 170),
                      fillColor: const Color.fromARGB(255, 47, 84, 170),
                      splashColor: const Color.fromARGB(255, 47, 84, 170),
                      hoverColor: const Color.fromARGB(255, 47, 84, 170),
                      borderRadius: BorderRadius.circular(4.0),
                      isSelected: isSelected,
                      onPressed: (index) async {
                        if (!isSelected[index]) {
                          setState(() {
                            isSelected[target] = !isSelected[target];
                            isSelected[index] = !isSelected[index];
                            target = index;
                            if (target == 1) {
                              Get.offNamed('/lost-findF');
                            } else {
                              Get.offNamed('/lost-find');
                            }
                            isExpanded = true;
                          });
                        }
                        _lostFindController.input.clear();
                        _lostFindController.reset();
                        await _lostFindController.search(target);
                      },
                      children: [
                        Text(LostFind.category[0]),
                        Text(LostFind.category[1]),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                ExpansionPanelList(
                  elevation: 0.0,
                  animationDuration: const Duration(milliseconds: 700),
                  expandedHeaderPadding: EdgeInsets.zero,
                  expansionCallback: (panelIndex, isExpanded) {
                    setState(() {
                      this.isExpanded = !this.isExpanded;
                    });
                  },
                ),
                BoardComponent(
                  title: '검색결과',
                  paddingR: 0.0,
                  paddingL: 0.0,
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  child: Obx(
                    () => Column(
                      children: [
                        for (var e in _lostFindController.maps['lostfind'])
                          Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  WebController.toWebView(e);
                                },
                                title: Text(
                                  e.title,
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                subtitle: Text(
                                  '${e.author}에서 ${e.datetime}에 작성',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              const Divider(),
                            ],
                          ),
                        Center(
                          child: _authController.status == Auth.isAnonymous
                              ? TextButton(
                                  onPressed: () =>
                                      Get.toNamed(Service.SIGN_IN_ROUTE),
                                  child: const Text('로그인하여 모든 유실물 찾기 글 보기'),
                                )
                              : _lostFindController.state
                                  ? TextButton.icon(
                                      icon: const Icon(Icons.add),
                                      label: const Text('더 불러오기'),
                                      onPressed: () async {
                                        _lostFindController.state = false;
                                        setState(() {});
                                        await _lostFindController
                                            .search(target);
                                      },
                                    )
                                  : const CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
