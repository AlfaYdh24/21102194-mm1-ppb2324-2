import 'package:flutter/material.dart';

class LocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lokasi Polsek Terdekat'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
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
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                _buildLocationCard(
                  context,
                  'POLRES Banyumas',
                  '(0281) 622259',
                  'Jl. Letjen. Pol. R. Sumarto No.100, Purwanegara, Purwokerto, Banyumas, Jawa Tengah',
                ),
                _buildLocationCard(
                  context,
                  'Polsek Kalibagor',
                  '(0281) 6438189',
                  'G7GX+RX2, Dusun II Kalibagor, Kalibagor, Kec. Kalibagor, Kabupaten Banyumas, Jawa Tengah 53191',
                ),
                _buildLocationCard(
                  context,
                  'Polsek Somagede, Banyumas',
                  '(0281) 796640',
                  'Jl. Raya Banjarnegara - Banyumas, Somagede, Kec. Banyumas, Kabupaten Banyumas, Jawa Tengah 53193, Indonesia',
                ),
                _buildLocationCard(
                  context,
                  'Polsek Tambak, Banyumas',
                  '(0281) 472544',
                  'Jl. Raya Barat Tambak, Kamulyan, Tambak, Kabupaten Banyumas, Jawa Tengah 53196, Indonesia',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard(BuildContext context, String name, String phone, String address) {
    return GestureDetector(
      onTap: () {
        // Handle card tap
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 16.0),
        child: ListTile(
          contentPadding: EdgeInsets.all(16.0),
          leading: Image.asset(
            'images/polres.png', // Ensure you have this image in your assets
            height: 120, // Adjust the height as needed
            width: 70, // Adjust the width as needed
            fit: BoxFit.cover,
          ), // Ensure you have this image in your assets
          title: Text(name, style: TextStyle(color: Color(0xFF1C665E),fontWeight: FontWeight.bold)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: 8.0),
              Text(phone, style: TextStyle(color: Colors.blue)),
              // SizedBox(height: 8.0),
              Text(address),
            ],
          ),
        ),
      ),
    );
  }
}
