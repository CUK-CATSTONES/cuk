import 'package:flutter/material.dart';

void main() => runApp(everytime_view());

class everytime_view extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: Scaffold(
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
              onPressed: () {},
            ),
          ],
          elevation: 0.0,
          centerTitle: false,
        ),
        body: NotificationView(),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(
                top: 8, left: 20, right: 20, bottom: 8), // Add bottom padding
            child: Column(
              mainAxisSize: MainAxisSize.min, // Use min to fit content
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 10),
                        Text('습득일자', style: TextStyle(fontSize: 9)),
                        Text('23.09.09', style: TextStyle(fontSize: 9)),
                      ],
                    ),
                    Container(
                      height: 24,
                      child: VerticalDivider(
                        color: Colors.grey,
                        width: 1,
                        thickness: 1,
                        indent: 5,
                        endIndent: 5,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 10),
                        Text('습득장소', style: TextStyle(fontSize: 9)),
                        Text('알수없음', style: TextStyle(fontSize: 9)),
                      ],
                    ),
                    Container(
                      height: 24,
                      child: VerticalDivider(
                        color: Colors.grey,
                        width: 1,
                        thickness: 1,
                        indent: 5,
                        endIndent: 5,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 10),
                        Text('보관장소', style: TextStyle(fontSize: 9)),
                        Text('학생지원팀', style: TextStyle(fontSize: 9)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(42, 74, 188, 1.00),
                    onPrimary: Colors.white,
                    minimumSize: Size(double.infinity, 50.0),
                  ),
                  onPressed: () {
                    // Button press action
                  },
                  child: Text('등록'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: <Widget>[
          Card(
            elevation: 0.0,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('asset/images/everytime.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'CU 카드 분실물 찾아가세요.',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '2022.07.21 23:03',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    '제가 모르고 끌려온 카드로 충전된 2100원인가 결제했어요..\n죄송합니다...\n주인을 찾아가신 쪽지시면 송금해드리겠습니다.',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
