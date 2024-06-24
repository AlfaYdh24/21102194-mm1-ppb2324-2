import 'package:flutter/material.dart';
import 'detail_article_page.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {

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
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 24),
              _buildArticleCard(
                'Keselamatan Di Jalan Raya Ditentukan 5 Langkah Ini',
                'Maret 10, 2023 / OtoSpector',
                'images/news-3.png',
                '1. Pastikan kendaraan Anda dalam kondisi baik sebelum berkendara. \n'
                    '2. Selalu gunakan sabuk pengaman. \n'
                    '3. Patuhilah rambu-rambu lalu lintas dan batas kecepatan. \n'
                    '4. Hindari penggunaan ponsel saat berkendara. \n'
                    '5. Beristirahatlah jika merasa lelah atau mengantuk.',
              ),
              _buildArticleCard(
                '5 Tips Tetap Aman sebagai Pejalan Kaki',
                '22 Januari 2024 / Harness & Height',
                'images/news-2.png',
                '1. Gunakan trotoar atau jalur pejalan kaki jika tersedia. \n'
                    '2. Menyeberanglah di zebra cross atau tempat penyeberangan yang ditentukan. \n'
                    '3. Perhatikan lalu lintas di sekitar sebelum menyeberang. \n'
                    '4. Hindari penggunaan ponsel saat berjalan di dekat lalu lintas. \n'
                    '5. Gunakan pakaian yang cerah atau reflektif saat berjalan di malam hari.',
              ),
              _buildArticleCard(
                '7 Tips Bersepeda yang Aman Buat Pemula',
                'November 15, 2022 / rupa rupa',
                'images/news-1.png',
                '1. Gunakan helm yang sesuai dan pas di kepala. \n'
                    '2. Pastikan sepeda Anda dalam kondisi baik dan aman untuk digunakan. \n'
                    '3. Pelajari dan patuhi peraturan lalu lintas untuk pesepeda. \n'
                    '4. Gunakan pakaian yang nyaman dan sesuai untuk bersepeda. \n'
                    '5. Selalu waspada dan perhatikan kondisi jalan di sekitar. \n'
                    '6. Hindari mendengarkan musik dengan earphone saat bersepeda. \n'
                    '7. Bersepeda dengan kecepatan yang aman dan sesuai kemampuan.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArticleCard(String title, String subtitle, String assetPath, String content) {
    return GestureDetector(
      onTap: () => _navigateToDetail(title, assetPath, content),
      child: Card(
        color: Colors.amber,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  assetPath,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
