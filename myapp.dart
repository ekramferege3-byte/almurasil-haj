import 'package:flutter/material.dart';

void main() => runApp(AlMurasilApp());

class AlMurasilApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Al-Murasil Hajj - አል-ሙራሲል"),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.mosque, size: 100, color: Colors.green),
              SizedBox(height: 20),
              Text("እንኳን ደህና መጡ", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              Text("Hac Rehberine Hoş Geldiniz", style: TextStyle(fontSize: 18)),
              Text("مرحباً بكم في دليل الحج", style: TextStyle(fontSize: 20, color: Colors.green)),
              Text("Welcome to Hajj Guide", style: TextStyle(fontSize: 16)),
              SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {}, 
                child: Text("ዱዓዎችና ሀዲሶች / Hadisler", style: TextStyle(color: Colors.white))
              ),
            ],
          ),
        ),
      ),
    );
  }
}
simport 'package:flutter/material.dart';

void main() {
  runApp(const AlmurasilHajApp());
}

class AlmurasilHajApp extends StatelessWidget {
  const AlmurasilHajApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Almurasil-Haj',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Localization state
  String currentLanguage = 'English';

  final Map<String, Map<String, String>> localizedText = {
    'English': {
      'title': 'Hajj Guide',
      'health': 'Health Tracker',
      'voice': 'Voice Guide',
      'emergency': 'Emergency',
    },
    'Amharic': {
      'title': 'የሐጅ መመሪያ',
      'health': 'የጤና ክትትል',
      'voice': 'የድምፅ መመሪያ',
      'emergency': 'አደጋ ጊዜ',
    },
    'Arabic': {
      'title': 'دليل الحج',
      'health': 'مራقب الصحة',
      'voice': 'دليل صوتي',
      'emergency': 'طوارئ',
    },
    'Turkish': {
      'title': 'Hac Rehberi',
      'health': 'Sağlık Takibi',
      'voice': 'Sesli Rehber',
      'emergency': 'Acil Durum',
    },
  };

  void changeLanguage(String? lang) {
    if (lang != null) {
      setState(() {
        currentLanguage = lang;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var text = localizedText[currentLanguage]!;

    return Scaffold(
      appBar: AppBar(
        title: Text(text['title']!),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        actions: [
          DropdownButton<String>(
            value: currentLanguage,
            icon: const Icon(Icons.language, color: Colors.white),
            dropdownColor: Colors.green[600],
            underline: Container(),
            onChanged: changeLanguage,
            items: localizedText.keys.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: const TextStyle(color: Colors.white)),
              );
            }).toList(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildFeatureCard(Icons.health_and_safety, text['health']!, Colors.redAccent),
            _buildFeatureCard(Icons.record_voice_over, text['voice']!, Colors.blueAccent),
            _buildFeatureCard(Icons.mosque, 'Rituals', Colors.orangeAccent),
            _buildFeatureCard(Icons.phone_in_talk, text['emergency']!, Colors.deepPurple),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(IconData icon, String label, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: color),
            const SizedBox(height: 10),
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
