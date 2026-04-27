import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() => runApp(AlMurasilApp());

class AlMurasilApp extends StatefulWidget {
  @override
  _AlMurasilAppState createState() => _AlMurasilAppState();
}

class _AlMurasilAppState extends State<AlMurasilApp> {
  bool _isDarkMode = false;
  String _currentLanguage = 'Amharic';

  // ቋንቋ ለመቀየር (Localization Logic)
  final Map<String, Map<String, String>> _localized = {
    'English': {
      'title': 'Al-Murasil Hajj 🕋',
      'sub': 'Begin Your Spiritual Journey',
      'map': 'Map',
      'sites': 'Historical Sites',
      'sos': 'Emergency (SOS)',
      'health': 'Health Tracker',
    },
    'Amharic': {
      'title': 'አል-ሙራሲል ሐጅ 🕋',
      'sub': 'መንፈሳዊ ጉዞዎን ይጀምሩ',
      'map': 'ካርታ',
      'sites': 'ታሪካዊ ቦታዎች',
      'sos': 'አደጋ ጊዜ (SOS)',
      'health': 'የጤና ክትትል',
    },
    'Arabic': {
      'title': 'المراسل الحاج 🕋',
      'sub': 'ابدأ رحلتك الروحية',
      'map': 'خريطة',
      'sites': 'مواقع تاريخية',
      'sos': 'طوارئ (SOS)',
      'health': 'مراقب الصحة',
    }
  };

  void _toggleLanguage(String lang) {
    setState(() => _currentLanguage = lang);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? ThemeData.dark(useMaterial3: true) : ThemeData(primarySwatch: Colors.green, useMaterial3: true),
      home: HomePage(
        isDarkMode: _isDarkMode,
        onThemeChanged: (val) => setState(() => _isDarkMode = val),
        currentLang: _currentLanguage,
        onLangChanged: _toggleLanguage,
        text: _localized[_currentLanguage]!,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;
  final String currentLang;
  final Function(String) onLangChanged;
  final Map<String, String> text;

  HomePage({required this.isDarkMode, required this.onThemeChanged, required this.currentLang, required this.onLangChanged, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text['title']!),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => onThemeChanged(!isDarkMode),
          ),
          PopupMenuButton<String>(
            onSelected: onLangChanged,
            itemBuilder: (context) => [
              PopupMenuItem(value: 'Amharic', child: Text("አማርኛ")),
              PopupMenuItem(value: 'English', child: Text("English")),
              PopupMenuItem(value: 'Arabic', child: Text("العربية")),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green.shade700,
                image: DecorationImage(
                  image: NetworkImage('https://unsplash.com'),
                  fit: BoxFit.cover,
                  opacity: 0.4,
                ),
              ),
              child: Center(
                child: Text(text['sub']!, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              padding: EdgeInsets.all(15),
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              children: [
                _buildMenuCard(context, text['map']!, Icons.map, Colors.blue, () {}),
                _buildMenuCard(context, text['sites']!, Icons.history_edu, Colors.brown, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HistoricalSitesPage()));
                }),
                _buildMenuCard(context, text['sos']!, Icons.emergency, Colors.red, () => _showSOS(context)),
                _buildMenuCard(context, text['health']!, Icons.monitor_heart, Colors.orange, () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSOS(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("SOS Emergency", style: TextStyle(color: Colors.red)),
        content: Text("Do you want to call the group leader or medical emergency?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: Text("Call Now", style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 45, color: color),
            const SizedBox(height: 10),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class HistoricalSitesPage extends StatelessWidget {
  final FlutterTts flutterTts = FlutterTts();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Historical Sites"), backgroundColor: Colors.brown, foregroundColor: Colors.white),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          _siteCard("Kaaba", "The Holy house of Allah in Mecca.", "am-ET"),
          _siteCard("Arafat", "The site of the main Hajj ritual.", "am-ET"),
        ],
      ),
    );
  }

  Widget _siteCard(String name, String desc, String lang) {
    return Card(
      child: ListTile(
        title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(desc),
        trailing: IconButton(
          icon: Icon(Icons.volume_up, color: Colors.green),
          onPressed: () async {
            await flutterTts.setLanguage(lang);
            await flutterTts.speak(desc);
          },
        ),
      ),
    );
  }
}
