import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});
  final _controller = TextEditingController();
  // String? text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
<<<<<<< HEAD:lib/modules/search/view/search_view.dart
            image: AssetImage('assets/images/sunset.jpg'),
=======
            image: AssetImage('assets/images/облака.jpg'),
>>>>>>> 710a733557a881870b4a8b4dd05e004cddf704a7:lib/views/search_view.dart
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
                // onChanged: (value) {
                //   text = value;
                //   log('$text');
                // },
                controller: _controller,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
<<<<<<< HEAD:lib/modules/search/view/search_view.dart
                  hintText: 'Поискь города',
=======
                  hintText: 'Поиск города',
>>>>>>> 710a733557a881870b4a8b4dd05e004cddf704a7:lib/views/search_view.dart
                  hintStyle: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: Color.fromARGB(154, 69, 66, 66),
                    ),
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
                  EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                ),
<<<<<<< HEAD:lib/modules/search/view/search_view.dart
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    Get.back(result: _controller.text);
                  }
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Text(
                  'Искать',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ))
=======
                backgroundColor: MaterialStateProperty.all(Colors.cyan),
              ),
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  Navigator.pop(context, _controller.text);
                }

                FocusManager.instance.primaryFocus?.unfocus();
                // log('${_controller.text}');
              },
              child: Text(
                'Искать',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            )
>>>>>>> 710a733557a881870b4a8b4dd05e004cddf704a7:lib/views/search_view.dart
          ],
        ),
      ),
    );
  }
}
