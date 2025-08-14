// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ruler Picker Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Ruler Picker Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  RulerPickerController? _rulerPickerController;

  num currentValue = 16.2;

  List<RulerRange> ranges = const [
    RulerRange(begin: 0, end: 10, scale: 0.1),
    RulerRange(begin: 10, end: 100, scale: 1),
    RulerRange(begin: 100, end: 1000, scale: 10),
    RulerRange(begin: 1000, end: 10000, scale: 100),
    RulerRange(begin: 10000, end: 100000, scale: 1000)
  ];

  @override
  void initState() {
    super.initState();
    _rulerPickerController = RulerPickerController(value: currentValue);
  }

  Widget _buildPositionBtn(num value) {
    return InkWell(
      onTap: () {
        _rulerPickerController?.value = value;
      },
      child: Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          color: Colors.blue,
          child: Text(
            value.toString(),
            style: TextStyle(color: Colors.white),
          )),
    );
  }

  Widget _buildChangeRangerBtn(String tip, List<RulerRange> rangeList) {
    return InkWell(
      onTap: () {
        setState(() {
          ranges = rangeList;
        });
      },
      child: Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          color: Colors.blue,
          child: Text(
            tip,
            style: TextStyle(color: Colors.white),
          )),
    );
  }

  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              currentValue.toStringAsFixed(1),
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 80),
            ),
            const SizedBox(height: 50),
            RulerPicker(
              initValue: 15.2,
              controller: _rulerPickerController!,
              onBuildRulerScaleText: (index, value) {
                return '${value.toStringAsFixed(1)} kg';
              },
              ranges: const [RulerRange(begin: 5, end: 300, scale: 0.1)],
              scaleLineStyleList: const [
                ScaleLineStyle(color: Colors.grey, width: 0.5, height: 50, scale: 0),
                ScaleLineStyle(color: Colors.grey, width: 0.5, height: 35, scale: 5),
                ScaleLineStyle(color: Colors.grey, width: 0.5, height: 35, scale: -1)
              ],
              onValueChanged: (value) {
                setState(() {
                  currentValue = value;
                });
              },
              width: MediaQuery.of(context).size.width,
              height: 80,
              marker: Container(
                  width: 1,
                  height: 50,
                  decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5))),
            ),
          ],
        ),
      ),
    );
  }
}
