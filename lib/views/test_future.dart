import 'package:flutter/material.dart';

class TestFuture extends StatefulWidget {
  const TestFuture({Key? key}) : super(key: key);

  @override
  _TestFutureState createState() => _TestFutureState();
}

class _TestFutureState extends State<TestFuture> {
  String text = 'Synchronno ishtedi';
  String? textAsync;
  @override
  void initState() {
    getText();
    super.initState();
  }

  Future<String> getText() async {
    try {
      return await Future.delayed(Duration(seconds: 3), () {
        setState(() {});
        return textAsync = 'Text Async keldi';
      });
    } catch (problem) {
      throw Exception(problem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 35,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            textAsync ?? 'Emi kelet',
            style: TextStyle(
              fontSize: 35,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Salam',
            style: TextStyle(
              fontSize: 35,
            ),
          ),
        ],
      ),
    ));
  }
}
