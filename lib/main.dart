import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.orange[200],
        child: CustomMultiChildLayout(
          delegate: MyDelegate(thickness:10),
          children: [
            LayoutId(
              id: "underline",
              child: Container(
                color: Colors.red,
              ),
            ),
            LayoutId(
              id: "text", //有id, 在performLayout裡面就可以找到
              child: Text(
                "WSBT",
                style: TextStyle(fontSize: 72),
              ),
            ),
            // LayoutId(
            //   id: 1, //有id, 在performLayout裡面就可以找到
            //   child: FlutterLogo(),
            // ),
            // LayoutId(
            //   id: 2,
            //   child: FlutterLogo(),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyDelegate extends MultiChildLayoutDelegate {
  final double thickness;


  MyDelegate({this.thickness = 8.0});

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(300,300);
  }

  @override
  void performLayout(Size size) {
    final sizeText = layoutChild(
      "text",
      BoxConstraints.loose(size),
      // ),
    );
    layoutChild("underline", BoxConstraints.tight(Size(sizeText.width, thickness)));

    //決定把child畫在哪裡
    final left = (size.width - sizeText.width) / 2;
    final top = (size.height - sizeText.height) / 2;
    positionChild("text", Offset(left, top));
    positionChild("underline", Offset(left, top + sizeText.height));
  }

  // var size1, size2;
  // //去處理Layout佈局
  // if (hasChild(1)) {
  //   size1 = layoutChild(
  //     1,
  //     // BoxConstraints.tight(Size(48,48)),
  //     BoxConstraints.loose(size),
  //     // BoxConstraints(
  //     //   minWidth: 100,
  //     //   minHeight: 100,
  //     //   maxWidth: 100,
  //     //   maxHeight: 100,
  //     // ),
  //   );
  //   //決定把child畫在哪裡
  //   positionChild(1, Offset(0, 0));
  // }
  // if (hasChild(2)) {
  //   size2 = layoutChild(
  //     2,
  //     BoxConstraints(
  //       minWidth: 200,
  //       minHeight: 200,
  //       maxWidth: 200,
  //       maxHeight: 200,
  //     ),
  //   );
  //   //決定把child畫在哪裡
  //   positionChild(2, Offset(0, size1.height));
  // }
  // }

  @override
  //在發生事件的時候會來詢問是否需要重新performLayout
  bool shouldRelayout(_) => true;
}
