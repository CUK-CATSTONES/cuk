import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class LostFindRegisterView extends StatefulWidget {
  @override
  _LostFindRegister_view createState() => _LostFindRegister_view();
  final TextEditingController _NameInput = TextEditingController();
  final TextEditingController _PlaceInput = TextEditingController();
  final TextEditingController _EtcInput = TextEditingController();

  void dispose() {
    _NameInput.dispose();
    _PlaceInput.dispose();
    _EtcInput.dispose();
  }
}

class _LostFindRegister_repo {
  String _category = ''; //카테고리 버튼
  String _CategoryDetails = ''; //cateogory 세부사항
  String _name = ''; //물건 이름
  String _place = ''; //습득장소 버튼
  String _placeIn = ''; //보관장소
  String _PlaceDetails = ''; //place 세부사항
  DateTime _date = DateTime.now(); //습득일자
  String _ETC = ''; //기타사항
}

class _LostFindRegister_view extends State<LostFindRegisterView>
    with _LostFindRegister_repo {
  late DateTime initialDate = DateTime.now();
  late DateTime selectedDate;
  String selectedButton = '';
  String selectedCategory = '';
  bool _selectedCat = true;
  bool _selectedPla = true;
  Widget _categoryButton(String title) {
    return OutlinedButton(
        onPressed: () {
          handleCategorySelection(title);
          _category = title;
          _selectedCat = !_selectedCat;
        },
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          maximumSize: Size(100, 45),
          textStyle: TextStyle(foreground: Paint()..color = Colors.black),
          backgroundColor: selectedCategory == title
              ? Color.fromARGB(162, 133, 133, 133)
              : Colors.white,
          side: BorderSide(
              color: selectedCategory == title ? Colors.grey : Colors.grey),
        ),
        child: Text(title));
  }

  void handleCategorySelection(String value) {
    setState(() {
      selectedCategory = value;
    });
  }

  Widget _placeButton(String title) {
    return OutlinedButton(
        onPressed: () {
          handleGetPlaceSelection(title);
          _selectedPla = !_selectedPla;
          _place = title;
        },
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          maximumSize: Size(100, 45),
          textStyle: TextStyle(foreground: Paint()..color = Colors.black),
          backgroundColor: selectedCategory == title
              ? Color.fromARGB(162, 133, 133, 133)
              : Colors.white,
          side: BorderSide(
              color: selectedCategory == title ? Colors.grey : Colors.grey),
        ),
        child: Text(title));
  }

  void handleGetPlaceSelection(String value) {
    setState(() {
      selectedCategory = value;
    });
  }

  ElevatedButton _elevatedButton(String label) {
    return ElevatedButton(
      onPressed: () {
        handlePlaceSelection(label);
        _placeIn = label;
      },
      style: ElevatedButton.styleFrom(
          maximumSize: Size(100, 45),
          backgroundColor: selectedButton == label
              ? Color.fromRGBO(234, 239, 253, 1)
              : Color.fromRGBO(221, 221, 221, 1),
          foregroundColor: Color.fromRGBO(82, 82, 82, 1.000)),
      child: Text(label),
    );
  }

  void handlePlaceSelection(String value) {
    setState(() {
      selectedButton = value;
    });
  }

  void _toggleFolder1() {
    setState(() {
      _selectedCat = !_selectedCat;
    });
  }

  void _toggleFolder2() {
    setState(() {
      _selectedPla = !_selectedPla;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '유실물 등록',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Get.back(); //need to be changed
            },
          ),
        ],
        elevation: 0.0,
        centerTitle: false,
      ),
      body: ListView(
        //for 1st
        padding: EdgeInsets.all(0),
        children: <Widget>[
          SizedBox(height: 20.0),
          ListTile(
            title: Text('물건 이름'),
            trailing: Icon(_selectedCat
                ? Icons.keyboard_arrow_up
                : Icons.keyboard_arrow_down),
            onTap: _toggleFolder1,
          ),
          AnimatedContainer(
            padding: EdgeInsets.all(16.0),
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: _selectedCat ? null : 0.0,
            child: _selectedCat
                ? Wrap(spacing: 10.0, children: <Widget>[
                    _categoryButton('가방'),
                    _categoryButton('책'),
                    _categoryButton('화장품'),
                    _categoryButton('의류'),
                    _categoryButton('전자기기'),
                    _categoryButton('지갑'),
                    _categoryButton('서류'),
                    _categoryButton('카드'),
                    _categoryButton('악세사리'),
                    _categoryButton('기숙사키'),
                    _categoryButton('우산'),
                    _categoryButton('기타'),
                  ])
                : null,
          ), //for 2nd
          Container(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 16.0),
            child: TextField(
              controller: widget._NameInput,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                hintText: '예시) 아이폰 13, 경재학개론',
                counterText: '10자 이내',
              ),
              maxLength: 10,
            ),
          ),

          SizedBox(height: 15.0),
          Column(children: [
            Container(
              height: MediaQuery.of(context).copyWith().size.height / 3,
              child: CupertinoDatePicker(
                initialDateTime: initialDate,
                onDateTimeChanged: (DateTime newdate) {
                  selectedDate = newdate;
                },
                minimumYear: 2021,
                maximumYear: DateTime.now().year,
                mode: CupertinoDatePickerMode.date,
              ),
            ),
          ]),
          Container(
            margin: EdgeInsets.zero,
            child: Divider(
              color: Color.fromRGBO(234, 239, 253, 1),
              height: 10,
              thickness: 10,
            ),
          ),
          SizedBox(height: 15.0), //for 2nd
          ListTile(
            title: Text('습득장소'),
            trailing: Icon(_selectedPla
                ? Icons.keyboard_arrow_up
                : Icons.keyboard_arrow_down),
            onTap: _toggleFolder2,
          ),
          AnimatedContainer(
            padding: EdgeInsets.all(16.0),
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: _selectedPla ? null : 0.0,
            child: _selectedPla
                ? Wrap(spacing: 10.0, children: <Widget>[
                    _placeButton('니콜스관'),
                    _placeButton('다솔관'),
                    _placeButton('학생회관'),
                    _placeButton('김수환관'),
                    _placeButton('기숙사'),
                    _placeButton('마리아관'),
                    _placeButton('비루투스'),
                    _placeButton('밤비노관'),
                    _placeButton('콘서트홀'),
                    _placeButton('성심성당'),
                    _placeButton('약학관'),
                    _placeButton('중앙도서관'),
                    _placeButton('기타'),
                  ])
                : null,
          ),
          Container(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 16.0),
            child: TextField(
              controller: widget._PlaceInput,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                hintText: '예시) 아이폰 13, 경재학개론',
                counterText: '10자 이내',
              ),
              maxLength: 10,
            ),
          ),
          Container(
            margin: EdgeInsets.zero,
            child: Divider(
              color: Color.fromRGBO(234, 239, 253, 1),
              height: 10,
              thickness: 10,
            ),
          ),
          SizedBox(height: 15.0), //for 2nd
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '보관 장소',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _elevatedButton('학생지원팀'),
              _elevatedButton('경비실'),
              _elevatedButton('기숙사'),
            ],
          ),
          SizedBox(height: 15.0), //for 2nd
          Container(
            margin: EdgeInsets.zero,
            child: Divider(
              color: Color.fromRGBO(234, 239, 253, 1),
              height: 10,
              thickness: 10,
            ),
          ),
          SizedBox(height: 15.0), //for 2nd
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '기타 사항',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 8.0),
            child: TextField(
              controller: widget._EtcInput,
              keyboardType: TextInputType.multiline,
              style: TextStyle(fontSize: 12.0),
              minLines: 3,
              maxLines: 3,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText:
                      '추가적인 정보를 적어주세요. \n예시) 제가 개인적으로 보관중이니 카카오톡아이디 XXXXX로 연락주세요.',
                  counterText: '3줄이내',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  )),
            ),
          ),
          SizedBox(height: 15.0),
          Container(
            padding: EdgeInsetsDirectional.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                // backgroundColor: Color.fromARGB(0, 42, 74, 188),
                backgroundColor: Color.fromRGBO(42, 74, 188, 1.00),
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50.0),
                textStyle: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              onPressed: () {
                widget._NameInput.text = _name;
                widget._PlaceInput.text = _PlaceDetails;
                widget._EtcInput.text = _ETC;
                _date = selectedDate;
                Get.back();
                print(_date);
              },
              child: Text('등록'),
            ),
          ),

          SizedBox(height: 30.0),
        ],
      ),
    );
  }
}
