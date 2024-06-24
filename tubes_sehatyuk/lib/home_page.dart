import 'package:flutter/material.dart';
import 'package:tubes_sehatyuk/news_page.dart';
import 'routes.dart';
import 'detail_article_page.dart';
import 'location_page.dart'; // Import LocationPage
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _isLoading = false;
  late User _currentUser;
  late FirebaseFirestore _firestore;
  late FirebaseStorage _storage;

  String _displayName = '';
  String _phoneNumber = '';
  String _createdAt = '';
  String _profileImageUrl = '';

  @override
  void initState() {
    super.initState();
    _firestore = FirebaseFirestore.instance;
    _storage = FirebaseStorage.instance;
    _currentUser = FirebaseAuth.instance.currentUser!;
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      DocumentSnapshot<Map<String, dynamic>> userData = await _firestore.collection('users').doc(_currentUser.uid).get();
      if (userData.exists) {
        Timestamp createdAtTimestamp = userData.get('createdAt');
        setState(() {
          _displayName = userData.get('displayName') ?? userData.get('name');
          _phoneNumber = userData.get('phoneNumber') ?? '';
          _createdAt = DateFormat('dd-MM-yyyy').format(createdAtTimestamp.toDate());
          _profileImageUrl = userData.get('profileImageUrl') ?? '';
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onItemTapped(int index) {
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
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          SingleChildScrollView(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: _profileImageUrl.isNotEmpty
                            ? NetworkImage(_profileImageUrl)
                            : AssetImage('images/profile.png') as ImageProvider,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, $_displayName',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Good Morning',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.notifications),
                        onPressed: () {
                          // Handle notifications
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Image.asset(
                    'images/safety_tips.png', // Ensure this image is added in your project
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LocationPage()), // Navigate to LocationPage
                        );
                      },
                      child: Text('Lokasi Polsek Terdekat'),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(16),
                        backgroundColor: Colors.grey[200],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'News',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
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
          ...Routes.widgetOptions.sublist(1),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Location',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.blueGrey,
        backgroundColor: Colors.lightBlue,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildCheckUpCard(String title, String assetPath) {
    return GestureDetector(
      onTap: _navigateToCheckUpPage,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8.0),
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
        child: Column(
          children: [
            Image.asset(
              assetPath,
              height: 50,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToCheckUpPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsPage(),
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
