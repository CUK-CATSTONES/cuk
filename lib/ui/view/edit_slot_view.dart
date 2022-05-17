import 'package:cuk/asset/data/service.dart';
import 'package:cuk/ui/widget/flatile_md_widget.dart';
import 'package:cuk/view_model/controller/slot_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditSlotView extends StatefulWidget {
  const EditSlotView({Key? key}) : super(key: key);

  @override
  _EditSlotViewState createState() => _EditSlotViewState();
}

class _EditSlotViewState extends State<EditSlotView> {
  final _slotController = Get.find<SlotController>();

  late List _slot;

  @override
  void initState() {
    super.initState();
    _slot = _slotController.slot;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('바로가기 변경'),
        actions: [
          IconButton(
            onPressed: () => Get.offAllNamed(Service.HOME_ROUTE),
            icon: const Icon(Icons.close),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
            child: Align(
              child: ElevatedButton(
                onPressed: () async {
                  await _slotController.setSlot(_slot);
                  Get.offAllNamed(Service.HOME_ROUTE);
                },
                child: const Text('변경하기'),
              ),
            ),
          ),
          Expanded(
            child: ReorderableListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 15.h, bottom: 40.h),
              children: <Widget>[
                for (int index = 0; index < _slot.length; index++)
                  FlatileWidget_md(
                    key: Key('$index'),
                    elevation: 0.0,
                    marginT: 0.0,
                    marginB: 0.0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(0.0),
                      ),
                    ),
                    title: _slot[index].title,
                    subtitle: _slot[index].description,
                    icon: IconData(
                      _slot[index].icon,
                      fontFamily: 'MaterialIcons',
                    ),
                    iconColor: Color(_slot[index].color),
                    trailing: const Icon(
                      Icons.delete,
                      color: Color.fromARGB(255, 212, 113, 113),
                    ),
                    onTap: () => Get.bottomSheet(
                      SizedBox(
                        height: 150.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  IconData(
                                    _slot[index].icon,
                                    fontFamily: 'MaterialIcons',
                                  ),
                                  color: Color(_slot[index].color),
                                ),
                                Text(
                                  _slot[index].title,
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                _slot.removeAt(index);
                                setState(() {});
                                Get.back();
                              },
                              child: const Text('삭제하기'),
                            ),
                          ],
                        ),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 0,
                      isScrollControlled: true,
                    ),
                  ),
              ],
              onReorder: (int oldIndex, int newIndex) {
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final slot = _slot.removeAt(oldIndex);
                  _slot.insert(newIndex, slot);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
