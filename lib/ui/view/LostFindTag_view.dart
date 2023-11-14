import 'package:flutter/material.dart';
import 'package:get/get.dart';

// void main() => runApp(LostFindTagView());

class LostFindTagView extends StatefulWidget {
  @override
  _LostFindTag_view createState() => _LostFindTag_view();
  final TextEditingController _NameInput = TextEditingController();
  final TextEditingController _DetailInput = TextEditingController();

  void dispose() {
    _NameInput.dispose();
    _DetailInput.dispose();
    dispose();
  }
}

//repo for LostFindTagView that includes all the data
class _LostFindTag_repo {
  List<String> _tags = []; //태그들 일단 태그 이름으로만 저장 변경 필요
  String _details = ''; //세부사항
  String _name = ''; //물건 이름
}

class _LostFindTag_view extends State<LostFindTagView> with _LostFindTag_repo {
  List<bool> _selected = List.generate(63, (index) => false);

  Widget _buildButton(String title, int index) {
    return OutlinedButton(
      child: Text(title),
      onPressed: () {
        setState(() {
          _selected[index] = !_selected[index];
          if (_selected[index]) {
            _tags.add(title);
          } else {
            _tags.remove(title);
          }
          // print(_tags);
        });
      },
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        textStyle: TextStyle(fontSize: 11.0),
        maximumSize: Size(100, 45),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '내가 찾는 물건',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
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
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          TextField(
            controller: widget._NameInput,
            decoration: InputDecoration(
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              prefixIconColor: Colors.black,
              labelText: '찾는 물건',
              hintText: 'ex)에어팟 프로 (10자이내)',
              counterText: '10자 이내',
            ),
            maxLength: 10,
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              '찾고 있는 물건',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Wrap(
            spacing: 10.0,
            children: <Widget>[
              _buildButton('가방', 0),
              _buildButton('책', 1),
              _buildButton('화장품', 2),
              _buildButton('전자기기', 3),
              _buildButton('서류', 4),
              _buildButton('기숙사키', 5),
              _buildButton('우산', 6),
              _buildButton('악세사리', 7),
              _buildButton('악기', 8),
              _buildButton('의류', 9),
              _buildButton('카드', 10),
              Divider(
                color: Colors.grey,
                height: 10,
                thickness: 0.5,
                indent: 10,
                endIndent: 10,
              ),
              _buildButton('빨간색', 11),
              _buildButton('주황색', 12),
              _buildButton('노란색', 13),
              _buildButton('초록색', 14),
              _buildButton('파란색', 15),
              _buildButton('남색', 16),
              _buildButton('보라색', 17),
              Divider(
                color: Colors.grey,
                height: 10,
                thickness: 0.5,
                indent: 10,
                endIndent: 10,
              ),
              _buildButton('케이스', 18),
              _buildButton('왼쪽', 19),
              _buildButton('오른쪽', 20),
              _buildButton('키링', 21),
              _buildButton('로고', 22),
              _buildButton('남자', 23),
              _buildButton('여자', 24),
            ],
          ),
          SizedBox(height: 15.0), //for 2nd
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              '장소',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: <Widget>[
              _buildButton('니콜스', 25),
              _buildButton('다솔관', 26),
              _buildButton('학생회관', 27),
              _buildButton('김수환관', 28),
              _buildButton('비루투스', 29),
              _buildButton('콘서트', 30),
              _buildButton('성당', 31),
              _buildButton('약학관', 32),
              _buildButton('중앙도서관', 33),
              _buildButton('교외', 34),
              Divider(
                color: Colors.grey,
                height: 10,
                thickness: 0.5,
                indent: 10,
                endIndent: 10,
              ),
              _buildButton('1층', 35),
              _buildButton('2층', 36),
              _buildButton('3층', 37),
              _buildButton('4층', 38),
              _buildButton('5층', 39),
              _buildButton('6층', 40),
              Divider(
                color: Colors.grey,
                height: 10,
                thickness: 0.5,
                indent: 10,
                endIndent: 10,
              ),
              _buildButton('교외', 41),
              _buildButton('창틀', 42),
              _buildButton('카페', 43),
              _buildButton('흡연구역', 44),
              _buildButton('화장실', 45),
              _buildButton('택시', 46),
              _buildButton('벤치', 47),
              _buildButton('하랑', 48),
              _buildButton('인포', 49),
              _buildButton('헬스장', 50),
              _buildButton('책상', 51),
              _buildButton('로비', 52),
              _buildButton('식당', 53),
              _buildButton('열람실', 54),
              _buildButton('창틀', 55),
            ],
          ),
          SizedBox(height: 15.0), //for 3rd
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              '잃어버린 요일',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Wrap(
            spacing: 8.0,
            children: [
              _buildButton('월요일', 56),
              _buildButton('화요일', 57),
              _buildButton('수요일', 58),
              _buildButton('목요일', 59),
              _buildButton('금요일', 60),
              _buildButton('토요일', 61),
              _buildButton('일요일', 62),
            ],
          ),
          SizedBox(
            height: 10.0,
          ), //for 4th
          TextField(
            controller: widget._DetailInput,
            decoration: InputDecoration(
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              prefixIconColor: Colors.black,
              labelText: '위에 없는 세부사항',
              counterText: '10자 이내',
            ),
            maxLength: 10,
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              // backgroundColor: Color.fromARGB(0, 42, 74, 188),
              backgroundColor: Color.fromRGBO(42, 74, 188, 1.00),
              foregroundColor: Colors.white,
              minimumSize: Size(double.infinity, 50.0),
              textStyle: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            onPressed: () {
              _details = widget._DetailInput.text; //세부사항
              _name = widget._NameInput.text; //이름
              print(_tags);
              print(_details);
              print(_name);
              Get.back();
            },
            child: Text('등록'),
          ),
          SizedBox(height: 30.0),
        ],
      ),
    );
  }
}
