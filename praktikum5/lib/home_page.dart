import 'package:flutter/material.dart';

import 'second_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: const Color.fromARGB(255, 54, 136, 244),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SecondPage(data: 'Data dari Home Page',),
                  ),
                );

              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 54, 136, 244),
                ),
              ),
              child: const Text('Menuju halaman kedua', style: TextStyle(color: Colors.white)),
            ),

            // Tombol kedua
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second_page', arguments: 'Menggunakan route');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 54, 136, 244),
                ),
              ),
              child: const Text('Menuju halaman kedua dengan route', style: TextStyle(color: Colors.white)),
            ),

          ],
        ),
      ),

    );
  }
}