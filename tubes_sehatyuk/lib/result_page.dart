import 'package:flutter/material.dart';
import 'routes.dart';

class ResultPage extends StatelessWidget {
  final String diseaseName;
  final double percentage;

  ResultPage({super.key, required this.diseaseName, required this.percentage});

  @override
  Widget build(BuildContext context) {
    bool isPositive = percentage >= 60;
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
            'Hasil Checkup',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.all(16.0),
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
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    isPositive
                        ? Icons.sentiment_dissatisfied
                        : Icons.sentiment_satisfied,
                    color: isPositive ? Colors.red : Colors.green,
                    size: 80,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Kemungkinan $diseaseName ${percentage.toStringAsFixed(1)}%',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    isPositive
                        ? 'Kamu bisa lakukan checkup ke dokter untuk memastikan gejala yang kamu alami ya!'
                        : 'Sepertinya kamu baik-baik saja, tetap jaga kesehatan!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
              Positioned(
                right: 0,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.red),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Routes.routes['/home']!(context)),
                          (Route<dynamic> route) => false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
