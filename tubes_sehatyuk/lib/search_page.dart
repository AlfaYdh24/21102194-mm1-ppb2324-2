import 'package:flutter/material.dart';
import 'detail_article_page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _selectedIndex = 0;

  final List<String> categories = [
    'All',
    'Jantung',
    'Ginjal',
    'THT',
    'Sariawan'
  ];

  final List<Map<String, String>> articles = [
    {
      'title': 'Apa Itu Kanker',
      'description': 'This article will look at this subject, providing a brief overview of this subject.',
      'image': 'images/hepatitis.png',
      'category': 'Jantung',
      'content': 'Waspada! Inilah Beberapa Gejala Diabetes Yang Perlu Kamu Tau!\n\n'
          'Apa Itu Diabetes?\n\n'
          'Diabetes adalah penyakit kronis yang ditandai dengan tingginya kadar gula darah. '
          'Glukosa merupakan sumber energi utama bagi sel tubuh manusia. Akan tetapi, pada penderita diabetes, '
          'glukosa tersebut tidak dapat digunakan oleh tubuh.\n\n'
          'Gejala Diabetes\n\n'
          'Diabetes tipe 1 dapat berkembang dengan cepat dalam beberapa minggu atau bahkan beberapa hari saja. '
          'Sedangkan pada diabetes tipe 2, banyak penderitanya yang tidak menyadari bahwa mereka telah menderita diabetes selama bertahun-tahun, '
          'karena gejalanya cenderung tidak spesifik. Beberapa ciri-ciri penyakit gula atau diabetes tipe 1 dan tipe 2 meliputi:\n'
          '- Sering merasa haus atau sangat lapar\n'
          '- Sering buang air kecil, terutama pada malam hari\n'
          '- Penurunan berat badan tanpa sebab yang jelas\n'
          '- Kelelahan\n'
          '- Penglihatan kabur\n'
          '- Luka yang lama sembuh\n'
          '- Sering mengalami infeksi, seperti infeksi kulit, gusi, atau saluran kemih.'
    },
    {
      'title': 'Tanda-Tanda Jantung Bocor',
      'description': 'This article will look at this subject, providing a brief overview of this subject.',
      'image': 'images/tbc.png',
      'category': 'Jantung',
      'content': 'Tanda-tanda jantung bocor bisa beragam, termasuk nyeri dada, kelelahan, dan lainnya...\n\n'
          'Apa Itu Jantung Bocor?\n\n'
          'Jantung bocor adalah kondisi di mana ada kebocoran pada katup jantung. '
          'Kondisi ini dapat menyebabkan darah mengalir kembali ke jantung, '
          'mengurangi efisiensi jantung dalam memompa darah ke seluruh tubuh.\n\n'
          'Gejala Jantung Bocor\n\n'
          'Gejala jantung bocor dapat bervariasi tergantung pada tingkat keparahan kondisi. '
          'Beberapa gejala umum meliputi:\n'
          '- Nyeri dada\n'
          '- Kelelahan\n'
          '- Sesak napas\n'
          '- Detak jantung tidak teratur\n'
          '- Pembengkakan pada kaki atau pergelangan kaki\n'
          '- Pusing atau pingsan.'
    },
    {
      'title': 'Tanda-Tanda Jantung Bocor',
      'description': 'This article will look at this subject, providing a brief overview of this subject.',
      'image': 'images/malaria.png',
      'category': 'Jantung',
      'content': 'Tanda-tanda jantung bocor bisa beragam, termasuk nyeri dada, kelelahan, dan lainnya...\n\n'
          'Apa Itu Jantung Bocor?\n\n'
          'Jantung bocor adalah kondisi di mana ada kebocoran pada katup jantung. '
          'Kondisi ini dapat menyebabkan darah mengalir kembali ke jantung, '
          'mengurangi efisiensi jantung dalam memompa darah ke seluruh tubuh.\n\n'
          'Gejala Jantung Bocor\n\n'
          'Gejala jantung bocor dapat bervariasi tergantung pada tingkat keparahan kondisi. '
          'Beberapa gejala umum meliputi:\n'
          '- Nyeri dada\n'
          '- Kelelahan\n'
          '- Sesak napas\n'
          '- Detak jantung tidak teratur\n'
          '- Pembengkakan pada kaki atau pergelangan kaki\n'
          '- Pusing atau pingsan.'
    },
    {
      'title': 'Tanda-Tanda Jantung Bocor',
      'description': 'This article will look at this subject, providing a brief overview of this subject.',
      'image': 'images/hepatitis.png',
      'category': 'Ginjal',
      'content': 'Tanda-tanda jantung bocor bisa beragam, termasuk nyeri dada, kelelahan, dan lainnya...\n\n'
          'Apa Itu Jantung Bocor?\n\n'
          'Jantung bocor adalah kondisi di mana ada kebocoran pada katup jantung. '
          'Kondisi ini dapat menyebabkan darah mengalir kembali ke jantung, '
          'mengurangi efisiensi jantung dalam memompa darah ke seluruh tubuh.\n\n'
          'Gejala Jantung Bocor\n\n'
          'Gejala jantung bocor dapat bervariasi tergantung pada tingkat keparahan kondisi. '
          'Beberapa gejala umum meliputi:\n'
          '- Nyeri dada\n'
          '- Kelelahan\n'
          '- Sesak napas\n'
          '- Detak jantung tidak teratur\n'
          '- Pembengkakan pada kaki atau pergelangan kaki\n'
          '- Pusing atau pingsan.'
    },
    {
      'title': 'Tanda-Tanda Jantung Bocor',
      'description': 'This article will look at this subject, providing a brief overview of this subject.',
      'image': 'images/hepatitis.png',
      'category': 'THT',
      'content': 'Tanda-tanda jantung bocor bisa beragam, termasuk nyeri dada, kelelahan, dan lainnya...\n\n'
          'Apa Itu Jantung Bocor?\n\n'
          'Jantung bocor adalah kondisi di mana ada kebocoran pada katup jantung. '
          'Kondisi ini dapat menyebabkan darah mengalir kembali ke jantung, '
          'mengurangi efisiensi jantung dalam memompa darah ke seluruh tubuh.\n\n'
          'Gejala Jantung Bocor\n\n'
          'Gejala jantung bocor dapat bervariasi tergantung pada tingkat keparahan kondisi. '
          'Beberapa gejala umum meliputi:\n'
          '- Nyeri dada\n'
          '- Kelelahan\n'
          '- Sesak napas\n'
          '- Detak jantung tidak teratur\n'
          '- Pembengkakan pada kaki atau pergelangan kaki\n'
          '- Pusing atau pingsan.'
    },
    {
      'title': 'Tanda-Tanda Jantung Bocor',
      'description': 'This article will look at this subject, providing a brief overview of this subject.',
      'image': 'images/hepatitis.png',
      'category': 'Sariawan',
      'content': 'Tanda-tanda jantung bocor bisa beragam, termasuk nyeri dada, kelelahan, dan lainnya...\n\n'
          'Apa Itu Jantung Bocor?\n\n'
          'Jantung bocor adalah kondisi di mana ada kebocoran pada katup jantung. '
          'Kondisi ini dapat menyebabkan darah mengalir kembali ke jantung, '
          'mengurangi efisiensi jantung dalam memompa darah ke seluruh tubuh.\n\n'
          'Gejala Jantung Bocor\n\n'
          'Gejala jantung bocor dapat bervariasi tergantung pada tingkat keparahan kondisi. '
          'Beberapa gejala umum meliputi:\n'
          '- Nyeri dada\n'
          '- Kelelahan\n'
          '- Sesak napas\n'
          '- Detak jantung tidak teratur\n'
          '- Pembengkakan pada kaki atau pergelangan kaki\n'
          '- Pusing atau pingsan.'
    },
  ];

  void _onCategorySelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToDetail(String title, String imagePath, String content) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailArticlePage(
          title: title,
          imagePath: imagePath,
          content: content,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredArticles = _selectedIndex == 0
        ? articles
        : articles.where((article) => article['category'] == categories[_selectedIndex]).toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(categories.length, (index) {
                  return GestureDetector(
                    onTap: () => _onCategorySelected(index),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: _selectedIndex == index ? Colors.blue : Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: _selectedIndex == index ? Colors.white : Colors.grey[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredArticles.length,
                itemBuilder: (context, index) {
                  final article = filteredArticles[index];
                  return GestureDetector(
                    onTap: () => _navigateToDetail(
                      article['title']!,
                      article['image']!,
                      article['content']!,
                    ),
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                article['image']!,
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    article['title']!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    article['description']!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
