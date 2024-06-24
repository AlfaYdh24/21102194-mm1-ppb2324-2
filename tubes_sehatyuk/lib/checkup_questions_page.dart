import 'package:flutter/material.dart';
import 'result_page.dart';

class CheckupQuestionsPage extends StatefulWidget {
  final String title;
  final List<String> questions;
  CheckupQuestionsPage({super.key, required this.title, required this.questions});

  @override
  _CheckupQuestionsPageState createState() => _CheckupQuestionsPageState();
}

class _CheckupQuestionsPageState extends State<CheckupQuestionsPage> {
  Map<int, String> answers = {};
  String? errorMessage;

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
        title: Center(
          child: Text(
            'Check ${widget.title}',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  errorMessage!,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ListView.builder(
                  itemCount: widget.questions.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.questions[index],
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Transform.scale(
                                      scale: 0.8,
                                      child: Radio<String>(
                                        value: 'Ya',
                                        groupValue: answers[index],
                                        onChanged: (value) {
                                          setState(() {
                                            answers[index] = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Flexible(
                                        child: Text('Ya',
                                            style: TextStyle(fontSize: 12))),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Transform.scale(
                                      scale: 0.8,
                                      child: Radio<String>(
                                        value: 'Tidak Pernah',
                                        groupValue: answers[index],
                                        onChanged: (value) {
                                          setState(() {
                                            answers[index] = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Flexible(
                                        child: Text('Tidak Pernah',
                                            style:
                                            TextStyle(fontSize: 12))),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 12),
            Container(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () {
                  if (answers.length != widget.questions.length) {
                    setState(() {
                      errorMessage = 'Harap jawab semua pertanyaan!';
                    });
                  } else {
                    int yesCount = answers.values.where((answer) => answer == 'Ya').length;
                    double percentage = (yesCount / widget.questions.length) * 100;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultPage(
                          diseaseName: widget.title,
                          percentage: percentage,
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Background color
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)), // No rounded corners
                  ),// Text color
                ),
                child: const Text('Kirim'),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
