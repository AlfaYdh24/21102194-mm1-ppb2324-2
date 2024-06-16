import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  final String? data;
  const SecondPage({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data2 = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
        backgroundColor: const Color.fromARGB(255, 54, 136, 244),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              data ?? '',
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              data2.toString() ?? '',
              style: const TextStyle(fontSize: 20.0),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 54, 136, 244),
                ),
              ),
              child: const Text('Kembali', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),

      ),

    );
  }
}