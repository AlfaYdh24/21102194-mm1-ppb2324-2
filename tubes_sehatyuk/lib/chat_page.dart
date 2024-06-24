import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/doctor_avatar.png'), // Add your doctor avatar image in assets
            ),
            SizedBox(width: 8),
            Text(
              'Dr Ayman Alatas',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text('Dok cara hindari penyakit jantung apa ya'),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.only(bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Olahraga teratur\nLakukan olahraga kardio, seperti jogging, berjalan kaki, renang, ataupun bersepeda.\nJenis olahraga tersebut dapat menguatkan kerja otot jantung dan melancarkan peredaran darah ke seluruh tubuh.',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text('Oke dok'),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Tulis Pesan...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Handle send message
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
