import 'package:cuk/asset/data/service.dart';
import 'package:cuk/view_model/controller/notice_pin_controller.dart';
import 'package:cuk/view_model/controller/web_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoticePinView extends StatefulWidget {
  const NoticePinView({Key? key}) : super(key: key);

  @override
  State<NoticePinView> createState() => _NoticePinViewState();
}

class _NoticePinViewState extends State<NoticePinView> {
  final _noticePinController = Get.find<NoticePinController>();
  final List<bool> _isChecked = [];
  late List _list;

  void setting() {
    _list = _noticePinController.list;
    _isChecked.clear();
    for (int i = 0; i < _list.length; i++) {
      _isChecked.insert(i, false);
    }
  }

  @override
  void initState() {
    super.initState();
    setting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: _isChecked.contains(true),
        child: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 47, 84, 170),
          child: const Icon(Icons.delete),
          onPressed: () async {
            List list = [];
            for (int i = 0; i < _isChecked.length; i++) {
              if (_isChecked[i]) {
                list.add(_list[i]);
              }
            }
            await _noticePinController.deleteArgs(list);
            setState(() {
              setting();
            });
          },
        ),
      ),
      appBar: AppBar(
        title: const Text('My PIN'),
        actions: [
          IconButton(
            onPressed: () => Get.offAllNamed(Service.HOME_ROUTE),
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView.separated(
                itemCount: _list.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemBuilder: (BuildContext context, int index) => ListTile(
                  onTap: () => WebController.toLaunch(_list[index].url),
                  tileColor: Colors.white,
                  title: Text(
                    _list[index].title,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  subtitle: Text(
                    '${_list[index].author} | ${_list[index].datetime} | ${_list[index].type}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  trailing: Checkbox(
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked[index] = value!;
                      });
                    },
                    value: _isChecked[index],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
