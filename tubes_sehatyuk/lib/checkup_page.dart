import 'package:flutter/material.dart';

class CheckupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const TabBar(
            tabs: [
              Tab(text: 'Checkup'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body: ListView.builder(
          itemCount: checkupItems.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                title: Text(checkupItems[index]['title']),
                trailing: Icon(checkupItems[index]['icon']),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/checkup_questions',
                    arguments: {
                      'title': checkupItems[index]['title'],
                      'questions': List<String>.from(checkupItems[index]['questions']),
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> checkupItems = [
    {
      'title': 'HIV AIDS',
      'icon': Icons.bug_report,
      'questions': [
        'Apakah kamu sering merasa lelah?',
        'Apakah kamu mengalami penurunan berat badan?',
        'Apakah kamu sering demam?',
        'Apakah kamu sering berkeringat di malam hari?',
        'Apakah kamu mengalami pembengkakan kelenjar getah bening?'
      ]
    },
    {
      'title': 'Malaria',
      'icon': Icons.sick,
      'questions': [
        'Apakah kamu sering merasa demam?',
        'Apakah kamu sering menggigil?',
        'Apakah kamu merasa mual?',
        'Apakah kamu mengalami sakit kepala?',
        'Apakah kamu merasa lelah atau lemah?'
      ]
    },
    {
      'title': 'Tuberculosis',
      'icon': Icons.local_hospital,
      'questions': [
        'Apakah kamu batuk lebih dari tiga minggu?',
        'Apakah kamu batuk berdarah?',
        'Apakah kamu merasa sakit di dada?',
        'Apakah kamu kehilangan nafsu makan?',
        'Apakah kamu merasa demam atau berkeringat di malam hari?'
      ]
    },
    {
      'title': 'Hepatitis',
      'icon': Icons.medical_services,
      'questions': [
        'Apakah kamu mengalami sakit perut?',
        'Apakah kamu kehilangan nafsu makan?',
        'Apakah kamu merasa lelah?',
        'Apakah kulit atau mata kamu menguning?',
        'Apakah urine kamu berwarna gelap?'
      ]
    }
  ];
}
