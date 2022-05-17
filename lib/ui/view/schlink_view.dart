import 'package:cuk/asset/data/service.dart';
import 'package:cuk/ui/component/board_component.dart';
import 'package:cuk/ui/widget/flatile_md_widget.dart';
import 'package:cuk/view_model/controller/schlink_controller.dart';
import 'package:cuk/view_model/controller/slot_controller.dart';
import 'package:cuk/view_model/controller/web_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class SchLinkView extends StatelessWidget {
  final _schLinkController = Get.put(SchLinkController());
  final _slotController = Get.find<SlotController>();

  SchLinkView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('링크 모아보기'),
        actions: [
          IconButton(
            onPressed: () => Get.offAllNamed(Service.HOME_ROUTE),
            icon: const Icon(Icons.close),
            color: Colors.black,
            padding: const EdgeInsets.all(0.0),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            titleSpacing: 0.0,
            toolbarHeight: 70.h,
            title: Container(
              height: 70.h,
              padding: EdgeInsets.only(left: 8.w, right: 8.w),
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Center(
                child: TextFormField(
                  controller: _schLinkController.input,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: () async {
                    await _schLinkController.search();
                    FocusScope.of(context).unfocus();
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'search',
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 10),
              BoardComponent(
                title: '검색결과',
                paddingL: 0.0,
                paddingR: 0.0,
                backgroundColor: Colors.white,
                child: SizedBox(
                  child: Column(
                    children: _schLinkController.searched.map((element) {
                      var link = _schLinkController.toObject(element);
                      return Slidable(
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                Get.bottomSheet(
                                  SizedBox(
                                    height: 150.h,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              IconData(
                                                link.icon,
                                                fontFamily: 'MaterialIcons',
                                              ),
                                              color: Color(link.color),
                                            ),
                                            Text(
                                              link.title,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2,
                                            ),
                                          ],
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            Get.back();
                                            await _slotController
                                                .insertSlot(link);
                                            Get.back();
                                          },
                                          child: const Text('바로가기 추가'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  backgroundColor: Colors.white,
                                  elevation: 0,
                                  isScrollControlled: true,
                                );
                              },
                              backgroundColor:
                                  const Color.fromARGB(255, 233, 239, 255),
                              foregroundColor:
                                  const Color.fromARGB(255, 47, 84, 170),
                              icon: Icons.add,
                              label: '바로가기 추가',
                            ),
                          ],
                        ),
                        child: FlatileWidget_md(
                          elevation: 0.0,
                          marginT: 0.0,
                          marginB: 0.0,
                          title: link.title,
                          subtitle: link.description,
                          icon: IconData(
                            link.icon,
                            fontFamily: 'MaterialIcons',
                          ),
                          iconColor: Color(link.color),
                          onTap: () {
                            WebController.toLaunch(link.url);
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
