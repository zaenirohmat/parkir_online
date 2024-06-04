import 'package:flutter/material.dart';

enum Role { Admin, Service, ParkingAttendant }

class Profile {
  final String name;
  final String devisi;
  final String email;
  final String bio;
  final String photo;
  final Map<String, String> statistics;
  final List<Map<String, String>> recentActivities;

  Profile({
    required this.name,
    required this.devisi,
    required this.email,
    required this.bio,
    required this.photo,
    required this.statistics,
    required this.recentActivities,
  });
}

class ProfilePage extends StatelessWidget {
  final profiles = [
    Profile(
      name: 'M. QOIRUL SEN SEN',
      devisi: 'Admin',
      email: 'admin@example.com',
      bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      photo: 'gambar/ras.jpg',
      statistics: {'Posting': '100', 'Pengikut': '500', 'Mengikuti': '300'},
      recentActivities: [],
    ),
    Profile(
      name: "M. ZAENI ROHMAT ABIDIN",
      devisi: 'Service',
      email: 'service@example.com',
      bio: 'Sed ut perspiciatis unde omnis iste natus error sit voluptatem.',
      photo: 'gambar/rus.jpg',
      statistics: {'Posting': '50', 'Pengikut': '200', 'Mengikuti': '100'},
      recentActivities: [],
    ),
    Profile(
      name: "BAMBANG SETYO BUDI",
      devisi: 'Petugas Parkir',
      email: 'parking_attendant@example.com',
      bio: 'At vero eos et accusamus et iusto odio dignissimos ducimus.',
      photo: 'gambar/ris.jpg',
      statistics: {'Kendaraan Parkir': '80', 'Kendaraan Terdaftar': '150'},
      recentActivities: [],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: profiles.map((profile) {
            return ProfileWidget(profile: profile);
          }).toList(),
        ),
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  final Profile profile;

  const ProfileWidget({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(15.0),
      ),
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage(profile.photo),
          ),
          SizedBox(height: 20),
          Text(
            profile.name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            profile.devisi,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            profile.email,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 20),
          Divider(),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: profile.statistics.entries.map((entry) {
              return _buildStatistic(title: entry.key, value: entry.value);
            }).toList(),
          ),
          SizedBox(height: 20),
          Divider(),
          SizedBox(height: 20),
          Text(
            'Bio:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            profile.bio,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Tambahkan fungsi untuk mengedit profil
            },
            child: Text('Edit Profil'),
          ),
          SizedBox(height: 20),
          Divider(),
          SizedBox(height: 20),
          Text(
            'Aktivitas Terbaru:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Column(
            children: profile.recentActivities.map((activity) {
              return _buildRecentActivity(
                activity: activity['activity']!,
                timestamp: activity['timestamp']!,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatistic({required String title, required String value}) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivity(
      {required String activity, required String timestamp}) {
    return ListTile(
      title: Text(activity),
      subtitle: Text(timestamp),
      leading: Icon(Icons.history),
    );
  }
}
