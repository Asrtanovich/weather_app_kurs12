import 'dart:developer';

import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});
  // final _controller = TextEditingController();
  String? text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: TextFormField(
                onChanged: (value) {
                  text = value;
                  log('$text');
                },
                // controller: _controller,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  hintText: 'Shaardy jaz',
                  hintStyle: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.greenAccent),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.purple),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 35, vertical: 15)),
                  backgroundColor: MaterialStateProperty.all(Colors.cyan),
                ),
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  // log('${_controller.text}');
                },
                child: Text(
                  'Shaardy tap',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
