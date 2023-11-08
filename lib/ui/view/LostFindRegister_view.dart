import 'package:flutter/material.dart';
import 'package:spinner_date_time_picker/spinner_date_time_picker.dart';

void main() => runApp(LostFindRegisterView());

class LostFindRegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'for development',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.white,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
      home: LostFindRegister_view(),
    );
  }
}

class LostFindRegister_view extends StatefulWidget {
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

class _LostFindRegister_view extends State<LostFindRegister_view> {
  List<bool> _selected = List.generate(63, (index) => false);
  var today = DateTime.now();
  DateTime selectedDate = DateTime.now();
  String selectedButton = '';
  Widget _buildButton(String title, int index) {
    return OutlinedButton(
      child: Text(title),
      onPressed: () {
        setState(() {
          _selected[index] = !_selected[index];
        });
      },
      style: OutlinedButton.styleFrom(
        primary: _selected[index]
            ? Color.fromARGB(162, 133, 133, 133)
            : Colors.black,
        backgroundColor: _selected[index]
            ? Color.fromARGB(173, 173, 173, 173)
            : Colors.white,
        side: BorderSide(color: _selected[index] ? Colors.grey : Colors.grey),
      ),
    );
  }

  ElevatedButton _elevatedButton(String label) {
    return ElevatedButton(
      onPressed: () {
        handleButtonSelection(label);
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: selectedButton == label
              ? Color.fromRGBO(234, 239, 253, 1)
              : Color.fromRGBO(221, 221, 221, 1),
          foregroundColor: Color.fromRGBO(82, 82, 82, 1.000)),
      child: Text(label),
    );
  }

  void handleButtonSelection(String value) {
    setState(() {
      selectedButton = value;
    });
  }

  bool _isOpen1 = true;
  bool _isOpen2 = true;
  void _toggleFolder1() {
    setState(() {
      _isOpen1 = !_isOpen1;
    });
  }

  void _toggleFolder2() {
    setState(() {
      _isOpen2 = !_isOpen2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onPressed: () {},
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
            trailing: Icon(
                _isOpen1 ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
            onTap: _toggleFolder1,
          ),
          AnimatedContainer(
            padding: EdgeInsets.all(16.0),
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: _isOpen1 ? null : 0.0,
            child: _isOpen1
                ? Wrap(spacing: 10.0, children: <Widget>[
                    _buildButton('가방', 0),
                    _buildButton('책', 1),
                    _buildButton('화장품', 2),
                    _buildButton('의류', 3),
                    _buildButton('전자기기', 4),
                    _buildButton('지갑', 5),
                    _buildButton('서류', 6),
                    _buildButton('카드', 7),
                    _buildButton('악세사리', 8),
                    _buildButton('기숙사키', 9),
                    _buildButton('우산', 10),
                    _buildButton('기타', 11),
                  ])
                : null,
          ), //for 2nd
          Container(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 16.0),
            child: TextField(
              controller: widget._NameInput,
              decoration: InputDecoration(
                hintText: '예시) 아이폰 13, 경재학개론',
                counterText: '10자 이내',
              ),
              maxLength: 10,
            ),
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
          SpinnerDateTimePicker(
            initialDateTime: DateTime.now(),
            maximumDate: today.add(const Duration(days: 7)),
            minimumDate: today.subtract(const Duration(days: 1)),
            didSetTime: (value) {
              setState(() {
                selectedDate = value;
              });
            },
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
          ListTile(
            title: Text('습득장소'),
            trailing: Icon(
                _isOpen2 ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
            onTap: _toggleFolder2,
          ),
          AnimatedContainer(
            padding: EdgeInsets.all(16.0),
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: _isOpen2 ? null : 0.0,
            child: _isOpen2
                ? Wrap(spacing: 10.0, children: <Widget>[
                    _buildButton('니콜스관', 12),
                    _buildButton('다솔관', 13),
                    _buildButton('학생회관', 14),
                    _buildButton('김수환관', 15),
                    _buildButton('기숙사', 16),
                    _buildButton('마리아관', 17),
                    _buildButton('비루투스', 18),
                    _buildButton('밤비노관', 19),
                    _buildButton('콘서트홀', 20),
                    _buildButton('성심성당', 21),
                    _buildButton('약학관', 22),
                    _buildButton('중앙도서관', 23),
                    _buildButton('기타', 24),
                  ])
                : null,
          ),
          Container(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 16.0),
            child: TextField(
              controller: widget._NameInput,
              decoration: InputDecoration(
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
              style: TextStyle(fontSize: 10.0),
              minLines: 3,
              maxLines: 3,
              decoration: InputDecoration(
                  hintText:
                      '추가적인 정보를 적어주세요. \n예시) 제가 개인적으로 보관중이니 카카오톡아이디 XXXXX로 연락주세요.',
                  counterText: '10자 이내',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  )),
              maxLength: 10,
            ),
          ),
          SizedBox(height: 15.0), //for 2nd
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
              onPressed: () {},
              child: Text('등록'),
            ),
          ),

          SizedBox(height: 30.0),
        ],
      ),
    );
  }
}
